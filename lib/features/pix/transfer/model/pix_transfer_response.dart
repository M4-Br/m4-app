class PixTransferResponse {
  final bool success;
  final String amount;
  final String receiverName;
  final String bankName;
  final String transactionDate;

  PixTransferResponse({
    required this.success,
    required this.amount,
    required this.receiverName,
    required this.bankName,
    required this.transactionDate,
  });

  factory PixTransferResponse.fromJson(Map<String, dynamic> json) {
    String date = '';
    if (json['transfer'] != null &&
        json['transfer']['transaction_date'] != null) {
      date = json['transfer']['transaction_date'];
    } else if (json['transaction_date'] != null) {
      date = json['transaction_date'];
    } else {
      date = DateTime.now().toIso8601String();
    }

    return PixTransferResponse(
      success: json['success'] as bool,
      amount: json['amount']?.toString() ?? '0',
      receiverName: json['name'] ?? json['receiver_name'] ?? 'Desconhecido',
      bankName: json['institute'] ?? json['bank_name'] ?? '',
      transactionDate: date,
    );
  }
}
