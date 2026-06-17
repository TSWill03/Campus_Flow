// Signature: dev.tswicolly03

import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../error/app_exception.dart';
import 'api_session_store.dart';
import 'api_settings.dart';

class ApiClient {
  ApiClient({
    required ApiSettings settings,
    required ApiSessionStore sessionStore,
    http.Client? httpClient,
    Duration requestTimeout = const Duration(seconds: 12),
  }) : _settings = settings,
       _sessionStore = sessionStore,
       _httpClient = httpClient ?? http.Client(),
       _requestTimeout = requestTimeout;

  final ApiSettings _settings;
  final ApiSessionStore _sessionStore;
  final http.Client _httpClient;
  final Duration _requestTimeout;

  Future<Map<String, dynamic>> get(
    String path, {
    bool authenticated = true,
    Map<String, String>? queryParameters,
  }) async {
    final response = await _send(
      () async => _httpClient.get(
        _uri(path, queryParameters: queryParameters),
        headers: await _headers(authenticated: authenticated),
      ),
      authenticated: authenticated,
    );
    return _decodeObject(response);
  }

  Future<Map<String, dynamic>> post(
    String path, {
    bool authenticated = true,
    Map<String, dynamic>? body,
  }) async {
    final response = await _send(
      () async => _httpClient.post(
        _uri(path),
        headers: await _headers(authenticated: authenticated),
        body: jsonEncode(body ?? const <String, dynamic>{}),
      ),
      authenticated: authenticated,
    );
    return _decodeObject(response);
  }

  Future<http.Response> _send(
    Future<http.Response> Function() request, {
    required bool authenticated,
  }) async {
    _ensureConfigured();

    var response = await _performRequest(request);
    // Se o access token venceu, o client tenta renovar usando refresh token e
    // repete a chamada uma vez. A tela nao precisa conhecer esse detalhe.
    if (authenticated && response.statusCode == 401) {
      final refreshed = await _refreshSession();
      if (refreshed) {
        response = await _performRequest(request);
      }
    }

    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw AppException(_extractErrorMessage(response));
    }
    return response;
  }

  Future<Map<String, String>> _headers({required bool authenticated}) async {
    final headers = <String, String>{
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    if (authenticated) {
      final session = await _validSession();
      headers['Authorization'] = 'Bearer ${session.accessToken}';
    }
    return headers;
  }

  Future<ApiSession> _validSession() async {
    final session = await _sessionStore.read();
    if (session == null) {
      throw const AppException('Entre na conta do servidor para continuar.');
    }
    if (!session.shouldRefresh) {
      return session;
    }
    final refreshed = await _refreshSession();
    final next = await _sessionStore.read();
    if (!refreshed || next == null) {
      throw const AppException('Sua sessao expirou. Entre novamente.');
    }
    return next;
  }

  Future<bool> _refreshSession() async {
    final session = await _sessionStore.read();
    if (session == null) {
      return false;
    }

    final response = await _performRequest(
      () => _httpClient.post(
        _uri('/auth/refresh'),
        headers: const {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({'refreshToken': session.refreshToken}),
      ),
    );
    if (response.statusCode < 200 || response.statusCode >= 300) {
      await _sessionStore.clear();
      return false;
    }

    final decoded = _decodeObject(response);
    await _sessionStore.write(_sessionFromAuthResponse(decoded));
    return true;
  }

  Future<http.Response> _performRequest(
    Future<http.Response> Function() request,
  ) async {
    try {
      return await request().timeout(_requestTimeout);
    } on TimeoutException {
      throw const AppException(
        'O servidor demorou para responder. Tente novamente em instantes.',
      );
    } on FormatException {
      throw const AppException(
        'A URL do servidor e invalida. Confira o endpoint em Ajustes.',
      );
    } on http.ClientException {
      throw const AppException(
        'Nao foi possivel conectar ao servidor do CampusFlow. '
        'Verifique sua internet, HTTPS e se a API esta online.',
      );
    } on AppException {
      rethrow;
    } catch (_) {
      throw const AppException(
        'Nao foi possivel comunicar com o servidor do CampusFlow.',
      );
    }
  }

  Uri _uri(String path, {Map<String, String>? queryParameters}) {
    final normalizedPath = path.startsWith('/') ? path : '/$path';
    return Uri.parse(
      '${_settings.normalizedBaseUrl}$normalizedPath',
    ).replace(queryParameters: queryParameters);
  }

  void _ensureConfigured() {
    if (!_settings.hasServer) {
      throw const AppException(
        'Configure a URL do servidor antes de usar a sincronizacao.',
      );
    }
  }
}

ApiSession sessionFromAuthResponse(Map<String, dynamic> decoded) {
  return _sessionFromAuthResponse(decoded);
}

ApiSession _sessionFromAuthResponse(Map<String, dynamic> decoded) {
  final tokens = decoded['tokens'] as Map<String, dynamic>;
  final expiresIn = tokens['expiresIn'] as int;
  return ApiSession(
    accessToken: tokens['accessToken'] as String,
    refreshToken: tokens['refreshToken'] as String,
    expiresAt: DateTime.now().add(Duration(seconds: expiresIn)),
  );
}

Map<String, dynamic> _decodeObject(http.Response response) {
  if (response.body.isEmpty) {
    return <String, dynamic>{};
  }
  final Object? decoded;
  try {
    decoded = jsonDecode(response.body);
  } on FormatException {
    throw const AppException(
      'Resposta invalida do servidor. Confira se a URL aponta para a API '
      'do CampusFlow e nao para uma pagina HTML.',
    );
  }
  if (decoded is! Map<String, dynamic>) {
    throw const AppException('Resposta invalida do servidor.');
  }
  return decoded;
}

String _extractErrorMessage(http.Response response) {
  try {
    final decoded = jsonDecode(response.body);
    if (decoded is Map<String, dynamic>) {
      return decoded['message'] as String? ??
          decoded['error'] as String? ??
          'Falha na comunicacao com o servidor.';
    }
  } catch (_) {
    // O corpo pode nao ser JSON em erros de proxy ou servidor.
  }
  return 'Falha no servidor (${response.statusCode}).';
}
