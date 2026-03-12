class MarketplaceSaleHistory {
  final int id;
  final int userId;
  final int marketplaceProductId;
  final int quantity;
  final double totalValue;
  final DateTime saleDate;
  final int transactionId;
  final MarketplaceProduct? product;

  MarketplaceSaleHistory({
    required this.id,
    required this.userId,
    required this.marketplaceProductId,
    required this.quantity,
    required this.totalValue,
    required this.saleDate,
    required this.transactionId,
    this.product,
  });

  factory MarketplaceSaleHistory.fromJson(Map<String, dynamic> json) {
    return MarketplaceSaleHistory(
      id: json['id'],
      userId: json['user_id'],
      marketplaceProductId: json['partner_product_id'],
      quantity: json['quantity'],
      totalValue: (json['total_value'] as num).toDouble(),
      saleDate: DateTime.parse(json['sale_date']),
      transactionId: json['transaction_id'],
      product: json['partner_product'] != null
          ? MarketplaceProduct.fromJson(json['partner_product'])
          : null,
    );
  }
}

class MarketplaceProduct {
  final int id;
  final String productName;
  final double marketplaceValue;

  MarketplaceProduct(
      {required this.id,
      required this.productName,
      required this.marketplaceValue});

  factory MarketplaceProduct.fromJson(Map<String, dynamic> json) {
    return MarketplaceProduct(
      id: json['id'],
      productName: json['product_name'],
      marketplaceValue: (json['partner_value'] as num).toDouble(),
    );
  }
}
