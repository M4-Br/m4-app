class InternQRCode {
  bool success;
  String username;
  String fullName;
  String avatarUrl;
  String document;
  String accountNumber;

  InternQRCode({
    required this.success,
    required this.username,
    required this.fullName,
    required this.avatarUrl,
    required this.document,
    required this.accountNumber,
  });

  factory InternQRCode.fromJson(Map<String, dynamic> json) {
    return InternQRCode(
      success: json['success'],
      username: json['username'],
      fullName: json['full_name'],
      avatarUrl: json['avatar_url'],
      document: json['document'],
      accountNumber: json['account_number'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'username': username,
      'full_name': fullName,
      'avatar_url': avatarUrl,
      'document': document,
      'account_number': accountNumber
    };
  }
}
