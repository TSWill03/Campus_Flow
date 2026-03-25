// Signature: dev.tswicolly03

enum AuthSignInMethod {
  password,
  google,
}

class AuthSession {
  const AuthSession({
    required this.userId,
    required this.signedInAt,
    required this.method,
  });

  final String userId;
  final DateTime signedInAt;
  final AuthSignInMethod method;

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'signedInAt': signedInAt.toIso8601String(),
      'method': method.name,
    };
  }

  factory AuthSession.fromJson(Map<String, dynamic> json) {
    return AuthSession(
      userId: json['userId'] as String,
      signedInAt: DateTime.parse(json['signedInAt'] as String),
      method: AuthSignInMethod.values.firstWhere(
        (value) => value.name == json['method'],
        orElse: () => AuthSignInMethod.password,
      ),
    );
  }
}
