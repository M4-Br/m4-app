class OnboardingRegisterPhone {
  const OnboardingRegisterPhone({
    required this.id,
    required this.prefix,
    required this.phone,
  });

  final int id;
  final int prefix;
  final int phone;

  Map<String, dynamic> toJson() {
    return {
      'individual_id': id,
      'phone_prefix': prefix,
      'phone_number': phone,
    };
  }
}
