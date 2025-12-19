class CompleteProfileSelfieResponse {
  const CompleteProfileSelfieResponse({
    required this.success,
    required this.base64,
    required this.id,
  });

  final bool success;
  final String base64;
  final int id;

  factory CompleteProfileSelfieResponse.fromJson(Map<String, dynamic> json) {
    return CompleteProfileSelfieResponse(
      id: json['id'],
      success: json['success'] as bool? ?? false,
      base64: json['base64'] as String? ?? '',
    );
  }
}
