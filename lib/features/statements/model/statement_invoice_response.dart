class StatementInvoice {
  const StatementInvoice({
    required this.id,
    required this.status,
    required this.amount,
    required this.date,
    required this.type,
    required this.payer,
    required this.receiver,
  });

  factory StatementInvoice.fromJson(Map<String, dynamic> json) {
    return StatementInvoice(
      id: json['id'] as String,
      status: json['status'] as bool,
      amount: json['amount'] as String,
      date: json['date'] as String,
      type: json['type'] as String,
      payer: StatementPayer.fromJson(json['payer'] as Map<String, dynamic>),
      receiver:
          StatementReceiver.fromJson(json['receiver'] as Map<String, dynamic>),
    );
  }

  final String id;
  final bool status;
  final String amount;
  final String date;
  final String type;
  final StatementPayer payer;
  final StatementReceiver receiver;
}

class StatementPayer {
  const StatementPayer({
    required this.name,
    required this.document,
    required this.bankCode,
    required this.bankName,
    required this.agency,
    required this.agencyDigit,
    required this.accountNumber,
    required this.accountDigit,
  });

  factory StatementPayer.fromJson(Map<String, dynamic> json) {
    return StatementPayer(
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

  final String name;
  final String document;
  final String bankCode;
  final String bankName;
  final String agency;
  final String agencyDigit;
  final String accountNumber;
  final String accountDigit;
}

class StatementReceiver {
  const StatementReceiver({
    required this.name,
    required this.document,
    required this.bankCode,
    required this.bankName,
    required this.agency,
    required this.agencyDigit,
    required this.accountNumber,
    required this.accountDigit,
  });

  factory StatementReceiver.fromJson(Map<String, dynamic> json) {
    return StatementReceiver(
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

  final String name;
  final String document;
  final String bankCode;
  final String bankName;
  final String agency;
  final String agencyDigit;
  final String accountNumber;
  final String accountDigit;
}
