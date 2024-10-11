class Ted {
  bool? success;
  String? transactionId;
  String? transactionDate;
  int? amount;
  int? fees;
  Receiver? receiver;
  String? id;
  String? message;

  Ted({
    this.success,
    this.transactionId,
    this.transactionDate,
    this.amount,
    this.fees,
    this.receiver,
    this.id,
    this.message,
  });

  factory Ted.fromJson(Map<String, dynamic> json) {
    return Ted(
      success: json['success'] ?? null,
      transactionId: json['transaction_id'] ?? null,
      transactionDate: json['transaction_date'] ?? null,
      amount: json['amount'] ?? null,
      fees: json['fees'] ?? null,
      receiver: json['receiver'] != null ? Receiver.fromJson(json['receiver']) : null,
      id: json['id'] ?? null,
      message: json['message'] ?? null,
    );
  }
}

class Receiver {
  String? document;
  String? name;
  String? bankCode;
  String? bankName;
  String? agency;
  String? agencyDigit;
  String? accountNumber;
  String? accountDigit;
  String? accountType;

  Receiver({
    this.document,
    this.name,
    this.bankCode,
    this.bankName,
    this.agency,
    this.agencyDigit,
    this.accountNumber,
    this.accountDigit,
    this.accountType,
  });

  factory Receiver.fromJson(Map<String, dynamic> json) {
    return Receiver(
      document: json['document'] ?? null,
      name: json['name'] ?? null,
      bankCode: json['bank_code'] ?? null,
      bankName: json['bank_name'] ?? null,
      agency: json['agency'] ?? null,
      agencyDigit: json['agency_digit'] ?? null,
      accountNumber: json['account_number'] ?? null,
      accountDigit: json['account_digit'] ?? null,
      accountType: json['account_type'] ?? null,
    );
  }
}
