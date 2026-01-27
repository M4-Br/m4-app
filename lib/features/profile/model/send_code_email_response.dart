class SendCodeEmailResponse {
  const SendCodeEmailResponse({required this.success, required this.message});

  factory SendCodeEmailResponse.fromJson(Map<String, dynamic> json) {
    return SendCodeEmailResponse(
      success: json['success'] as bool,
      message: json['message'] as String,
    );
  }

  final bool success;
  final String message;
}
