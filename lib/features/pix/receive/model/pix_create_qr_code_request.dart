class PixCreateQrCodeRequest {
  const PixCreateQrCodeRequest({
    required this.key,
    required this.amount,
    required this.title,
    required this.description,
  });

  final String key;
  final String amount;
  final String title;
  final String description;

  Map<String, dynamic> toJson() {
    return {
      'key': key,
      'amount': amount,
      'title': title,
      'description': description,
    };
  }
}
