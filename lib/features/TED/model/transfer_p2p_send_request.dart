class TransferP2pSendRequest {
  const TransferP2pSendRequest({
    required this.amount,
    required this.password,
    required this.username,
    required this.document,
  });

  final int amount;
  final String password;
  final String username;
  final String document;

  Map<String, dynamic> toJson() {
    return {
      'amount': amount,
      'password': password,
      'username': username,
      'document': document
    };
  }
}
