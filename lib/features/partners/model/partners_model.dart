class MainPartnerModel {
  final String name;
  final String description;
  final String logoAsset;
  final String? url;

  MainPartnerModel({
    required this.name,
    required this.description,
    required this.logoAsset,
    this.url,
  });
}

class OtherPartnerModel {
  final String name;
  final String url;

  OtherPartnerModel({required this.name, required this.url});
}
