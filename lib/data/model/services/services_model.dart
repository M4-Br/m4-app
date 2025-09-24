class ServicesModel {
  const ServicesModel({
    required this.success,
    required this.data,
  });

  final bool success;
  final List<ServicesData> data;

  factory ServicesModel.fromJson(Map<String, dynamic> json) {
    return ServicesModel(
      success: json['success'] as bool,
      data: (json['data'] as List<dynamic>)
          .map((item) => ServicesData.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }
}

class ServicesData {
  const ServicesData({
    required this.id,
    required this.description,
    required this.value,
    required this.companyId,
    required this.status,
    required this.company,
  });

  final int id;
  final String description;
  final int value; // 👈 novo
  final int companyId;
  final String status;
  final Company company; // 👈 renomeado

  factory ServicesData.fromJson(Map<String, dynamic> json) {
    return ServicesData(
      id: json['id'] as int,
      description: json['description'] as String,
      value: json['value'] as int,
      companyId: json['company_id'] as int,
      status: json['status'] as String,
      company: Company.fromJson(json['company'] as Map<String, dynamic>),
    );
  }
}

class Company {
  const Company({
    required this.id,
    required this.name,
    required this.document,
    required this.tradeName,
    required this.email,
    required this.phone,
    required this.status,
  });

  final int id;
  final String name;
  final String document;
  final String tradeName;
  final String email;
  final String phone;
  final String status;

  factory Company.fromJson(Map<String, dynamic> json) {
    return Company(
      id: json['id'] as int,
      name: json['name'] as String,
      document: json['document'] as String,
      tradeName: json['trade_name'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
      status: json['status'] as String,
    );
  }
}
