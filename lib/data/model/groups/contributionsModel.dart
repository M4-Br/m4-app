class User {
  final int? id;
  final String? name;
  final String? email;
  final String? document;
  final String? avatar;
  final String? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final bool? activeAccount;

  User({
    this.id,
    this.name,
    this.email,
    this.document,
    this.avatar,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.activeAccount,
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
      activeAccount: json['active_account'],
    );
  }
}

class TransactionGroup {
  final String? id;
  final int? userId;
  final String? mutualUserId;
  final int? proposalId;
  final int? installmentId;
  final String? barCode;
  final int? amount;
  final int? installment;
  final String? status;
  final String? dueDate;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final DateTime? paymentDate;
  final String? type;
  final String? externalTransactionId;
  final DestinationAccount? destinationAccount;
  final User? user;

  TransactionGroup({
    this.id,
    this.userId,
    this.mutualUserId,
    this.proposalId,
    this.installmentId,
    this.barCode,
    this.amount,
    this.installment,
    this.status,
    this.dueDate,
    this.createdAt,
    this.updatedAt,
    this.paymentDate,
    this.type,
    this.externalTransactionId,
    this.destinationAccount,
    this.user,
  });

  factory TransactionGroup.fromJson(Map<String, dynamic> json) {
    return TransactionGroup(
      id: json['id'],
      userId: json['user_id'],
      mutualUserId: json['mutual_user_id'],
      proposalId: json['proposal_id'],
      installmentId: json['installment_id'],
      barCode: json['bar_code'],
      amount: json['amount'],
      installment: json['installment'],
      status: json['status'],
      dueDate: json['due_date'],
      createdAt: json['created_at'] != null ? DateTime.parse(json['created_at']) : null,
      updatedAt: json['updated_at'] != null ? DateTime.parse(json['updated_at']) : null,
      paymentDate: json['payment_date'] != null ? DateTime.parse(json['payment_date']) : null,
      type: json['type'],
      externalTransactionId: json['external_transaction_id'],
      destinationAccount: json['destination_account'] != null
          ? DestinationAccount.fromJson(json['destination_account'])
          : null,
      user: User.fromJson(json['user']),
    );
  }
}

class DestinationAccount {
  final String? accountNumber;
  final String? fullName;
  final String? document;
  final String? accountType;

  DestinationAccount({
    this.accountNumber,
    this.fullName,
    this.document,
    this.accountType,
  });

  factory DestinationAccount.fromJson(Map<String, dynamic>? json) {
    if (json == null) return DestinationAccount();
    return DestinationAccount(
      accountNumber: json['account_number'],
      fullName: json['full_name'],
      document: json['document'],
      accountType: json['account_type'],
    );
  }
}
