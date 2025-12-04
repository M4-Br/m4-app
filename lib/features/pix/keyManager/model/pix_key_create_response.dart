class PixKeyCreateResponse {
  const PixKeyCreateResponse({
    required this.success,
  });

  final bool success;

  factory PixKeyCreateResponse.fromJson(Map<String, dynamic> json) {
    return PixKeyCreateResponse(
      success: json['success'] as bool,
    );
  }
}
