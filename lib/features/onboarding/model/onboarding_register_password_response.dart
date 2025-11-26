import 'package:app_flutter_miban4/core/helpers/utils/app_enums.dart';

class OnboardingRegisterPasswordResponse {
  const OnboardingRegisterPasswordResponse({
    required this.id,
    required this.name,
    required this.email,
    required this.document,
    required this.status,
    required this.individualId,
  });

  factory OnboardingRegisterPasswordResponse.fromJson(
      Map<String, dynamic> json) {
    return OnboardingRegisterPasswordResponse(
      id: json['individual_id'] as int,
      name: json['name'] as String,
      email: json['email'] as String,
      document: json['document'] as String,
      status: AccountStatus.values.byName(json['status'] as String),
      individualId: json['individual_id'] as int,
    );
  }

  final int id;
  final String name;
  final String email;
  final String document;
  final AccountStatus status;
  final int individualId;
}
