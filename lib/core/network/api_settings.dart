// Signature: dev.tswicolly03

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../database/database_providers.dart';

class ApiSettings {
  const ApiSettings({required this.baseUrl});

  static const legacyRemoteBaseUrl = 'https://tswicolly03.duckdns.org/api';

  static const defaultBaseUrl = String.fromEnvironment(
    'CAMPUSFLOW_API_BASE_URL',
    defaultValue: 'http://localhost:3333',
  );

  final String baseUrl;

  bool get hasServer => normalizedBaseUrl.isNotEmpty;

  String get normalizedBaseUrl => ApiSettings.normalizeBaseUrl(baseUrl);

  bool get isLocalServer {
    final uri = Uri.tryParse(normalizedBaseUrl);
    return uri != null &&
        (uri.host == 'localhost' ||
            uri.host == '127.0.0.1' ||
            uri.host == '::1');
  }

  static String normalizeBaseUrl(String value) {
    return value.trim().replaceFirst(RegExp(r'/+$'), '');
  }

  ApiSettings copyWith({String? baseUrl}) {
    return ApiSettings(baseUrl: baseUrl ?? this.baseUrl);
  }
}

class ApiSettingsController extends Notifier<ApiSettings> {
  static const baseUrlPreferenceKey = 'api_base_url';

  @override
  ApiSettings build() {
    final preferences = ref.watch(sharedPreferencesProvider);
    final savedBaseUrl = preferences.getString(baseUrlPreferenceKey);
    final baseUrl =
        ApiSettings.normalizeBaseUrl(savedBaseUrl ?? '') ==
            ApiSettings.legacyRemoteBaseUrl
        ? ApiSettings.defaultBaseUrl
        : savedBaseUrl ?? ApiSettings.defaultBaseUrl;
    return ApiSettings(baseUrl: ApiSettings.normalizeBaseUrl(baseUrl));
  }

  Future<void> update(ApiSettings settings) async {
    final preferences = ref.read(sharedPreferencesProvider);
    final normalized = ApiSettings.normalizeBaseUrl(settings.baseUrl);
    await preferences.setString(baseUrlPreferenceKey, normalized);
    state = settings.copyWith(baseUrl: normalized);
  }

  Future<void> resetToBuildDefault() {
    return update(const ApiSettings(baseUrl: ApiSettings.defaultBaseUrl));
  }
}

final apiSettingsControllerProvider =
    NotifierProvider<ApiSettingsController, ApiSettings>(
      ApiSettingsController.new,
    );
