import 'package:app_flutter_miban4/core/helpers/utils/app_enums.dart';

class OnboardingDocumentRegisterResponse {
  const OnboardingDocumentRegisterResponse({
    required this.id,
    required this.documentType,
  });

  factory OnboardingDocumentRegisterResponse.fromJson(
      Map<String, dynamic> json) {
    return OnboardingDocumentRegisterResponse(
      id: json['individual_id'] as int,
      documentType: DocumentType.values
          .firstWhere((e) => e.name.toUpperCase() == json['type']),
    );
  }

  final int id;
  final DocumentType documentType;
}
