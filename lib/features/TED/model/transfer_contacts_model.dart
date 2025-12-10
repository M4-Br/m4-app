class TransferContactsModel {
  TransferContactsModel({
    this.name,
    this.document,
    this.username,
    this.bankCode,
    this.agency,
    this.agencyDigit,
    this.accountNumber,
    this.accountDigit,
    this.transferType,
  });

  String? name;
  String? document;
  String? username;
  String? bankCode;
  String? agency;
  String? agencyDigit;
  String? accountNumber;
  String? accountDigit;
  String? transferType;

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'document': document,
      'username': username,
      'bank_code': bankCode,
      'agency': agency,
      'agency_digit': agencyDigit,
      'account_number': accountNumber,
      'account_digit': accountDigit,
      'transfer_type': transferType,
    };
  }

  factory TransferContactsModel.fromJson(Map<String, dynamic> json) {
    return TransferContactsModel(
      name: json['name'] as String,
      document: json['document'] as String,
      username: json['username'] as String,
      bankCode: json['bank_code'] as String?,
      agency: json['agency'] as String?,
      agencyDigit: json['agency_digit'] as String?,
      accountNumber: json['account_number'] as String?,
      accountDigit: json['account_digit'] as String?,
      transferType: json['transfer_type'] as String?,
    );
  }
}
