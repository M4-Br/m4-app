class OnboardingVerifyPhoneRequest {
  const OnboardingVerifyPhoneRequest({
    required this.id,
    required this.prefix,
    required this.phone,
    required this.code,
  });

  final int id;
  final int prefix;
  final int phone;
  final int code;

  Map<String, dynamic> toJson() {
    return {
      'individual_id': id,
      'phone_prefix': prefix,
      'phone_number': phone,
      'code': code,
    };
  }
}
