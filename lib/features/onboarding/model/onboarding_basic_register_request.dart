class OnboardingBasicRegisterRequest {
  const OnboardingBasicRegisterRequest({
    required this.id,
    required this.fullName,
    required this.username,
    required this.email,
    required this.promotionalCode,
  });

  final int id;
  final String fullName;
  final String username;
  final String email;
  final String? promotionalCode;

  Map<String, dynamic> toJson() {
    return {
      'individual_id': id,
      'full_name': fullName,
      'username': username,
      'email': email,
      'promotional_code': promotionalCode,
    };
  }
}
