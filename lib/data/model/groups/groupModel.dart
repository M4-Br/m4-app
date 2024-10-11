class Group {
  int id;
  int userId;
  String name;
  DateTime? startAt;
  bool? agentWasMembership;
  String? period;
  int? amountByPeriod;
  int? installment;
  int? quantityOfMembers;
  String? status;
  DateTime createdAt;
  DateTime updatedAt;
  int? externalAccountId;
  int? amountPending;
  int? amountContributions;
  DateTime? finishDate;

  Group({
    required this.id,
    required this.userId,
    required this.name,
    this.startAt,
    this.agentWasMembership,
    this.period,
    this.amountByPeriod,
    this.installment,
    this.quantityOfMembers,
    this.status,
    required this.createdAt,
    required this.updatedAt,
    this.externalAccountId,
    this.amountPending,
    this.amountContributions,
    this.finishDate,
  });

  factory Group.fromJson(Map<String, dynamic> json) {
    return Group(
      id: json['id'],
      userId: json['user_id'],
      name: json['name'],
      startAt: json['start_at'] != null ? DateTime.parse(json['start_at']) : null,
      agentWasMembership: json['agent_was_membership'],
      period: json['period'],
      amountByPeriod: json['amount_by_period'],
      installment: json['installment'],
      quantityOfMembers: json['quantity_of_members'],
      status: json['status'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      externalAccountId: json['external_account_id'],
      amountPending: json['amount_pending'],
      amountContributions: json['amount_contributions'],
      finishDate: json['finish_date'] != null ? DateTime.parse(json['finish_date']) : null,
    );
  }
}
