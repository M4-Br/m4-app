class OnboardingOneRequest {
  const OnboardingOneRequest({
    required this.name,
    required this.email,
    required this.document,
    required this.phonePrefix,
    required this.phone,
  });

  final String name;
  final String email;
  final String document;
  final String phonePrefix;
  final String phone;

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'document': document,
      'phone_prefix': phonePrefix,
      'phone': phone,
    };
  }
}
