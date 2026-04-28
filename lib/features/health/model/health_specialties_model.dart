class HealthSpecialty {
  final String uuid;
  final String name;

  HealthSpecialty({
    required this.uuid,
    required this.name,
  });

  factory HealthSpecialty.fromJson(Map<String, dynamic> json) {
    return HealthSpecialty(
      uuid: json['uuid'] ?? '',
      name: json['name'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uuid': uuid,
      'name': name,
    };
  }
}
