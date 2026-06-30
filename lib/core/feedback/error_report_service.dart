// Signature: dev.tswicolly03

import 'dart:async';
import 'dart:convert';

import 'package:cryptography/cryptography.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/auth/data/services/flutter_secure_auth_store.dart';
import '../error/app_exception.dart';
import '../network/api_session_store.dart';
import '../network/api_settings.dart';

enum ErrorReportType { crash, error, feedback, syncError, loginError }

enum ErrorReportSeverity { low, medium, high, critical }

extension ErrorReportTypeX on ErrorReportType {
  String get apiValue => switch (this) {
    ErrorReportType.crash => 'crash',
    ErrorReportType.error => 'error',
    ErrorReportType.feedback => 'feedback',
    ErrorReportType.syncError => 'sync_error',
    ErrorReportType.loginError => 'login_error',
  };

  String get label => switch (this) {
    ErrorReportType.crash => 'Crash ou fechamento inesperado',
    ErrorReportType.error => 'Erro no aplicativo',
    ErrorReportType.feedback => 'Feedback ou sugestao',
    ErrorReportType.syncError => 'Problema de sincronizacao',
    ErrorReportType.loginError => 'Problema de login',
  };
}

extension ErrorReportSeverityX on ErrorReportSeverity {
  String get apiValue => name;

  String get label => switch (this) {
    ErrorReportSeverity.low => 'Baixa',
    ErrorReportSeverity.medium => 'Media',
    ErrorReportSeverity.high => 'Alta',
    ErrorReportSeverity.critical => 'Critica',
  };
}

class ErrorReportPayload {
  const ErrorReportPayload({
    required this.type,
    required this.severity,
    required this.message,
    this.userDescription,
    this.stackTrace,
    this.platform,
    this.appVersion,
    this.buildNumber,
    this.route,
    this.deviceIdHash,
    this.extra,
  });

  final ErrorReportType type;
  final ErrorReportSeverity severity;
  final String message;
  final String? userDescription;
  final String? stackTrace;
  final String? platform;
  final String? appVersion;
  final String? buildNumber;
  final String? route;
  final String? deviceIdHash;
  final Map<String, Object?>? extra;

  Map<String, dynamic> toJson() {
    return {
      'type': type.apiValue,
      'severity': severity.apiValue,
      'message': _sanitizeString(message, 1000),
      if (userDescription != null)
        'userDescription': _sanitizeString(userDescription!, 4000),
      if (stackTrace != null) 'stackTrace': _sanitizeString(stackTrace!, 12000),
      if (platform != null) 'platform': _sanitizeString(platform!, 80),
      if (appVersion != null) 'appVersion': _sanitizeString(appVersion!, 40),
      if (buildNumber != null) 'buildNumber': _sanitizeString(buildNumber!, 40),
      if (route != null) 'route': _sanitizeString(route!, 240),
      if (deviceIdHash != null)
        'deviceIdHash': _sanitizeString(deviceIdHash!, 128),
      if (extra != null) 'extra': _sanitizeExtra(extra!),
    };
  }

  ErrorReportPayload copyWith({
    String? platform,
    String? appVersion,
    String? buildNumber,
    String? route,
    String? deviceIdHash,
    Map<String, Object?>? extra,
  }) {
    return ErrorReportPayload(
      type: type,
      severity: severity,
      message: message,
      userDescription: userDescription,
      stackTrace: stackTrace,
      platform: platform ?? this.platform,
      appVersion: appVersion ?? this.appVersion,
      buildNumber: buildNumber ?? this.buildNumber,
      route: route ?? this.route,
      deviceIdHash: deviceIdHash ?? this.deviceIdHash,
      extra: extra ?? this.extra,
    );
  }
}

class ErrorReportSendResult {
  const ErrorReportSendResult({this.reportId, this.queued = false});

  final String? reportId;
  final bool queued;
}

class ErrorReportService {
  ErrorReportService({
    required SharedPreferences sharedPreferences,
    required ApiSessionStore sessionStore,
    http.Client? httpClient,
    Duration requestTimeout = const Duration(seconds: 8),
  }) : _sharedPreferences = sharedPreferences,
       _sessionStore = sessionStore,
       _httpClient = httpClient ?? http.Client(),
       _requestTimeout = requestTimeout;

  static const queueKey = 'campusflow.error_report_queue';
  static const maxQueuedReports = 50;
  static const appVersion = String.fromEnvironment(
    'CAMPUSFLOW_APP_VERSION',
    defaultValue: '1.0.0',
  );
  static const buildNumber = String.fromEnvironment(
    'CAMPUSFLOW_BUILD_NUMBER',
    defaultValue: '1',
  );

  final SharedPreferences _sharedPreferences;
  final ApiSessionStore _sessionStore;
  final http.Client _httpClient;
  final Duration _requestTimeout;

  Future<ErrorReportSendResult> submitReport(
    ErrorReportPayload payload, {
    bool queueOnFailure = true,
  }) async {
    final prepared = await _withTechnicalContext(payload);
    try {
      final reportId = await _send(prepared);
      return ErrorReportSendResult(reportId: reportId);
    } catch (error) {
      if (!queueOnFailure) {
        rethrow;
      }
      await _enqueue(prepared);
      return const ErrorReportSendResult(queued: true);
    }
  }

  Future<int> flushQueuedReports() async {
    final queued = _readQueue();
    if (queued.isEmpty || !_currentSettings().hasServer) {
      return 0;
    }

    final remaining = <Map<String, dynamic>>[];
    var sent = 0;
    for (final item in queued) {
      try {
        await _sendRaw(item);
        sent++;
      } catch (_) {
        remaining.add(item);
      }
    }
    await _writeQueue(remaining);
    return sent;
  }

  Future<int> queuedReportCount() async => _readQueue().length;

  Future<String> technicalSummary({String? route}) async {
    final settings = _currentSettings();
    return const JsonEncoder.withIndent('  ').convert({
      'apiBaseUrl': settings.hasServer ? settings.normalizedBaseUrl : 'offline',
      'platform': _platformLabel(),
      'appVersion': appVersion,
      'buildNumber': buildNumber,
      'route': route,
      'queuedReports': _readQueue().length,
      'deviceIdHash': await _deviceIdHash(),
    });
  }

  Future<void> captureUnhandledError(
    Object error,
    StackTrace stackTrace, {
    ErrorReportType type = ErrorReportType.crash,
    String? route,
  }) async {
    await submitReport(
      ErrorReportPayload(
        type: type,
        severity: ErrorReportSeverity.high,
        message: error.toString(),
        stackTrace: stackTrace.toString(),
        route: route,
        extra: const {'source': 'global_error_handler'},
      ),
    );
  }

  Future<ErrorReportPayload> _withTechnicalContext(
    ErrorReportPayload payload,
  ) async {
    return payload.copyWith(
      platform: payload.platform ?? _platformLabel(),
      appVersion: payload.appVersion ?? appVersion,
      buildNumber: payload.buildNumber ?? buildNumber,
      deviceIdHash: payload.deviceIdHash ?? await _deviceIdHash(),
    );
  }

  Future<String> _send(ErrorReportPayload payload) {
    return _sendRaw(payload.toJson());
  }

  Future<String> _sendRaw(Map<String, dynamic> payload) async {
    final settings = _currentSettings();
    if (!settings.hasServer) {
      throw const AppException('Nenhum endpoint de API configurado.');
    }

    final headers = <String, String>{
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    final session = await _sessionStore.read();
    if (session != null && !session.shouldRefresh) {
      headers['Authorization'] = 'Bearer ${session.accessToken}';
    }

    final response = await _httpClient
        .post(
          Uri.parse('${settings.normalizedBaseUrl}/feedback/report'),
          headers: headers,
          body: jsonEncode(payload),
        )
        .timeout(_requestTimeout);

    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw AppException(_extractErrorMessage(response));
    }

    final decoded = jsonDecode(response.body);
    if (decoded is! Map<String, dynamic> || decoded['reportId'] is! String) {
      throw const AppException('Resposta invalida ao enviar feedback.');
    }
    return decoded['reportId'] as String;
  }

  Future<void> _enqueue(ErrorReportPayload payload) async {
    final queued = _readQueue();
    queued.add(payload.toJson());
    final trimmed = queued.length > maxQueuedReports
        ? queued.sublist(queued.length - maxQueuedReports)
        : queued;
    await _writeQueue(trimmed);
  }

  List<Map<String, dynamic>> _readQueue() {
    final raw = _sharedPreferences.getString(queueKey);
    if (raw == null || raw.isEmpty) {
      return <Map<String, dynamic>>[];
    }
    try {
      final decoded = jsonDecode(raw);
      if (decoded is! List) {
        return <Map<String, dynamic>>[];
      }
      return decoded
          .whereType<Map>()
          .map((item) => Map<String, dynamic>.from(item))
          .toList();
    } catch (_) {
      return <Map<String, dynamic>>[];
    }
  }

  Future<void> _writeQueue(List<Map<String, dynamic>> queue) {
    return _sharedPreferences.setString(queueKey, jsonEncode(queue));
  }

  ApiSettings _currentSettings() {
    final saved = _sharedPreferences.getString(
      ApiSettingsController.baseUrlPreferenceKey,
    );
    final baseUrl =
        ApiSettings.normalizeBaseUrl(saved ?? '') ==
            ApiSettings.legacyRemoteBaseUrl
        ? ApiSettings.defaultBaseUrl
        : saved ?? ApiSettings.defaultBaseUrl;
    return ApiSettings(baseUrl: ApiSettings.normalizeBaseUrl(baseUrl));
  }

  Future<String?> _deviceIdHash() async {
    final deviceId = _sharedPreferences.getString('sync_device_id');
    if (deviceId == null || deviceId.isEmpty) {
      return null;
    }
    final hash = await Sha256().hash(utf8.encode(deviceId));
    return hash.bytes
        .map((byte) => byte.toRadixString(16).padLeft(2, '0'))
        .join();
  }
}

class GlobalErrorReporter {
  static ErrorReportService? _service;

  static void attach(ErrorReportService service) {
    _service = service;
  }

  static void capture(Object error, StackTrace stackTrace) {
    final service = _service;
    if (service == null) {
      return;
    }
    unawaited(service.captureUnhandledError(error, stackTrace));
  }

  static void captureFlutterError(FlutterErrorDetails details) {
    final service = _service;
    if (service == null) {
      return;
    }
    unawaited(
      service.submitReport(
        ErrorReportPayload(
          type: ErrorReportType.error,
          severity: ErrorReportSeverity.high,
          message: details.exceptionAsString(),
          stackTrace: details.stack?.toString(),
          extra: {
            'library': details.library,
            'context': details.context?.toString(),
            'source': 'flutter_error_handler',
          },
        ),
      ),
    );
  }
}

ErrorReportService createGlobalErrorReportService(
  SharedPreferences sharedPreferences,
) {
  return ErrorReportService(
    sharedPreferences: sharedPreferences,
    sessionStore: ApiSessionStore(secureStore: FlutterSecureAuthStore()),
  );
}

String _platformLabel() {
  if (kIsWeb) {
    return 'web';
  }
  return defaultTargetPlatform.name;
}

String _sanitizeString(String value, int maxLength) {
  final redacted = value
      .replaceAll(RegExp(r'Bearer\s+[A-Za-z0-9._~+/=-]+'), 'Bearer [REDACTED]')
      .replaceAll(
        RegExp(
          r'\b(accessToken|refreshToken|password|senha|token|secret)\b\s*[:=]\s*[^,\s}]+',
        ),
        '[REDACTED]',
      )
      .trim();
  if (redacted.length <= maxLength) {
    return redacted;
  }
  return '${redacted.substring(0, maxLength)}...[truncated]';
}

Object? _sanitizeExtra(Object? value, [int depth = 0]) {
  if (depth > 4) {
    return '[truncated-depth]';
  }
  if (value is String) {
    return _sanitizeString(value, 500);
  }
  if (value == null || value is num || value is bool) {
    return value;
  }
  if (value is List) {
    return value
        .take(20)
        .map((item) => _sanitizeExtra(item, depth + 1))
        .toList();
  }
  if (value is Map) {
    final sanitized = <String, Object?>{};
    for (final entry in value.entries.take(30)) {
      final key = entry.key.toString();
      sanitized[_sanitizeString(key, 80)] =
          RegExp(
            r'(password|senha|token|authorization|cookie|secret|api[_-]?key|refresh)',
            caseSensitive: false,
          ).hasMatch(key)
          ? '[REDACTED]'
          : _sanitizeExtra(entry.value, depth + 1);
    }
    return sanitized;
  }
  return value.toString();
}

String _extractErrorMessage(http.Response response) {
  try {
    final decoded = jsonDecode(response.body);
    if (decoded is Map<String, dynamic>) {
      return decoded['message'] as String? ??
          decoded['error'] as String? ??
          'Nao foi possivel enviar o relatorio.';
    }
  } catch (_) {
    // Proxies podem devolver HTML/texto.
  }
  return 'Nao foi possivel enviar o relatorio (${response.statusCode}).';
}
