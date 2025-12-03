class PixValidateKeyResponse {
  final bool success;
  final String message;
  final String ispb;
  final String bankAccountNumber;
  final String bankBranchNumber;
  final String bankAccountType;
  final String dateAccountCreated;
  final String bankName;
  final String beneficiaryType;
  final String nationalRegistration;
  final String name;
  final String tradeName;
  final String key;
  final String? keyType;
  final String dateKeyCreated;
  final String dateKeyOwnership;
  final String idEndToEnd;

  PixValidateKeyResponse({
    required this.success,
    required this.message,
    required this.ispb,
    required this.bankAccountNumber,
    required this.bankBranchNumber,
    required this.bankAccountType,
    required this.dateAccountCreated,
    required this.bankName,
    required this.beneficiaryType,
    required this.nationalRegistration,
    required this.name,
    required this.tradeName,
    required this.key,
    this.keyType,
    required this.dateKeyCreated,
    required this.dateKeyOwnership,
    required this.idEndToEnd,
  });

  factory PixValidateKeyResponse.fromJson(Map<String, dynamic> json) {
    return PixValidateKeyResponse(
      success: json['success'] as bool,
      message: json['message'] as String,
      ispb: json['ispb'] as String,
      bankAccountNumber: json['bank_account_number'] as String,
      bankBranchNumber: json['bank_branch_number'] as String,
      bankAccountType: json['bank_account_type'] as String,
      dateAccountCreated: json['date_account_created'] as String,
      bankName: json['bank_name'] as String,
      beneficiaryType: json['beneficiary_type'] as String,
      nationalRegistration: json['national_registration'] as String,
      name: json['name'] as String,
      tradeName: json['trade_name'] as String,
      key: json['key'] as String,
      keyType: json['key_type'] as String,
      dateKeyCreated: json['date_key_created'] as String,
      dateKeyOwnership: json['date_key_ownership'] as String,
      idEndToEnd: json['id_end_to_end'] as String,
    );
  }
}
