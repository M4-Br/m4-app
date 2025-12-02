class PixKeyDeleteResponse {
  bool success;
  String message;

  PixKeyDeleteResponse({required this.success, required this.message});

  factory PixKeyDeleteResponse.fromJson(Map<String, dynamic> json) {
    return PixKeyDeleteResponse(
      success: json['success'] as bool,
      message: json['message'] as String,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
    };
  }
}
