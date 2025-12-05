class StoreResponse {
  final String merchantId;
  final String merchantName;
  final String merchantIcon;
  final String merchantCategory;
  final String merchantDescription;
  final String merchantLink;

  StoreResponse({
    required this.merchantId,
    required this.merchantName,
    required this.merchantIcon,
    required this.merchantCategory,
    required this.merchantDescription,
    required this.merchantLink,
  });

  factory StoreResponse.fromJson(Map<String, dynamic> json) {
    return StoreResponse(
      merchantId: json['merchant_id'] as String,
      merchantName: json['merchant_name'] as String,
      merchantIcon: json['merchant_icon'] as String,
      merchantCategory: json['merchant_category'] as String,
      merchantDescription: json['merchant_description'] as String,
      merchantLink: json['merchant_link'] as String,
    );
  }
}
