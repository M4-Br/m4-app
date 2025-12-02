class PixCreateQrCodeResponse {
  const PixCreateQrCodeResponse({
    required this.success,
    required this.emv,
    required this.text,
    required this.image,
    required this.url,
  });

  final bool success;
  final String emv;
  final String text;
  final String image;
  final String url;

  factory PixCreateQrCodeResponse.fromJson(Map<String, dynamic> json) {
    return PixCreateQrCodeResponse(
      success: json['success'] as bool,
      emv: json['emv'] as String,
      text: json['text'] as String,
      image: json['image'] as String,
      url: json['url'] as String,
    );
  }
}
