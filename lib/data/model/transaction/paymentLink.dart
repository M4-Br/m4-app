class PaymentLinkModel {
  final bool success;
  final String username;
  final int amount;
  final String description;
  final String link;

  PaymentLinkModel({
    required this.success,
    required this.username,
    required this.amount,
    required this.description,
    required this.link,
  });

  factory PaymentLinkModel.fromJson(Map<String, dynamic> json) {
    return PaymentLinkModel(
      success: json['success'],
      username: json['username'],
      amount: json['amount'],
      description: json['description'],
      link: json['link'],
    );
  }
}