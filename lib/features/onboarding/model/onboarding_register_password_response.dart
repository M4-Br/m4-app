import 'package:app_flutter_miban4/core/helpers/utils/app_enums.dart';

class OnboardingRegisterPasswordResponse {
  const OnboardingRegisterPasswordResponse({
    required this.id,
    required this.name,
    required this.email,
    required this.document,
    required this.avatar,
    required this.status,
    required this.individualId,
    required this.activeAccount,
    required this.companyId,
  });

  factory OnboardingRegisterPasswordResponse.fromJson(
      Map<String, dynamic> json) {
    return OnboardingRegisterPasswordResponse(
      id: json['id'] as int,
      name: json['name'] as String,
      email: json['email'] as String,
      document: json['document'] as String,
      avatar: json['avatar'] as String?,
      status: AccountStatus.values.byName(json['status'] as String),
      individualId: json['individual_id'] as int,
      activeAccount: json['active_account'] as bool?,
      companyId: json['company_id'] as int,
    );
  }

  final int id;
  final String name;
  final String email;
  final String document;
  final String? avatar;
  final AccountStatus status;
  final int individualId;
  final bool? activeAccount;
  final int companyId;
}
