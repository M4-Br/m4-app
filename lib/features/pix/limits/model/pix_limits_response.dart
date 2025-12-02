import 'package:app_flutter_miban4/core/helpers/extensions/numbers.dart';

class PixLimitsResponse {
  const PixLimitsResponse({required this.success, required this.data});

  final bool success;
  final List<LimitData> data;

  factory PixLimitsResponse.fromJson(Map<String, dynamic> json) {
    return PixLimitsResponse(
      success: json['success'],
      data: (json['data'] as List)
          .map((limitData) => LimitData.fromJson(limitData))
          .toList(),
    );
  }
}

class LimitData {
  const LimitData({
    required this.limitType,
    required this.limitDescription,
    required this.defaultLimit,
    required this.accountLimit,
  });

  final String limitDescription;
  final String limitType;
  final double defaultLimit;
  final double accountLimit;

  factory LimitData.fromJson(Map<String, dynamic> json) {
    return LimitData(
      limitType: json['limit_type'] as String,
      limitDescription: json['limit_description'] as String,
      defaultLimit: (json['default_limit'] as String).toCurrencyDouble(),
      accountLimit: (json['account_limit'] as String).toCurrencyDouble(),
    );
  }
}
