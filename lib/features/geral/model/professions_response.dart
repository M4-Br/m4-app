class ProfessionsResponse {
  const ProfessionsResponse({
    required this.id,
    required this.description,
  });

  final int id;
  final String description;

  factory ProfessionsResponse.fromJson(Map<String, dynamic> json) {
    return ProfessionsResponse(
      id: json['id'] as int,
      description: json['description'] as String,
    );
  }
}
