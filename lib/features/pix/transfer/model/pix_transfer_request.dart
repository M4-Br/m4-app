class PixTransferRequest {
  final String amount;
  final String description;
  final String idEndToEnd;
  final String password;
  final String idTx;
  final int transferType;
  final String startDate;
  final String endDate;
  final PixTransferPayee payee;

  PixTransferRequest({
    required this.amount,
    required this.description,
    required this.idEndToEnd,
    required this.password,
    required this.idTx,
    required this.transferType,
    required this.startDate,
    required this.endDate,
    required this.payee,
  });

  Map<String, dynamic> toJson() {
    return {
      'amount': amount,
      'description': description,
      'id_end_to_end': idEndToEnd,
      'password': password,
      'id_tx': idTx,
      'transfer_type': transferType,
      'startDate': startDate,
      'endDate': endDate,
      'payee': payee.toJson(),
    };
  }
}

class PixTransferPayee {
  final String bankAccountNumber;
  final String bankAccountType;
  final String bankBranchNumber;
  final String beneficiaryType;
  final String document;
  final String ispb;
  final String name;
  final String key;

  PixTransferPayee({
    required this.bankAccountNumber,
    required this.bankAccountType,
    required this.bankBranchNumber,
    required this.beneficiaryType,
    required this.document,
    required this.ispb,
    required this.name,
    required this.key,
  });

  Map<String, dynamic> toJson() {
    return {
      'bank_account_number': bankAccountNumber,
      'bank_account_type': bankAccountType,
      'bank_branch_number': bankBranchNumber,
      'beneficiary_type': beneficiaryType,
      'document': document,
      'ispb': ispb,
      'name': name,
      'key': key,
    };
  }
}
