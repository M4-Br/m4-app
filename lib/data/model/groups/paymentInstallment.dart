class PayInstallment {
  final String id;
  final int groupAccountId;
  final int userId;
  final int? transactionId;
  final int amount;
  final int installment;
  final String status;
  final DateTime dueDate;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String transactionType;
  final User user;

  PayInstallment({
    required this.id,
    required this.groupAccountId,
    required this.userId,
    required this.transactionId,
    required this.amount,
    required this.installment,
    required this.status,
    required this.dueDate,
    required this.createdAt,
    required this.updatedAt,
    required this.transactionType,
    required this.user,
  });

  factory PayInstallment.fromJson(Map<String, dynamic> json) {
    return PayInstallment(
      id: json['id'],
      groupAccountId: json['group_account_id'],
      userId: json['user_id'],
      transactionId: json['transaction_id'],
      amount: json['amount'],
      installment: json['installment'],
      status: json['status'],
      dueDate: DateTime.parse(json['due_date']),
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      transactionType: json['transaction_type'],
      user: User.fromJson(json['user']),
    );
  }
}

class User {
  final int id;
  final String name;
  final String email;
  final String document;
  final String avatar;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final int individualId;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.document,
    required this.avatar,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.individualId,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      document: json['document'],
      avatar: json['avatar'],
      status: json['status'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      deletedAt: json['deleted_at'] != null ? DateTime.parse(json['deleted_at']) : null,
      individualId: json['individual_id'],
    );
  }
}
