import 'package:app_flutter_miban4/core/helpers/extensions/numbers.dart';

class PixStatementResponse {
  final bool success;
  final List<PixTransaction> list;

  PixStatementResponse({required this.success, required this.list});

  factory PixStatementResponse.fromJson(Map<String, dynamic> json) {
    return PixStatementResponse(
      success: json['success'] as bool? ?? false,
      list: json['list'] != null
          ? (json['list'] as List)
              .map((e) => PixTransaction.fromJson(e))
              .toList()
          : [],
    );
  }
}

class PixTransaction {
  final String id;
  final String idEndToEnd;
  final double amount;
  final PixTransactionDetails details;

  PixTransaction({
    required this.id,
    required this.idEndToEnd,
    required this.amount,
    required this.details,
  });

  factory PixTransaction.fromJson(Map<String, dynamic> json) {
    return PixTransaction(
      id: json['id'] as String? ?? '',
      idEndToEnd: json['id_end_to_end'] as String? ?? '',
      // Usa sua extensão para converter "500" -> 5.00
      amount: (json['amount'] as String? ?? '0').toCurrencyDouble(),
      details: PixTransactionDetails.fromJson(json['details'] ?? {}),
    );
  }
}

class PixTransactionDetails {
  final String transactionDate;
  final String transactionStatus;
  final String transactionType;
  final PixStatementParty payer;
  final PixStatementParty payee;

  PixTransactionDetails({
    required this.transactionDate,
    required this.transactionStatus,
    required this.transactionType,
    required this.payer,
    required this.payee,
  });

  factory PixTransactionDetails.fromJson(Map<String, dynamic> json) {
    return PixTransactionDetails(
      transactionDate: json['transaction_date'] as String? ?? '',
      transactionStatus: json['transaction_status'] as String? ?? '',
      transactionType: json['transaction_type'] as String? ?? '',
      payer: PixStatementParty.fromJson(json['payer'] ?? {}),
      payee: PixStatementParty.fromJson(json['payee'] ?? {}),
    );
  }
}

class PixStatementParty {
  final String name;
  final String document;
  final String bankName;

  PixStatementParty({
    required this.name,
    required this.document,
    required this.bankName,
  });

  factory PixStatementParty.fromJson(Map<String, dynamic> json) {
    return PixStatementParty(
      name: json['name'] as String? ?? 'Desconhecido',
      document: json['document'] as String? ?? '',
      bankName: json['bank_name'] as String? ?? '',
    );
  }
}
