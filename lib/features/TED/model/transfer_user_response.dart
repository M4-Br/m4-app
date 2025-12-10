class TransferUserResponse {
  final int? id;
  final String? name;
  final String? username;
  final String? document;
  final String? email;
  final TransferUserPerson? person;

  TransferUserResponse({
    required this.id,
    required this.name,
    required this.username,
    required this.document,
    required this.email,
    required this.person,
  });

  factory TransferUserResponse.fromJson(Map<String, dynamic> json) {
    return TransferUserResponse(
      id: json['id'] as int? ?? 0,
      name: json['name'] as String? ?? '',
      username: json['username'] as String? ?? '',
      document: json['document'] as String? ?? '',
      email: json['email'] as String? ?? '',
      person: TransferUserPerson.fromJson(json['person'] ?? {}),
    );
  }
}

class TransferUserPerson {
  final String branch;
  final String branchName;
  final String accountNumber;
  final String accountType;
  final String bankCode;
  final String bankName;

  TransferUserPerson({
    required this.branch,
    required this.branchName,
    required this.accountNumber,
    required this.accountType,
    required this.bankCode,
    required this.bankName,
  });

  factory TransferUserPerson.fromJson(Map<String, dynamic> json) {
    return TransferUserPerson(
      branch: json['branch'] as String? ?? '',
      branchName: json['branch_name'] as String? ?? '',
      accountNumber: json['account_number'] as String? ?? '',
      accountType: json['account_type'] as String? ?? '',
      bankCode: json['bank_code'] as String? ?? '',
      bankName: json['bank_name'] as String? ?? '',
    );
  }
}
