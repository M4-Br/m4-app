class CompleteProfileProfessionRequest {
  const CompleteProfileProfessionRequest({
    required this.id,
    required this.professionId,
    required this.income,
  });

  final int id;
  final String professionId;
  final String income;

  Map<String, dynamic> toJson() => {
        'individual_id': id,
        'profession_id': professionId,
        'income_value': income,
      };
}
