// Signature: dev.tswicolly03

class GoogleAuthIdentity {
  const GoogleAuthIdentity({
    required this.email,
    required this.displayName,
    this.photoUrl,
    this.idToken,
  });

  final String email;
  final String displayName;
  final String? photoUrl;
  final String? idToken;
}
