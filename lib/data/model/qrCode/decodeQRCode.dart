class DecodeQRCode {
  bool success;
  String agentMode;
  String agentWithdrawalIspb;
  bool allowChange;
  bool allowAcceptance;
  String changeAmount;
  String city;
  int codeType;
  String dateCreated;
  String dateExpiration;
  String datePresentation;
  String description;
  List<Details> details;
  String discount;
  String dueDate;
  String fees;
  String finalAmount;
  String idEndToEnd;
  String idTx;
  Payee payee;
  Payer payer;
  String purchaseAmount;
  dynamic review;
  String title;
  String type;
  String withdrawalAmount;
  dynamic zipCode;

  DecodeQRCode({
    required this.success,
    required this.agentMode,
    required this.agentWithdrawalIspb,
    required this.allowChange,
    required this.allowAcceptance,
    required this.changeAmount,
    required this.city,
    required this.codeType,
    required this.dateCreated,
    required this.dateExpiration,
    required this.datePresentation,
    required this.description,
    required this.details,
    required this.discount,
    required this.dueDate,
    required this.fees,
    required this.finalAmount,
    required this.idEndToEnd,
    required this.idTx,
    required this.payee,
    required this.payer,
    required this.purchaseAmount,
    required this.review,
    required this.title,
    required this.type,
    required this.withdrawalAmount,
    required this.zipCode,
  });

  factory DecodeQRCode.fromJson(Map<String, dynamic> json) {
    return DecodeQRCode(
      success: json['success'],
      agentMode: json['agent_mode'],
      agentWithdrawalIspb: json['agent_withdrawal_ispb'],
      allowChange: json['allow_change'],
      allowAcceptance: json['allow_acceptance'],
      changeAmount: json['change_amount'],
      city: json['city'],
      codeType: json['code_type'],
      dateCreated: json['date_created'],
      dateExpiration: json['date_expiration'],
      datePresentation: json['date_presentation'],
      description: json['description'],
      details: List<Details>.from(json['details'].map((x) => Details.fromJson(x))),
      discount: json['discount'],
      dueDate: json['due_date'],
      fees: json['fees'],
      finalAmount: json['final_amount'],
      idEndToEnd: json['id_end_to_end'],
      idTx: json['id_tx'],
      payee: Payee.fromJson(json['payee']),
      payer: Payer.fromJson(json['payer']),
      purchaseAmount: json['purchase_amount'],
      review: json['review'],
      title: json['title'],
      type: json['type'],
      withdrawalAmount: json['withdrawal_amount'],
      zipCode: json['zip_code'],
    );
  }
}

class Details {
  String title;
  String content;

  Details({
    required this.title,
    required this.content,
  });

  factory Details.fromJson(Map<String, dynamic> json) {
    return Details(
      title: json['title'],
      content: json['content'],
    );
  }
}

class Payee {
  String bankAccountNumber;
  String bankAccountType;
  String bankBranchNumber;
  String bankName;
  String beneficiaryType;
  String document;
  String key;
  String ispb;
  String name;

  Payee({
    required this.bankAccountNumber,
    required this.bankAccountType,
    required this.bankBranchNumber,
    required this.bankName,
    required this.beneficiaryType,
    required this.document,
    required this.key,
    required this.ispb,
    required this.name,
  });

  factory Payee.fromJson(Map<String, dynamic> json) {
    return Payee(
      bankAccountNumber: json['bank_account_number'],
      bankAccountType: json['bank_account_type'],
      bankBranchNumber: json['bank_branch_number'],
      bankName: json['bank_name'],
      beneficiaryType: json['beneficiary_type'],
      document: json['document'],
      key: json['key'],
      ispb: json['ispb'],
      name: json['name'],
    );
  }
}

class Payer {
  String name;
  String beneficiaryType;
  String document;

  Payer({
    required this.name,
    required this.beneficiaryType,
    required this.document,
  });

  factory Payer.fromJson(Map<String, dynamic> json) {
    return Payer(
      name: json['name'],
      beneficiaryType: json['beneficiary_type'],
      document: json['document'],
    );
  }
}