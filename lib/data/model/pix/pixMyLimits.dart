class PixLimits {
  bool success;
  List<LimitData> data;

  PixLimits({required this.success, required this.data});

  factory PixLimits.fromJson(Map<String, dynamic> json) {
    return PixLimits(
      success: json['success'],
      data: (json['data'] as List)
          .map((limitData) => LimitData.fromJson(limitData))
          .toList(),
    );
  }
}

class LimitData {
  String limitType;
  String limitDescription;
  String defaultLimit;
  String accountLimit;

  LimitData({
    required this.limitType,
    required this.limitDescription,
    required this.defaultLimit,
    required this.accountLimit,
  });

  factory LimitData.fromJson(Map<String, dynamic> json) {
    return LimitData(
      limitType: json['limit_type'],
      limitDescription: json['limit_description'],
      defaultLimit: json['default_limit'],
      accountLimit: json['account_limit'],
    );
  }
}
