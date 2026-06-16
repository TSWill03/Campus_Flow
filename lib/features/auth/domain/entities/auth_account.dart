// Signature: dev.tswicolly03

class AuthAccount {
  const AuthAccount({
    required this.id,
    required this.email,
    required this.displayName,
    required this.recoveryCodeHash,
    required this.recoveryCodeSalt,
    required this.createdAt,
    required this.updatedAt,
    this.passwordHash,
    this.passwordSalt,
    this.linkedGoogleEmail,
    this.linkedGoogleDisplayName,
    this.photoUrl,
  });

  final String id;
  final String email;
  final String displayName;
  final String? passwordHash;
  final String? passwordSalt;
  final String recoveryCodeHash;
  final String recoveryCodeSalt;
  final String? linkedGoogleEmail;
  final String? linkedGoogleDisplayName;
  final String? photoUrl;
  final DateTime createdAt;
  final DateTime updatedAt;

  bool get hasPassword =>
      (passwordHash?.isNotEmpty ?? false) &&
      (passwordSalt?.isNotEmpty ?? false);

  bool get isGoogleLinked => linkedGoogleEmail?.trim().isNotEmpty ?? false;

  AuthAccount copyWith({
    String? id,
    String? email,
    String? displayName,
    String? passwordHash,
    String? passwordSalt,
    bool clearPassword = false,
    String? recoveryCodeHash,
    String? recoveryCodeSalt,
    String? linkedGoogleEmail,
    String? linkedGoogleDisplayName,
    String? photoUrl,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return AuthAccount(
      id: id ?? this.id,
      email: email ?? this.email,
      displayName: displayName ?? this.displayName,
      passwordHash: clearPassword ? null : passwordHash ?? this.passwordHash,
      passwordSalt: clearPassword ? null : passwordSalt ?? this.passwordSalt,
      recoveryCodeHash: recoveryCodeHash ?? this.recoveryCodeHash,
      recoveryCodeSalt: recoveryCodeSalt ?? this.recoveryCodeSalt,
      linkedGoogleEmail: linkedGoogleEmail ?? this.linkedGoogleEmail,
      linkedGoogleDisplayName:
          linkedGoogleDisplayName ?? this.linkedGoogleDisplayName,
      photoUrl: photoUrl ?? this.photoUrl,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'displayName': displayName,
      'passwordHash': passwordHash,
      'passwordSalt': passwordSalt,
      'recoveryCodeHash': recoveryCodeHash,
      'recoveryCodeSalt': recoveryCodeSalt,
      'linkedGoogleEmail': linkedGoogleEmail,
      'linkedGoogleDisplayName': linkedGoogleDisplayName,
      'photoUrl': photoUrl,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  factory AuthAccount.fromJson(Map<String, dynamic> json) {
    return AuthAccount(
      id: json['id'] as String,
      email: json['email'] as String,
      displayName: json['displayName'] as String? ?? 'Usuario',
      passwordHash: json['passwordHash'] as String?,
      passwordSalt: json['passwordSalt'] as String?,
      recoveryCodeHash: json['recoveryCodeHash'] as String,
      recoveryCodeSalt: json['recoveryCodeSalt'] as String,
      linkedGoogleEmail: json['linkedGoogleEmail'] as String?,
      linkedGoogleDisplayName: json['linkedGoogleDisplayName'] as String?,
      photoUrl: json['photoUrl'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }
}
