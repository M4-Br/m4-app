class UserTransfer {
  final bool? success;
  final String? username;
  final String? fullName;
  final String? accountNumber;
  final String? document;
  final String? email;
  final String? avatarUrl;

  UserTransfer({
    this.success,
    this.username,
    this.fullName,
    this.accountNumber,
    this.document,
    this.email,
    this.avatarUrl,
  });

  factory UserTransfer.fromJson(Map<String, dynamic> json) {
    return UserTransfer(
      success: json['success'],
      username: json['username'],
      fullName: json['full_name'],
      accountNumber: json['account_number'],
      document: json['document'],
      email: json['email'],
      avatarUrl: json['avatar_url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'username': username,
      'full_name': fullName,
      'account_number': accountNumber,
      'document': document,
      'email': email,
      'avatar_url': avatarUrl,
    };
  }
}
