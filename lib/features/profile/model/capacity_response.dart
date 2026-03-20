class CapacityResponse {
  final int incomeFamily;
  final String house;
  final String transport;
  final int houseCost;
  final int transportCost;
  final int utilitiesCost;
  final int otherCost;
  final bool updateRegister;
  final String? updateDate;

  const CapacityResponse({
    required this.incomeFamily,
    required this.house,
    required this.transport,
    required this.houseCost,
    required this.transportCost,
    required this.utilitiesCost,
    required this.otherCost,
    required this.updateRegister,
    this.updateDate,
  });

  factory CapacityResponse.fromJson(Map<String, dynamic> json) {
    return CapacityResponse(
      incomeFamily: json['income_family'] as int? ?? 0,
      house: json['house'] as String? ?? '',
      transport: json['transport'] as String? ?? '',
      houseCost: json['house_cost'] as int? ?? 0,
      transportCost: json['transport_cost'] as int? ?? 0,
      utilitiesCost: json['utilities_cost'] as int? ?? 0,
      otherCost: json['other_cost'] as int? ?? 0,
      updateRegister: json['update_register'] as bool? ?? false,
      updateDate: json['update_date'] as String?,
    );
  }
}

class CapacityRequest {
  final String userId;
  final String groupId;
  final String incomeFamily;
  final String peopleFamily;
  final String house;
  final String transport;
  final String houseCost;
  final String transportCost;
  final String utilitiesCost;
  final String otherCost;

  CapacityRequest({
    required this.userId,
    required this.groupId,
    required this.incomeFamily,
    required this.peopleFamily,
    required this.house,
    required this.transport,
    required this.houseCost,
    required this.transportCost,
    required this.utilitiesCost,
    required this.otherCost,
  });

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'group_account_id': groupId,
      'income_family': incomeFamily,
      'people_family': peopleFamily,
      'house': house,
      'transport': transport,
      'house_cost': houseCost,
      'transport_cost': transportCost,
      'utilities_cost': utilitiesCost,
      'other_cost': otherCost,
    };
  }
}
