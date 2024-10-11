class PaymentLinkEntity {
  final bool success;
  final String nickname;
  final int value;
  final String description;
  final String link;

  PaymentLinkEntity({
    required this.success,
    required this.nickname,
    required this.value,
    required this.description,
    required this.link,
  });

  factory PaymentLinkEntity.fromJson(Map<String, dynamic> json) {
    return PaymentLinkEntity(
      success: json['success'],
      nickname: json['nickname'],
      value: json['value'],
      description: json['description'],
      link: json['link'],
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
