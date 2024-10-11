class AccountLimit {
  final bool success;
  final String status;
  final String limitType;
  final String limitDescription;
  final String accountLimit;

  AccountLimit({
    required this.success,
    required this.status,
    required this.limitType,
    required this.limitDescription,
    required this.accountLimit,
  });

  factory AccountLimit.fromJson(Map<String, dynamic> json) {
    return AccountLimit(
      success: json['success'],
      status: json['status'],
      limitType: json['limit_type'],
      limitDescription: json['limit_description'],
      accountLimit: json['account_limit'],
    );
  }
}