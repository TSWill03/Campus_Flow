// Signature: dev.tswicolly03

import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:campus_flow/core/feedback/error_report_service.dart';
import 'package:campus_flow/core/network/api_session_store.dart';
import 'package:campus_flow/core/network/api_settings.dart';

import 'test_harness.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('ErrorReportService', () {
    test(
      'sends reports to the configured backend with optional auth',
      () async {
        SharedPreferences.setMockInitialValues({
          ApiSettingsController.baseUrlPreferenceKey: 'https://example.com/api',
          'sync_device_id': 'device-123',
        });
        final preferences = await SharedPreferences.getInstance();
        final secureStore = MemoryAuthSecureStore();
        final sessionStore = ApiSessionStore(secureStore: secureStore);
        await sessionStore.write(
          ApiSession(
            accessToken: 'access-token',
            refreshToken: 'refresh-token',
            expiresAt: DateTime.now().add(const Duration(minutes: 10)),
          ),
        );

        final service = ErrorReportService(
          sharedPreferences: preferences,
          sessionStore: sessionStore,
          httpClient: MockClient((request) async {
            expect(
              request.url.toString(),
              'https://example.com/api/feedback/report',
            );
            expect(request.headers['Authorization'], 'Bearer access-token');
            final body = jsonDecode(request.body) as Map<String, dynamic>;
            expect(body['type'], 'feedback');
            expect(body['deviceIdHash'], isA<String>());
            expect(body.containsKey('refreshToken'), isFalse);
            return http.Response(jsonEncode({'reportId': 'report-1'}), 200);
          }),
        );

        final result = await service.submitReport(
          const ErrorReportPayload(
            type: ErrorReportType.feedback,
            severity: ErrorReportSeverity.medium,
            message: 'Feedback manual',
          ),
        );

        expect(result.reportId, 'report-1');
        expect(result.queued, isFalse);
      },
    );

    test('queues automatic reports when sending fails', () async {
      SharedPreferences.setMockInitialValues({
        ApiSettingsController.baseUrlPreferenceKey: 'https://example.com/api',
      });
      final preferences = await SharedPreferences.getInstance();
      final service = ErrorReportService(
        sharedPreferences: preferences,
        sessionStore: ApiSessionStore(secureStore: MemoryAuthSecureStore()),
        httpClient: MockClient(
          (_) async => throw http.ClientException('offline'),
        ),
      );

      final result = await service.submitReport(
        const ErrorReportPayload(
          type: ErrorReportType.crash,
          severity: ErrorReportSeverity.high,
          message: 'Unhandled exception',
          stackTrace: 'Bearer secret-token',
        ),
      );

      final rawQueue = preferences.getString(ErrorReportService.queueKey);
      expect(result.queued, isTrue);
      expect(rawQueue, isNotNull);
      expect(rawQueue, contains('Bearer [REDACTED]'));
      expect(await service.queuedReportCount(), 1);
    });
  });
}
