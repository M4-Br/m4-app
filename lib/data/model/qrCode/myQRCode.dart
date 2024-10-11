class MyQRCodeModel {
  final bool success;
  final String qrcode;

  MyQRCodeModel({
    required this.success,
    required this.qrcode,
  });

  factory MyQRCodeModel.fromJson(Map<String, dynamic> json) {
    return MyQRCodeModel(
      success: json['success'],
      qrcode: json['qrcode'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'qrcode': qrcode,
    };
  }
}
