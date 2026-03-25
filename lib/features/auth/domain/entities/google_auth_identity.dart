// Signature: dev.tswicolly03

class GoogleAuthIdentity {
  const GoogleAuthIdentity({
    required this.email,
    required this.displayName,
    this.photoUrl,
  });

  final String email;
  final String displayName;
  final String? photoUrl;
}
