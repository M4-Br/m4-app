class StatementVoucher {
  final bool? success;
  final String? id;
  final String? status;
  final String? amount;
  final String? date;
  final String? type;
  final Payer? payer;
  final Receiver? receiver;

  StatementVoucher({
    this.success,
    this.id,
    this.status,
    this.amount,
    this.date,
    this.type,
    this.payer,
    this.receiver,
  });

  factory StatementVoucher.fromJson(Map<String, dynamic> json) => StatementVoucher(
    success: json['success'] as bool,
    id: json['id'] as String,
    status: json['status'] as String,
    amount: json['amount'] as String,
    date: json['date'] as String,
    type: json['type'] as String,
    payer: Payer.fromJson(json['payer'] as Map<String, dynamic>),
    receiver: Receiver.fromJson(json['receiver'] as Map<String, dynamic>),
  );
}

class Payer {
  final String? name;
  final String? document;
  final String? bankCode;
  final String? bankName;
  final String? agency;
  final String? accountNumber;

  Payer({
    this.name,
    this.document,
    this.bankCode,
    this.bankName,
    this.agency,
    this.accountNumber,
  });

  factory Payer.fromJson(Map<String, dynamic> json) => Payer(
    name: json['name'] as String,
    document: json['document'] as String,
    bankCode: json['bank_code'] as String,
    bankName: json['bank_name'] as String,
    agency: json['agency'] as String,
    accountNumber: json['account_number'] as String,
  );
}

class Receiver {
  final String? name;
  final String? document;
  final String? bankCode;
  final String? bankName;
  final String? agency;
  final String? agencyDigit;
  final String? accountNumber;
  final String? accountDigit;

  Receiver({
    this.name,
    this.document,
    this.bankCode,
    this.bankName,
    this.agency,
    this.agencyDigit,
    this.accountNumber,
    this.accountDigit,
  });

  factory Receiver.fromJson(Map<String, dynamic> json) => Receiver(
    name: json['name'] as String,
    document: json['document'] as String,
    bankCode: json['bank_code'] as String,
    bankName: json['bank_name'] as String,
    agency: json['agency'] as String,
    agencyDigit: json['agency_digit'] as String,
    accountNumber: json['account_number'] as String,
    accountDigit: json['account_digit'] as String,
  );
}
