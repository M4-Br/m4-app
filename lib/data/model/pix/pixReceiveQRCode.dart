class CreatePIXQrCode {
  final bool? success;
  final String? message;
  final String? emv;
  final String? text;
  final String? image;
  final String? url;

  CreatePIXQrCode({
    this.success,
    this.message,
    this.emv,
    this.text,
    this.image,
    this.url,
  });

  factory CreatePIXQrCode.fromJson(Map<String, dynamic> json) {
    return CreatePIXQrCode(
      success: json['success'],
      message: json['message'],
      emv: json['emv'],
      text: json['text'],
      image: json['image'],
      url: json['url'],
    );
  }
}