class PaymentLinkResponse {
  final bool success;
  final String nickname;
  final int value;
  final String description;
  final String link;

  PaymentLinkResponse({
    required this.success,
    required this.nickname,
    required this.value,
    required this.description,
    required this.link,
  });

  factory PaymentLinkResponse.fromJson(Map<String, dynamic> json) {
    return PaymentLinkResponse(
      success: json['success'] as bool,
      nickname: json['nickname'] as String,
      value: json['value'],
      description: json['description'] as String,
      link: json['link'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'nickname': nickname,
      'value': value,
      'description': description,
      'link': link,
    };
  }
}
