class PhoneKey {
  final String key;
  final String dateKeyCreated;
  final String dateKeyOwnership;
  final String keyStatus;

  PhoneKey({
    required this.key,
    required this.dateKeyCreated,
    required this.dateKeyOwnership,
    required this.keyStatus,
  });
}

class Document {
  final String key;
  final String dateKeyCreated;
  final String dateKeyOwnership;
  final String keyStatus;

  Document({
    required this.key,
    required this.dateKeyCreated,
    required this.dateKeyOwnership,
    required this.keyStatus,
  });
}

class Email {
  final String key;
  final String dateKeyCreated;
  final String dateKeyOwnership;
  final String keyStatus;

  Email({
    required this.key,
    required this.dateKeyCreated,
    required this.dateKeyOwnership,
    required this.keyStatus,
  });
}

class Evp {
  final String key;
  final String dateKeyCreated;
  final String dateKeyOwnership;
  final String keyStatus;

  Evp({
    required this.key,
    required this.dateKeyCreated,
    required this.dateKeyOwnership,
    required this.keyStatus,
  });
}

class PixKeyResponse {
  final bool success;
  final List<PhoneKey> phones;
  final List<Document> documents;
  final List<Email> emails;
  final List<Evp> evps;

  PixKeyResponse({
    required this.success,
    required this.phones,
    required this.documents,
    required this.emails,
    required this.evps,
  });

  factory PixKeyResponse.fromJson(Map<String, dynamic> json) {
    return PixKeyResponse(
      success: json['success'] as bool,
      phones: (json['phone'] as List)
          .map((item) => PhoneKey(
                key: item['key'] as String,
                dateKeyCreated: item['date_key_created'] as String,
                dateKeyOwnership: item['date_key_ownership'] as String,
                keyStatus: item['key_status'] as String,
              ))
          .toList(),
      documents: (json['document'] as List)
          .map((item) => Document(
                key: item['key'] as String,
                dateKeyCreated: item['date_key_created'] as String,
                dateKeyOwnership: item['date_key_ownership'] as String,
                keyStatus: item['key_status'] as String,
              ))
          .toList(),
      emails: (json['email'] as List)
          .map((item) => Email(
                key: item['key'] as String,
                dateKeyCreated: item['date_key_created'] as String,
                dateKeyOwnership: item['date_key_ownership'] as String,
                keyStatus: item['key_status'] as String,
              ))
          .toList(),
      evps: (json['evp'] as List)
          .map((item) => Evp(
                key: item['key'] as String,
                dateKeyCreated: item['date_key_created'] as String,
                dateKeyOwnership: item['date_key_ownership'] as String,
                keyStatus: item['key_status'] as String,
              ))
          .toList(),
    );
  }
}
