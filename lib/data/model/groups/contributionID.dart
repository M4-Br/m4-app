class ContributionID {
  final String id;
  final int groupAccountId;
  final int userId;
  final dynamic? transactionId;
  final int amount;
  final int installment;
  final String status;
  final DateTime dueDate;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int amountContributions;
  final int amountPending;
  final GroupAccount groupAccount;
  final User user;
  String? message;

  ContributionID({
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
    required this.amountContributions,
    required this.amountPending,
    required this.groupAccount,
    required this.user,
    this.message
  });

  factory ContributionID.fromJson(Map<String, dynamic> json) {
    return ContributionID(
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
      amountContributions: json['amount_contributions'],
      amountPending: json['amount_pending'],
      groupAccount: GroupAccount.fromJson(json['group_account']),
      user: User.fromJson(json['user']),
      message: json['message'],
    );
  }
}

class GroupAccount {
  final int id;
  final int userId;
  final String name;
  final DateTime startAt;
  final bool agentWasMembership;
  final String period;
  final int amountByPeriod;
  final int installment;
  final int quantityOfMembers;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int? externalAccountId;
  final DateTime finishDate;
  final Mutual mutual;

  GroupAccount({
    required this.id,
    required this.userId,
    required this.name,
    required this.startAt,
    required this.agentWasMembership,
    required this.period,
    required this.amountByPeriod,
    required this.installment,
    required this.quantityOfMembers,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.finishDate,
    required this.mutual,
    this.externalAccountId,
  });

  factory GroupAccount.fromJson(Map<String, dynamic> json) {
    return GroupAccount(
      id: json['id'],
      userId: json['user_id'],
      name: json['name'],
      startAt: DateTime.parse(json['start_at']),
      agentWasMembership: json['agent_was_membership'],
      period: json['period'],
      amountByPeriod: json['amount_by_period'],
      installment: json['installment'],
      quantityOfMembers: json['quantity_of_members'],
      status: json['status'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      externalAccountId: json['external_account_id'],
      finishDate: DateTime.parse(json['finish_date']),
      mutual: Mutual.fromJson(json['mutual']),
    );
  }
}

class Mutual {
  final int id;
  final int groupAccountId;
  final int fee;
  final int installment;
  final String priority;
  final int extraFee;
  final bool charge;
  final DateTime createdAt;
  final DateTime updatedAt;

  Mutual({
    required this.id,
    required this.groupAccountId,
    required this.fee,
    required this.installment,
    required this.priority,
    required this.extraFee,
    required this.charge,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Mutual.fromJson(Map<String, dynamic> json) {
    return Mutual(
      id: json['id'],
      groupAccountId: json['group_account_id'],
      fee: json['fee'],
      installment: json['installment'],
      priority: json['priority'],
      extraFee: json['extra_fee'],
      charge: json['charge'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
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