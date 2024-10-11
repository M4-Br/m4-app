class Merchant {
  final String merchantId;
  final String merchantName;
  final String merchantIcon;
  final String merchantCategory;
  final String merchantDescription;
  final String merchantLink;

  Merchant({
    required this.merchantId,
    required this.merchantName,
    required this.merchantIcon,
    required this.merchantCategory,
    required this.merchantDescription,
    required this.merchantLink,
  });

  factory Merchant.fromJson(Map<String, dynamic> json) {
    return Merchant(
      merchantId: json['merchant_id'],
      merchantName: json['merchant_name'],
      merchantIcon: json['merchant_icon'],
      merchantCategory: json['merchant_category'],
      merchantDescription: json['merchant_description'],
      merchantLink: json['merchant_link'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'merchant_id': merchantId,
      'merchant_name': merchantName,
      'merchant_icon': merchantIcon,
      'merchant_category': merchantCategory,
      'merchant_description': merchantDescription,
      'merchant_link': merchantLink,
    };
  }
}