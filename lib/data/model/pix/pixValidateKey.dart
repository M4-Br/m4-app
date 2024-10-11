class ValidateKey {
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

  ValidateKey({
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

  factory ValidateKey.fromJson(Map<String, dynamic> json) {
    return ValidateKey(
      success: json['success'],
      message: json['message'],
      ispb: json['ispb'],
      bankAccountNumber: json['bank_account_number'],
      bankBranchNumber: json['bank_branch_number'],
      bankAccountType: json['bank_account_type'],
      dateAccountCreated: json['date_account_created'],
      bankName: json['bank_name'],
      beneficiaryType: json['beneficiary_type'],
      nationalRegistration: json['national_registration'],
      name: json['name'],
      tradeName: json['trade_name'],
      key: json['key'],
      keyType: json['key_type'],
      dateKeyCreated: json['date_key_created'],
      dateKeyOwnership: json['date_key_ownership'],
      idEndToEnd: json['id_end_to_end'],
    );
  }
}
