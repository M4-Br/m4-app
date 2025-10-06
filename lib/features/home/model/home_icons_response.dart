
class HomeIconsResponse{
  const HomeIconsResponse({
    required this.id,
    required this.position,
    required this.title,
    required this.icon,
    required this.isActive,
});

  factory HomeIconsResponse.fromJson(Map<String, dynamic> json) {
    return HomeIconsResponse(
      id: json['id'] as String,
      position: json['position'] as int,
      title: json['title'] as String,
      icon: json['icon'] as String,
      isActive: json['is_active'] as bool,
    );
  }

final String id;
final int position;
final String title;
final String icon;
final bool isActive;
}