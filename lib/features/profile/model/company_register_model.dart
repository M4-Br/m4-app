class CompanyRegisterModel {
  final String name;
  final String document;
  final String tradeName;
  final String email;
  final String phone;
  final String status;

  CompanyRegisterModel({
    required this.name,
    required this.document,
    required this.tradeName,
    required this.email,
    required this.phone,
    required this.status,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'document': document,
      'trade_name': tradeName,
      'email': email,
      'phone': phone,
      'status': status,
    };
  }

  factory CompanyRegisterModel.fromJson(Map<String, dynamic> json) {
    return CompanyRegisterModel(
      name: json['name'],
      document: json['document'],
      tradeName: json['trade_name'],
      email: json['email'],
      phone: json['phone'],
      status: json['status'],
    );
  }
}
