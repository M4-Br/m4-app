class MessageResponse {
  const MessageResponse({
    required this.success,
    required this.message,
  });

  factory MessageResponse.fromJson(Map<String, dynamic> json) {
    return MessageResponse(
        success: json['success'] as bool, message: json['message'] as String?);
  }

  final bool success;
  final String? message;
}
