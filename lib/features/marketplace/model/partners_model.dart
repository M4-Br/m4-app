class MarketplaceCategory {
  final int id;
  final String categoryName;
  List<MarketplaceItem> items;

  MarketplaceCategory({
    required this.id,
    required this.categoryName,
    this.items = const [],
  });

  factory MarketplaceCategory.fromJson(Map<String, dynamic> json) {
    return MarketplaceCategory(
      id: json['id'] as int? ?? 0,
      categoryName: json['description'] as String? ?? '',
      items: [],
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

class MarketplaceItem {
  final String id;
  final int categoryId;
  final String userId;
  final String name;
  final String description;
  final double marketValue;
  final double discount;
  final double marketplaceValue;
  final MarketplaceCategory? category;

  MarketplaceItem({
    required this.id,
    required this.categoryId,
    required this.userId,
    required this.name,
    required this.description,
    required this.marketValue,
    required this.discount,
    required this.marketplaceValue,
    this.category,
  });

  factory MarketplaceItem.fromJson(Map<String, dynamic> json) {
    final parsedMarketValue =
        ((json['market_value'] as num?)?.toDouble() ?? 0.0) / 100;

    final parsedMarketplaceValue =
        ((json['partner_value'] as num?)?.toDouble() ?? 0.0) / 100;

    final calculatedDiscount = parsedMarketValue - parsedMarketplaceValue;

    return MarketplaceItem(
      id: json['id']?.toString() ?? '',
      categoryId: json['partner_category_id'] as int? ?? 0,
      userId: json['user_id']?.toString() ?? '',
      name: json['product_name'] as String? ?? '',
      description: json['description'] as String? ?? '',
      marketValue: parsedMarketValue,
      marketplaceValue: parsedMarketplaceValue,
      discount: calculatedDiscount,
      category: json['category'] != null
          ? MarketplaceCategory.fromJson(json['category'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'product_name': name,
      'description': description,
      'market_value': (marketValue * 100).toInt(),
      'partner_value': (marketplaceValue * 100).toInt(),
      'partner_category_id': categoryId,
    };
  }
}

class MarketplacePurchaseRequest {
  final String itemId;
  final String region;
  final double amount;

  MarketplacePurchaseRequest({
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
