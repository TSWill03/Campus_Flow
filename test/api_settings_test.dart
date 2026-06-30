// Signature: dev.tswicolly03

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:campus_flow/core/database/database_providers.dart';
import 'package:campus_flow/core/network/api_settings.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('ApiSettingsController', () {
    test('loads saved endpoint from SharedPreferences', () async {
      SharedPreferences.setMockInitialValues({
        'api_base_url': 'https://api.example.com/',
      });
      final preferences = await SharedPreferences.getInstance();
      final container = ProviderContainer(
        overrides: [sharedPreferencesProvider.overrideWithValue(preferences)],
      );
      addTearDown(container.dispose);

      final settings = container.read(apiSettingsControllerProvider);

      expect(settings.normalizedBaseUrl, 'https://api.example.com');
      expect(settings.hasServer, isTrue);
    });

    test('migrates the old remote default to the local fallback', () async {
      SharedPreferences.setMockInitialValues({
        'api_base_url': 'https://tswicolly03.duckdns.org/api',
      });
      final preferences = await SharedPreferences.getInstance();
      final container = ProviderContainer(
        overrides: [sharedPreferencesProvider.overrideWithValue(preferences)],
      );
      addTearDown(container.dispose);

      final settings = container.read(apiSettingsControllerProvider);

      expect(settings.normalizedBaseUrl, 'http://localhost:3333');
      expect(settings.isLocalServer, isTrue);
      expect(settings.hasServer, isTrue);
    });

    test('identifies local server endpoints', () {
      expect(
        const ApiSettings(baseUrl: 'http://localhost:3333').isLocalServer,
        isTrue,
      );
      expect(
        const ApiSettings(baseUrl: 'https://api.example.com').isLocalServer,
        isFalse,
      );
    });

    test(
      'saves the informed endpoint instead of forcing the default',
      () async {
        SharedPreferences.setMockInitialValues({});
        final preferences = await SharedPreferences.getInstance();
        final container = ProviderContainer(
          overrides: [sharedPreferencesProvider.overrideWithValue(preferences)],
        );
        addTearDown(container.dispose);

        await container
            .read(apiSettingsControllerProvider.notifier)
            .update(const ApiSettings(baseUrl: 'https://custom.example/api/'));

        final settings = container.read(apiSettingsControllerProvider);
        expect(settings.normalizedBaseUrl, 'https://custom.example/api');
        expect(
          preferences.getString('api_base_url'),
          'https://custom.example/api',
        );
      },
    );

    test('allows an explicit empty endpoint for local/offline mode', () async {
      SharedPreferences.setMockInitialValues({});
      final preferences = await SharedPreferences.getInstance();
      final container = ProviderContainer(
        overrides: [sharedPreferencesProvider.overrideWithValue(preferences)],
      );
      addTearDown(container.dispose);

      await container
          .read(apiSettingsControllerProvider.notifier)
          .update(const ApiSettings(baseUrl: '   '));

      final settings = container.read(apiSettingsControllerProvider);
      expect(settings.normalizedBaseUrl, isEmpty);
      expect(settings.hasServer, isFalse);
      expect(preferences.getString('api_base_url'), isEmpty);
    });
  });
}
