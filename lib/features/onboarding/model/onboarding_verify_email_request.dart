class OnboardingVerifyEmailRequest {
  const OnboardingVerifyEmailRequest({
    required this.id,
    required this.fullName,
    required this.username,
    required this.email,
    required this.promotionalCode,
    required this.code,
  });

  final int id;
  final String fullName;
  final String username;
  final String email;
  final String? promotionalCode;
  final int code;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'full_name': fullName,
      'username': username,
      'email': email,
      'promotional_code': promotionalCode,
      'code': code
    };
  }
}
