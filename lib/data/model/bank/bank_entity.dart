class Bank {
  final String code;
  final String name;
  final String ispb;

  Bank({
    required this.code,
    required this.name,
    required this.ispb,
  });

  factory Bank.fromJson(Map<String, dynamic> json) {
    return Bank(
      code: json['code'],
      name: json['name'],
      ispb: json['ispb'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'name': name,
      'ispb': ispb,
    };
  }
}
