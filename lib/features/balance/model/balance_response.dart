import 'package:app_flutter_miban4/core/helpers/extensions/numbers.dart';

class BalanceResponse {
  const BalanceResponse({
    required this.success,
    required this.balance,
    required this.balanceCents,
    required this.transactionalValue,
  });

  factory BalanceResponse.fromJson(Map<String, dynamic> json) {
    return BalanceResponse(
      success: json['success'] as bool,
      balance: (json['balance'] as String).toCurrencyDouble(),
      balanceCents: (json['balance_cents'] as String).toCurrencyDouble(),
      transactionalValue:
          (json['transactional_value'] as String).toCurrencyDouble(),
    );
  }

  final bool success;
  final double balance;
  final double balanceCents;
  final double transactionalValue;
}
