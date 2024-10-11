class Beneficiary {
  String name;
  String document;

  Beneficiary({
    required this.name,
    required this.document,
  });

  factory Beneficiary.fromJson(Map<String, dynamic> json) {
    return Beneficiary(
      name: json['name'] as String,
      document: json['document'] as String,
    );
  }
}

class Payer {
  String name;
  String document;

  Payer({
    required this.name,
    required this.document,
  });

  factory Payer.fromJson(Map<String, dynamic> json) {
    return Payer(
      name: json['name'] as String,
      document: json['document'] as String,
    );
  }
}

class BarcodeVoucher {
  bool success;
  String id;
  int ourNumber;
  String paymentType;
  String paymentStatus;
  DateTime transactionDate;
  Beneficiary beneficiary;
  Payer payer;
  String amount;
  DateTime dueDate;
  String barCode;
  String digitableLine;
  String invoiceUrl;
  DateTime createdAt;

  BarcodeVoucher({
    required this.success,
    required this.id,
    required this.ourNumber,
    required this.paymentType,
    required this.paymentStatus,
    required this.transactionDate,
    required this.beneficiary,
    required this.payer,
    required this.amount,
    required this.dueDate,
    required this.barCode,
    required this.digitableLine,
    required this.invoiceUrl,
    required this.createdAt,
  });

  factory BarcodeVoucher.fromJson(Map<String, dynamic> json) {
    return BarcodeVoucher(
      success: json['success'] as bool,
      id: json['id'] as String,
      ourNumber: json['our_number'] as int,
      paymentType: json['payment_type'] as String,
      paymentStatus: json['payment_status'] as String,
      transactionDate: DateTime.parse(json['transaction_date'] as String),
      beneficiary: Beneficiary.fromJson(json['beneficiary'] as Map<String, dynamic>),
      payer: Payer.fromJson(json['payer'] as Map<String, dynamic>),
      amount: json['amount'] as String,
      dueDate: DateTime.parse(json['due_date'] as String),
      barCode: json['bar_code'] as String,
      digitableLine: json['digitable_line'] as String,
      invoiceUrl: json['invoice_url'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }
}