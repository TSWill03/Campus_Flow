// Signature: dev.tswicolly03

class AuthActionResult {
  const AuthActionResult({
    required this.message,
    this.recoveryCode,
    this.createdAccount = false,
  });

  final String message;
  final String? recoveryCode;
  final bool createdAccount;
}
