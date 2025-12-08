class BarcodePaymentRequest {
  const BarcodePaymentRequest({
    required this.amount,
    required this.password,
    required this.barcode,
    required this.date,
    required this.assignor,
  });

  final int amount;
  final String password;
  final String barcode;
  final String date;
  final String assignor;

  Map<String, dynamic> toJson() {
    return {
      'amount': amount,
      'password': password,
      'bar_code': barcode,
      'due_date': date,
      'assignor': assignor
    };
  }
}
