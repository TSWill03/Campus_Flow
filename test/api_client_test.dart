// Signature: dev.tswicolly03

import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';

import 'package:campus_flow/core/error/app_exception.dart';
import 'package:campus_flow/core/network/api_client.dart';
import 'package:campus_flow/core/network/api_session_store.dart';
import 'package:campus_flow/core/network/api_settings.dart';

import 'test_harness.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('ApiClient', () {
    test(
      'refreshes expired session and retries authenticated request',
      () async {
        final secureStore = MemoryAuthSecureStore();
        final sessionStore = ApiSessionStore(secureStore: secureStore);
        await sessionStore.write(
          ApiSession(
            accessToken: 'old-token',
            refreshToken: 'refresh-token',
            expiresAt: DateTime.now().subtract(const Duration(minutes: 1)),
          ),
        );

        final seenAuthorizations = <String?>[];
        final client = ApiClient(
          settings: const ApiSettings(baseUrl: 'https://example.com/api'),
          sessionStore: sessionStore,
          httpClient: MockClient((request) async {
            if (request.url.path == '/api/auth/refresh') {
              return http.Response(
                jsonEncode({
                  'tokens': {
                    'accessToken': 'new-token',
                    'refreshToken': 'new-refresh',
                    'expiresIn': 900,
                  },
                }),
                200,
              );
            }

            seenAuthorizations.add(request.headers['Authorization']);
            return http.Response(jsonEncode({'ok': true}), 200);
          }),
        );

        final response = await client.get('/protected');
        final storedSession = await sessionStore.read();

        expect(response['ok'], isTrue);
        expect(seenAuthorizations, ['Bearer new-token']);
        expect(storedSession?.accessToken, 'new-token');
      },
    );

    test('throws friendly server message on non-success response', () async {
      final secureStore = MemoryAuthSecureStore();
      final client = ApiClient(
        settings: const ApiSettings(baseUrl: 'https://example.com/api'),
        sessionStore: ApiSessionStore(secureStore: secureStore),
        httpClient: MockClient(
          (_) async => http.Response(
            jsonEncode({'message': 'Falha validada pelo servidor.'}),
            409,
          ),
        ),
      );

      expect(
        () => client.post('/auth/register', authenticated: false),
        throwsA(
          isA<AppException>().having(
            (error) => error.message,
            'message',
            'Falha validada pelo servidor.',
          ),
        ),
      );
    });
  });
}
