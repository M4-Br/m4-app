class CnpjCodeModel {
  final int code;
  final int individualId;
  final bool checked;
  final DateTime expiresAt;

  CnpjCodeModel({
    required this.code,
    required this.individualId,
    required this.checked,
    required this.expiresAt,
  });

  factory CnpjCodeModel.fromJson(Map<String, dynamic> json) {
    return CnpjCodeModel(
      code: json['code'],
      individualId: json['individual_id'],
      checked: json['checked'] == 1,
      expiresAt: DateTime.parse(json['expires_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'individual_id': individualId,
      'checked': checked ? 1 : 0,
      'expires_at': expiresAt.toIso8601String(),
    };
  }
}
