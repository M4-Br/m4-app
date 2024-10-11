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

class PixKeys {
  final bool success;
  final List<PhoneKey> phones;
  final List<Document> documents;
  final List<Email> emails;
  final List<Evp> evps;

  PixKeys({
    required this.success,
    required this.phones,
    required this.documents,
    required this.emails,
    required this.evps,
  });

  factory PixKeys.fromJson(Map<String, dynamic> json) {
    return PixKeys(
      success: json['success'],
      phones: (json['phone'] as List)
          .map((item) => PhoneKey(
        key: item['key'],
        dateKeyCreated: item['date_key_created'],
        dateKeyOwnership: item['date_key_ownership'],
        keyStatus: item['key_status'],
      ))
          .toList(),
      documents: (json['document'] as List)
          .map((item) => Document(
        key: item['key'],
        dateKeyCreated: item['date_key_created'],
        dateKeyOwnership: item['date_key_ownership'],
        keyStatus: item['key_status'],
      ))
          .toList(),
      emails: (json['email'] as List)
          .map((item) => Email(
        key: item['key'],
        dateKeyCreated: item['date_key_created'],
        dateKeyOwnership: item['date_key_ownership'],
        keyStatus: item['key_status'],
      ))
          .toList(),
      evps: (json['evp'] as List)
          .map((item) => Evp(
        key: item['key'],
        dateKeyCreated: item['date_key_created'],
        dateKeyOwnership: item['date_key_ownership'],
        keyStatus: item['key_status'],
      ))
          .toList(),
    );
  }
}
