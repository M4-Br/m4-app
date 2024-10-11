class PixTransfer {
  final bool success;
  final String message;
  final String idEndToEnd;
  final DateTime transactionDate;
  final int idAdjustment;
  final String transactionCode;
  final String transactionStatus;

  PixTransfer({
    required this.success,
    required this.message,
    required this.idEndToEnd,
    required this.transactionDate,
    required this.idAdjustment,
    required this.transactionCode,
    required this.transactionStatus,
  });

  factory PixTransfer.fromJson(Map<String, dynamic> json) {
    return PixTransfer(
      success: json['success'],
      message: json['message'],
      idEndToEnd: json['idEndToEnd'],
      transactionDate: DateTime.parse(json['transaction_date']),
      idAdjustment: json['id_adjustment'],
      transactionCode: json['transaction_code'],
      transactionStatus: json['transaction_status'],
    );
  }
}
