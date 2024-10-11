class PixDeleteModel {
  bool success;
  String message;

  PixDeleteModel({required this.success, required this.message});

  factory PixDeleteModel.fromJson(Map<String, dynamic> json) {
    return PixDeleteModel(
      success: json['success'],
      message: json['message'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
    };
  }

}