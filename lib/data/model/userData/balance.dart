class Balance {
  final bool? success;
  final dynamic? balance;
  final dynamic? balanceCents;
  final dynamic? transactionalValue;

  Balance({
    this.success,
    this.balance,
    this.balanceCents,
    this.transactionalValue,
  });

  factory Balance.fromJson(Map<String, dynamic> json) {
    return Balance(
      success: json['success'],
      balance: json['balance'],
      balanceCents: json['balance_cents'],
      transactionalValue: json['transactional_value'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'balance': balance,
      'balance_cents': balanceCents,
      'transactionalValue': transactionalValue,
    };
  }
}
