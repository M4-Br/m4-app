class PixCreateKey {
  bool success;
  List<Map<String, dynamic>> document;
  List<Map<String, dynamic>> phone;
  List<Map<String, dynamic>> email;
  List<Evp> evp;

  PixCreateKey({
    required this.success,
    required this.document,
    required this.phone,
    required this.email,
    required this.evp,
  });

  factory PixCreateKey.fromJson(Map<String, dynamic> json) {
    return PixCreateKey(
      success: json['success'],
      document: List<Map<String, dynamic>>.from(json['document']),
      phone: List<Map<String, dynamic>>.from(json['phone']),
      email: List<Map<String, dynamic>>.from(json['email']),
      evp: List<Evp>.from(json['evp'].map((x) => Evp.fromJson(x))),
    );
  }
}

class Evp {
  String key;
  String dateKeyCreated;
  String dateKeyOwnership;
  String keyStatus;
  Map<String, dynamic> claim;

  Evp({
    required this.key,
    required this.dateKeyCreated,
    required this.dateKeyOwnership,
    required this.keyStatus,
    required this.claim,
  });

  factory Evp.fromJson(Map<String, dynamic> json) {
    return Evp(
      key: json['key'],
      dateKeyCreated: json['date_key_created'],
      dateKeyOwnership: json['date_key_ownership'],
      keyStatus: json['key_status'],
      claim: json['claim'],
    );
  }
}