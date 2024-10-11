class PixStatementModel {
  final bool success;
  final List<TransactionItem> list;

  PixStatementModel({required this.success, required this.list});

  factory PixStatementModel.fromJson(Map<String, dynamic> json) {
    return PixStatementModel(
      success: json['success'] ?? false,
      list: (json['list'] as List<dynamic>?)
          ?.map((item) => TransactionItem.fromJson(item))
          .toList() ??
          [],
    );
  }
}

class TransactionItem {
  final String id;
  final String idEndToEnd;
  final String amount;
  final TransactionDetails details;

  TransactionItem({
    required this.id,
    required this.idEndToEnd,
    required this.amount,
    required this.details,
  });

  factory TransactionItem.fromJson(Map<String, dynamic> json) {
    return TransactionItem(
      id: json['id'] ?? '',
      idEndToEnd: json['id_end_to_end'] ?? '',
      amount: json['amount'] ?? '',
      details: TransactionDetails.fromJson(json['details'] ?? {}),
    );
  }
}

class TransactionDetails {
  final String transactionDate;
  final String transactionDateFormatted;
  final String transactionDateFormatted2;
  final String transactionType;
  final String transactionStatus;
  final int transferType;
  final TransactionParty payer;
  final TransactionParty payee;

  TransactionDetails({
    required this.transactionDate,
    required this.transactionDateFormatted,
    required this.transactionDateFormatted2,
    required this.transactionType,
    required this.transactionStatus,
    required this.transferType,
    required this.payer,
    required this.payee,
  });

  factory TransactionDetails.fromJson(Map<String, dynamic> json) {
    return TransactionDetails(
      transactionDate: json['transaction_date'] ?? '',
      transactionDateFormatted: json['transaction_date_formated'] ?? '',
      transactionDateFormatted2: json['transaction_date_formated2'] ?? '',
      transactionType: json['transaction_type'] ?? '',
      transactionStatus: json['transaction_status'] ?? '',
      transferType: json['transfer_type'] ?? 0,
      payer: TransactionParty.fromJson(json['payer'] ?? {}),
      payee: TransactionParty.fromJson(json['payee'] ?? {}),
    );
  }
}

class TransactionParty {
  final String ispb;
  final String bankName;
  final String bankAccountNumber;
  final dynamic bankBranchNumber;
  final String bankAccountType;
  final String beneficiaryType;
  final String document;
  final String name;
  final String description;

  TransactionParty({
    required this.ispb,
    required this.bankName,
    required this.bankAccountNumber,
    required this.bankBranchNumber,
    required this.bankAccountType,
    required this.beneficiaryType,
    required this.document,
    required this.name,
    required this.description,
  });

  factory TransactionParty.fromJson(Map<String, dynamic> json) {
    return TransactionParty(
      ispb: json['ispb'] ?? '',
      bankName: json['bank_name'] ?? '',
      bankAccountNumber: json['bank_account_number'] ?? '',
      bankBranchNumber: json['bank_branch_number'] ?? '',
      bankAccountType: json['bank_account_type'] ?? '',
      beneficiaryType: json['beneficiary_type'] ?? '',
      document: json['document'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
    );
  }
}
