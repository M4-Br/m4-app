class IconModel {
  final String? id;
  final int? position;
  final String? title;
  final String? icon;
  final bool? isActive;

  IconModel({
    this.id,
    this.position,
    this.title,
    this.icon,
    this.isActive,
  });

  factory IconModel.fromJson(Map<String, dynamic> json) {
    return IconModel(
      id: json['id'] ?? '',
      position: json['position'] ?? 0,
      title: json['title'] ?? '',
      icon: json['icon'] ?? '',
      isActive: json['is_active'] ?? false,
    );
  }
}
