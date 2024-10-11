class Transaction {
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

  Transaction({
    this.success,
    this.type,
    this.status,
    this.statementId,
    this.transactionId,
    this.transactionCode,
    this.transactionDate,
    this.description,
    this.payer,
    this.receiver,
    this.values,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      success: json['success'],
      type: json['type'],
      status: json['status'],
      statementId: json['statement_id'],
      transactionId: json['transaction_id'],
      transactionCode: json['transaction_code'],
      transactionDate: json['transaction_date'],
      description: json['description'],
      payer: Payer.fromJson(json['payer']),
      receiver: Receiver.fromJson(json['receiver']),
      values: Values.fromJson(json['values']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'type': type,
      'status': status,
      'statement_id': statementId,
      'transaction_id': transactionId,
      'transaction_code': transactionCode,
      'transaction_date': transactionDate,
      'description': description,
      'payer': payer?.toJson(),
      'receiver': receiver?.toJson(),
      'values': values?.toJson(),
    };
  }
}

class Payer {
  final String? payerUsername;
  final String? payerFullName;
  final String? payerDocument;
  final String? payerIdAccount;
  final String? payerBank;

  Payer({
    this.payerUsername,
    this.payerFullName,
    this.payerDocument,
    this.payerIdAccount,
    this.payerBank,
  });

  factory Payer.fromJson(Map<String, dynamic> json) {
    return Payer(
      payerUsername: json['payer_username'],
      payerFullName: json['payer_full_name'],
      payerDocument: json['payer_document'],
      payerIdAccount: json['payer_id_account'],
      payerBank: json['payer_bank'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'payer_username': payerUsername,
      'payer_full_name': payerFullName,
      'payer_document': payerDocument,
      'payer_id_account': payerIdAccount,
      'payer_bank': payerBank,
    };
  }
}

class Receiver {
  final String? receiverUsername;
  final String? receiverFullName;
  final String? receiverDocument;
  final String? receiverIdAccount;
  final String? receiverBank;

  Receiver({
    this.receiverUsername,
    this.receiverFullName,
    this.receiverDocument,
    this.receiverIdAccount,
    this.receiverBank,
  });

  factory Receiver.fromJson(Map<String, dynamic> json) {
    return Receiver(
      receiverUsername: json['receiver_username'],
      receiverFullName: json['receiver_full_name'],
      receiverDocument: json['receiver_document'],
      receiverIdAccount: json['receiver_id_account'],
      receiverBank: json['receiver_bank'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'receiver_username': receiverUsername,
      'receiver_full_name': receiverFullName,
      'receiver_document': receiverDocument,
      'receiver_id_account': receiverIdAccount,
      'receiver_bank': receiverBank,
    };
  }
}

class Values {
  final int? originalAmount;
  final int? receivableAmount;
  final int? fees;

  Values({
    this.originalAmount,
    this.receivableAmount,
    this.fees,
  });

  factory Values.fromJson(Map<String, dynamic> json) {
    return Values(
      originalAmount: json['original_amount'],
      receivableAmount: json['receivable_amount'],
      fees: json['fees'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'original_amount': originalAmount,
      'receivable_amount': receivableAmount,
      'fees': fees,
    };
  }
}
