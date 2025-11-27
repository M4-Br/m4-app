class OnboardingBasicRegisterResponse {
  const OnboardingBasicRegisterResponse({
    required this.id,
    required this.email,
  });

  factory OnboardingBasicRegisterResponse.fromJson(Map<String, dynamic> json) {
    return OnboardingBasicRegisterResponse(
      id: json['individual_id'] as int,
      email: json['email'] as String,
    );
  }

  final int id;
  final String email;
}
