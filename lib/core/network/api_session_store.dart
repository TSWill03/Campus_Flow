// Signature: dev.tswicolly03

import 'dart:convert';

import '../../features/auth/data/services/auth_secure_store.dart';

class ApiSession {
  const ApiSession({
    required this.accessToken,
    required this.refreshToken,
    required this.expiresAt,
  });

  final String accessToken;
  final String refreshToken;
  final DateTime expiresAt;

  bool get shouldRefresh =>
      DateTime.now().isAfter(expiresAt.subtract(const Duration(seconds: 60)));

  Map<String, dynamic> toJson() {
    return {
      'accessToken': accessToken,
      'refreshToken': refreshToken,
      'expiresAt': expiresAt.toIso8601String(),
    };
  }

  factory ApiSession.fromJson(Map<String, dynamic> json) {
    return ApiSession(
      accessToken: json['accessToken'] as String,
      refreshToken: json['refreshToken'] as String,
      expiresAt: DateTime.parse(json['expiresAt'] as String),
    );
  }
}

class ApiSessionStore {
  ApiSessionStore({
    required AuthSecureStore secureStore,
    String storageKey = 'campusflow.remote.session',
  }) : _secureStore = secureStore,
       _storageKey = storageKey;

  final AuthSecureStore _secureStore;
  final String _storageKey;

  Future<ApiSession?> read() async {
    final raw = await _secureStore.read(_storageKey);
    if (raw == null || raw.isEmpty) {
      return null;
    }
    return ApiSession.fromJson(jsonDecode(raw) as Map<String, dynamic>);
  }

  Future<void> write(ApiSession session) {
    return _secureStore.write(_storageKey, jsonEncode(session.toJson()));
  }

  Future<void> clear() => _secureStore.delete(_storageKey);
}
