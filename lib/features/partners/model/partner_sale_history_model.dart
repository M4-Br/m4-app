class PartnerSaleHistory {
  final int id;
  final int userId;
  final int partnerProductId;
  final int quantity;
  final double totalValue;
  final DateTime saleDate;
  final int transactionId;
  final PartnerProduct? product;

  PartnerSaleHistory({
    required this.id,
    required this.userId,
    required this.partnerProductId,
    required this.quantity,
    required this.totalValue,
    required this.saleDate,
    required this.transactionId,
    this.product,
  });

  factory PartnerSaleHistory.fromJson(Map<String, dynamic> json) {
    return PartnerSaleHistory(
      id: json['id'],
      userId: json['user_id'],
      partnerProductId: json['partner_product_id'],
      quantity: json['quantity'],
      totalValue: (json['total_value'] as num).toDouble(),
      saleDate: DateTime.parse(json['sale_date']),
      transactionId: json['transaction_id'],
      product: json['partner_product'] != null
          ? PartnerProduct.fromJson(json['partner_product'])
          : null,
    );
  }
}

class PartnerProduct {
  final int id;
  final String productName;
  final double partnerValue;

  PartnerProduct(
      {required this.id,
      required this.productName,
      required this.partnerValue});

  factory PartnerProduct.fromJson(Map<String, dynamic> json) {
    return PartnerProduct(
      id: json['id'],
      productName: json['product_name'],
      partnerValue: (json['partner_value'] as num).toDouble(),
    );
  }
}
