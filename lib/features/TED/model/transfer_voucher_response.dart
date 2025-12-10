class TransferVoucher {
  final bool? success;
  final String? type;
  final String? status;
  final int? statementId;
  final String? transactionId;
  final String? transactionCode;
  final String? transactionDate;
  final String? description;
  final Payer? payer;
  final Receiver? receiver;
  final Values? values;

  TransferVoucher({
    required this.success,
    required this.type,
    required this.status,
    required this.statementId,
    required this.transactionId,
    required this.transactionCode,
    required this.transactionDate,
    required this.description,
    required this.payer,
    required this.receiver,
    required this.values,
  });

  factory TransferVoucher.fromJson(Map<String, dynamic> json) {
    return TransferVoucher(
      success: json['success'] as bool,
      type: json['type'] as String?,
      status: json['status'] as String?,
      statementId: json['statement_id'] as int?,
      transactionId: json['transaction_id'] as String?,
      transactionCode: json['transaction_code'] as String?,
      transactionDate: json['transaction_date'] as String?,
      description: json['description'] as String?,
      payer: Payer.fromJson(json['payer']),
      receiver: Receiver.fromJson(json['receiver']),
      values: Values.fromJson(json['values']),
    );
  }
}

class Payer {
  final String? payerUsername;
  final String? payerFullName;
  final String? payerDocument;
  final String? payerIdAccount;
  final String? payerBank;

  Payer({
    required this.payerUsername,
    required this.payerFullName,
    required this.payerDocument,
    required this.payerIdAccount,
    required this.payerBank,
  });

  factory Payer.fromJson(Map<String, dynamic> json) {
    return Payer(
      payerUsername: json['payer_username'] as String?,
      payerFullName: json['payer_full_name'] as String?,
      payerDocument: json['payer_document'] as String?,
      payerIdAccount: json['payer_id_account'] as String?,
      payerBank: json['payer_bank'] as String?,
    );
  }
}

class Receiver {
  final String? receiverUsername;
  final String? receiverFullName;
  final String? receiverDocument;
  final String? receiverIdAccount;
  final String? receiverBank;

  Receiver({
    required this.receiverUsername,
    required this.receiverFullName,
    required this.receiverDocument,
    required this.receiverIdAccount,
    required this.receiverBank,
  });

  factory Receiver.fromJson(Map<String, dynamic> json) {
    return Receiver(
      receiverUsername: json['receiver_username'] as String?,
      receiverFullName: json['receiver_full_name'] as String?,
      receiverDocument: json['receiver_document'] as String?,
      receiverIdAccount: json['receiver_id_account'] as String?,
      receiverBank: json['receiver_bank'] as String?,
    );
  }
}

class Values {
  final int? originalAmount;
  final int? receivableAmount;
  final int? fees;

  Values({
    required this.originalAmount,
    required this.receivableAmount,
    required this.fees,
  });

  factory Values.fromJson(Map<String, dynamic> json) {
    return Values(
      originalAmount: json['original_amount'] as int?,
      receivableAmount: json['receivable_amount'] as int?,
      fees: json['fees'] as int?,
    );
  }
}
