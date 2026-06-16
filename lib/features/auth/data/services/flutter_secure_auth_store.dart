// Signature: dev.tswicolly03

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'auth_secure_store.dart';

class FlutterSecureAuthStore implements AuthSecureStore {
  FlutterSecureAuthStore({FlutterSecureStorage? storage})
    : _storage =
          storage ??
          const FlutterSecureStorage(
            aOptions: AndroidOptions(encryptedSharedPreferences: true),
          );

  final FlutterSecureStorage _storage;

  @override
  Future<void> delete(String key) => _storage.delete(key: key);

  @override
  Future<String?> read(String key) => _storage.read(key: key);

  @override
  Future<void> write(String key, String value) {
    return _storage.write(key: key, value: value);
  }
}
