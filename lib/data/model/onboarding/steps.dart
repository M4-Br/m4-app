class GetStep {
  final int? id;
  final String? name;
  final String? username;
  final String? email;
  final String? document;
  final String? type;
  final String? phonePrefix;
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
  final int? professionIncome;
  final int? score;
  final List<Step>? steps;
  final String? createdAt;
  final String? updatedAt;
  final String? deletedAt;
  final int? individualId;
  final String? phoneNumber;
  final String? message;

  GetStep({
    this.id,
    this.name,
    this.username,
    this.email,
    this.document,
    this.type,
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
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.individualId,
    this.phoneNumber,
    this.message
  });

  factory GetStep.fromJson(Map<String, dynamic> json) {
    List<Step>? stepsList = (json['steps'] as List<dynamic>)
        .map((step) => Step.fromJson(step))
        .toList();

    return GetStep(
      id: json['id'],
      name: json['name'],
      username: json['username'],
      email: json['email'],
      document: json['document'],
      type: json['type'],
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
      score: json['score'],
      steps: stepsList,
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      deletedAt: json['deleted_at'],
      individualId: json['individual_id'],
      phoneNumber: json['phone_number'],
      message: json['message']
    );
  }
}

class Step {
  final int? stepId;
  final String? name;
  final bool? done;

  Step({this.stepId, this.name, this.done});

  factory Step.fromJson(Map<String, dynamic> json) {
    return Step(
      stepId: json['step_id'],
      name: json['name'],
      done: json['done'],
    );
  }
}
