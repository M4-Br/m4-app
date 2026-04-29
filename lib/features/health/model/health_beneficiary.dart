class HealthBeneficiary {
  final String uuid;
  final String name;
  final String cpf;
  final String birthday;
  final String phone;
  final String email;
  final String zipCode;
  final String address;
  final String city;
  final String state;
  final List<HealthPlanInfo> plans;
  final bool isActive;
  final DateTime? createdAt;

  HealthBeneficiary({
    required this.uuid,
    required this.name,
    required this.cpf,
    required this.birthday,
    required this.phone,
    required this.email,
    required this.zipCode,
    required this.address,
    required this.city,
    required this.state,
    required this.plans,
    required this.isActive,
    this.createdAt,
  });

  factory HealthBeneficiary.fromJson(Map<String, dynamic> json) {
    return HealthBeneficiary(
      uuid: json['uuid'] ?? '',
      name: json['name'] ?? '',
      cpf: json['cpf'] ?? '',
      birthday: json['birthday'] ?? '',
      phone: json['phone'] ?? '',
      email: json['email'] ?? '',
      zipCode: json['zipCode'] ?? '',
      address: json['address'] ?? '',
      city: json['city'] ?? '',
      state: json['state'] ?? '',
      plans: (json['plans'] as List? ?? [])
          .map((e) => HealthPlanInfo.fromJson(e))
          .toList(),
      isActive: json['isActive'] ?? false,
      createdAt: json['createdAt'] != null ? DateTime.tryParse(json['createdAt']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uuid': uuid,
      'name': name,
      'cpf': cpf,
      'birthday': birthday,
      'phone': phone,
      'email': email,
      'zipCode': zipCode,
      'address': address,
      'city': city,
      'state': state,
      'plans': plans.map((e) => e.toJson()).toList(),
      'isActive': isActive,
      'createdAt': createdAt?.toIso8601String(),
    };
  }
}

class HealthPlanInfo {
  final String paymentType;
  final HealthPlan plan;

  HealthPlanInfo({
    required this.paymentType,
    required this.plan,
  });

  factory HealthPlanInfo.fromJson(Map<String, dynamic> json) {
    return HealthPlanInfo(
      paymentType: json['paymentType'] ?? '',
      plan: HealthPlan.fromJson(json['plan'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'paymentType': paymentType,
      'plan': plan.toJson(),
    };
  }
}

class HealthPlan {
  final String uuid;
  final String name;

  HealthPlan({
    required this.uuid,
    required this.name,
  });

  factory HealthPlan.fromJson(Map<String, dynamic> json) {
    return HealthPlan(
      uuid: json['uuid'] ?? '',
      name: json['name'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uuid': uuid,
      'name': name,
    };
  }
}
