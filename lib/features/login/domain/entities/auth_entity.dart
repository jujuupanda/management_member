class AuthEntity {
  final String username;
  final String password;
  final String role;
  final String jwtToken;
  final String fcmToken;

  const AuthEntity({
    required this.username,
    required this.password,
    required this.role,
    required this.jwtToken,
    required this.fcmToken,
  });
}
