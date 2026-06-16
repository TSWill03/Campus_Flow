// Signature: dev.tswicolly03

import 'dart:convert';

import 'package:cryptography/cryptography.dart';
import 'package:uuid/uuid.dart';

class PasswordHasher {
  PasswordHasher({Pbkdf2? algorithm, Uuid? uuid})
    : _algorithm =
          algorithm ??
          Pbkdf2(macAlgorithm: Hmac.sha256(), iterations: 120000, bits: 256),
      _uuid = uuid ?? const Uuid();

  final Pbkdf2 _algorithm;
  final Uuid _uuid;

  String generateSalt() => _uuid.v4();

  String generateRecoveryCode() {
    final raw = _uuid.v4().replaceAll('-', '').toUpperCase();
    return 'CF-${raw.substring(0, 4)}-${raw.substring(4, 8)}-'
        '${raw.substring(8, 12)}-${raw.substring(12, 16)}';
  }

  Future<String> hash({required String value, required String salt}) async {
    final key = await _algorithm.deriveKey(
      secretKey: SecretKey(utf8.encode(value)),
      nonce: utf8.encode(salt),
    );
    final bytes = await key.extractBytes();
    return base64UrlEncode(bytes);
  }

  String normalizeEmail(String email) => email.trim().toLowerCase();

  String normalizeRecoveryCode(String recoveryCode) {
    return recoveryCode.trim().toUpperCase().replaceAll(' ', '');
  }
}
