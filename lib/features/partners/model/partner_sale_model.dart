class PartnerSale {
  final int? id;
  final int userId;
  final int partnerProductId;
  final int quantity;
  final double totalValue;
  final String saleDate;
  final int transactionId;

  PartnerSale({
    this.id,
    required this.userId,
    required this.partnerProductId,
    required this.quantity,
    required this.totalValue,
    required this.saleDate,
    required this.transactionId,
  });

  factory PartnerSale.fromJson(Map<String, dynamic> json) {
    return PartnerSale(
      id: json['id'] as int?,
      userId: json['user_id'] as int? ?? 0,
      partnerProductId: json['partner_product_id'] as int? ?? 0,
      quantity: json['quantity'] as int? ?? 0,
      totalValue: ((json['total_value'] as num?)?.toDouble() ?? 0.0) / 100,
      saleDate: json['sale_date'] as String? ?? '',
      transactionId: json['transaction_id'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'partner_product_id': partnerProductId,
      'quantity': quantity,
      'total_value': (totalValue * 100).toInt(),
      'sale_date': saleDate,
      'transaction_id': transactionId,
    };
  }
}
