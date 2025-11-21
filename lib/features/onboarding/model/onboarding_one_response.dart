class OnboardingOneResponse {
  final bool success;
  final String message;
  final OnboardingUserData? data;

  OnboardingOneResponse({
    required this.success,
    required this.message,
    this.data,
  });

  factory OnboardingOneResponse.fromJson(Map<String, dynamic> json) {
    return OnboardingOneResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: json['data'] != null
          ? OnboardingUserData.fromJson(json['data'])
          : null,
    );
  }
}

class OnboardingUserData {
  final String name;
  final String email;
  final String document;
  final int individualId;
  final String status;
  final String updatedAt;
  final String createdAt;
  final int id;
  final List<Role> roles;
  final Individual individual;

  OnboardingUserData({
    required this.name,
    required this.email,
    required this.document,
    required this.individualId,
    required this.status,
    required this.updatedAt,
    required this.createdAt,
    required this.id,
    required this.roles,
    required this.individual,
  });

  factory OnboardingUserData.fromJson(Map<String, dynamic> json) {
    return OnboardingUserData(
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      document: json['document'] ?? '',
      individualId: json['individual_id'] ?? 0,
      status: json['status'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      createdAt: json['created_at'] ?? '',
      id: json['id'] ?? 0,
      roles: (json['roles'] as List<dynamic>? ?? [])
          .map((e) => Role.fromJson(e))
          .toList(),
      individual: Individual.fromJson(json['individual']),
    );
  }
}

class Role {
  final int id;
  final int userId;
  final String role;
  final String createdAt;
  final String updatedAt;

  Role({
    required this.id,
    required this.userId,
    required this.role,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Role.fromJson(Map<String, dynamic> json) {
    return Role(
      id: json['id'] ?? 0,
      userId: json['user_id'] ?? 0,
      role: json['role'] ?? '',
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
    );
  }
}

class Individual {
  final int id;
  final String name;
  final String username;
  final String email;
  final String document;
  final String type;
  final int? phonePrefix;
  final String? phone;
  final String? country;
  final String? city;
  final String? state;
  final int? individualAddressTypeId;
  final String? address;
  final String? addressNumber;
  final String? neighborhood;
  final String? postalCode;
  final String? complement;
  final String? nationality;
  final String? nationalityState;
  final int? individualProfessionTypeId;
  final num? professionIncome;
  final String? score;
  final String? steps;
  final String createdAt;
  final String updatedAt;
  final String? deletedAt;

  Individual({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.document,
    required this.type,
    this.phonePrefix,
    this.phone,
    this.country,
    this.city,
    this.state,
    this.individualAddressTypeId,
    this.address,
    this.addressNumber,
    this.neighborhood,
    this.postalCode,
    this.complement,
    this.nationality,
    this.nationalityState,
    this.individualProfessionTypeId,
    this.professionIncome,
    this.score,
    this.steps,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  factory Individual.fromJson(Map<String, dynamic> json) {
    return Individual(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      username: json['username'] ?? '',
      email: json['email'] ?? '',
      document: json['document'] ?? '',
      type: json['type'] ?? '',
      phonePrefix: json['phone_prefix'],
      phone: json['phone'],
      country: json['country'],
      city: json['city'],
      state: json['state'],
      individualAddressTypeId: json['individual_address_type_id'],
      address: json['address'],
      addressNumber: json['address_number'],
      neighborhood: json['neighborhood'],
      postalCode: json['postal_code'],
      complement: json['complement'],
      nationality: json['nationality'],
      nationalityState: json['nationality_state'],
      individualProfessionTypeId: json['individual_profession_type_id'],
      professionIncome: json['profession_income'],
      score: json['score']?.toString(),
      steps: json['steps']?.toString(),
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      deletedAt: json['deleted_at'],
    );
  }
}
