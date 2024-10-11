class BankList {
  final String code;
  final String name;
  final String ispb;

  BankList({
    required this.code,
    required this.name,
    required this.ispb,
  });

  factory BankList.fromJson(Map<String, dynamic> json) => BankList(
    code: json['code'] as String,
    name: json['name'] as String,
    ispb: json['ispb'] as String,
  );
}