class HealthPlanModel {
  final String uuid;
  final String name;
  final String description;
  final List<String> serviceTypes;
  final List<String> specialties;

  HealthPlanModel({
    required this.uuid,
    required this.name,
    required this.description,
    required this.serviceTypes,
    required this.specialties,
  });

  factory HealthPlanModel.fromJson(Map<String, dynamic> json) {
    return HealthPlanModel(
      uuid: json['uuid'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      serviceTypes: (json['serviceTypes'] as List? ?? [])
          .map((e) => e.toString())
          .toList(),
      specialties: (json['specialties'] as List? ?? [])
          .map((e) => e.toString())
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uuid': uuid,
      'name': name,
      'description': description,
      'serviceTypes': serviceTypes,
      'specialties': specialties,
    };
  }
}
