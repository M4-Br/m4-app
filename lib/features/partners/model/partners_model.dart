class PartnerCategory {
  final int id;
  final String categoryName;
  final List<PartnerItem> items;

  PartnerCategory({
    required this.id,
    required this.categoryName,
    required this.items,
  });

  factory PartnerCategory.fromJson(Map<String, dynamic> json) {
    return PartnerCategory(
      id: json['id'] as int? ?? 0,
      categoryName: json['description'] as String? ?? '',
      items: json['items'] != null
          ? (json['items'] as List<dynamic>)
              .map((item) => PartnerItem.fromJson(item as Map<String, dynamic>))
              .toList()
          : <PartnerItem>[],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'category_name': categoryName,
      'items': items.map((item) => item.toJson()).toList(),
    };
  }
}

class PartnerItem {
  final String id;
  final int categoryId;
  final String userId;
  final String name;
  final String description;
  final double marketValue;
  final double discount;
  final double partnerValue;

  PartnerItem({
    required this.id,
    required this.categoryId,
    required this.userId,
    required this.name,
    required this.description,
    required this.marketValue,
    required this.discount,
    required this.partnerValue,
  });

  factory PartnerItem.fromJson(Map<String, dynamic> json) {
    final parsedMarketValue =
        ((json['market_value'] as num?)?.toDouble() ?? 0.0) / 100;
    final parsedPartnerValue =
        ((json['partner_value'] as num?)?.toDouble() ?? 0.0) / 100;
    final calculatedDiscount = parsedMarketValue - parsedPartnerValue;

    return PartnerItem(
      id: json['id']?.toString() ?? '',
      categoryId: json['partner_category_id'] as int? ?? 0,
      userId: json['user_id']?.toString() ?? '',
      name: json['product_name'] as String? ?? '',
      description: json['description'] as String? ?? '',
      marketValue: parsedMarketValue,
      partnerValue: parsedPartnerValue,
      discount: calculatedDiscount,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'product_name': name,
      'description': description,
      'market_value': (marketValue * 100).toInt(),
      'partner_value': (partnerValue * 100).toInt(),
      'partner_category_id': categoryId,
    };
  }
}

class PartnerPurchaseRequest {
  final String itemId;
  final String region;
  final double amount;

  PartnerPurchaseRequest({
    required this.itemId,
    required this.region,
    required this.amount,
  });

  Map<String, dynamic> toJson() {
    return {
      'item_id': itemId,
      'region': region,
      'amount': (amount * 100).toInt(),
    };
  }
}
