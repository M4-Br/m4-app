class Professions {
  final int id;
  final String description;

  Professions({required this.id, required this.description});

  factory Professions.fromJson(Map<String, dynamic> json) {
    return Professions(
      id: json['id'],
      description: json['description'],
    );
  }
}