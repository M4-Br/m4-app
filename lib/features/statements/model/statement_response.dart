import 'package:app_flutter_miban4/core/helpers/extensions/numbers.dart';

class StatementResponse {
  const StatementResponse(
      {required this.totalDocs,
      required this.limit,
      required this.totalPages,
      required this.page,
      required this.pagingCounter,
      required this.hasPrevPage,
      required this.hasNextPage,
      required this.prevPage,
      required this.nextPage,
      required this.statements});

  factory StatementResponse.fromJson(Map<String, dynamic> json) {
    return StatementResponse(
      totalDocs: json['totalDocs'] as int,
      limit: json['limit'] as int,
      totalPages: json['totalPages'] as int,
      page: json['page'] as int,
      pagingCounter: json['pagingCounter'] as int,
      hasPrevPage: json['hasPrevPage'] as bool,
      hasNextPage: json['hasNextPage'] as bool,
      prevPage: json['prevPage'] as int,
      nextPage: json['nextPage'] as int,
      statements: (json['statements'] as List<dynamic>)
          .map((e) => Statements.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  final int totalDocs;
  final int limit;
  final int totalPages;
  final int page;
  final int pagingCounter;
  final bool hasPrevPage;
  final bool hasNextPage;
  final int prevPage;
  final int nextPage;
  final List<Statements> statements;
}

class Statements {
  const Statements({
    required this.idStatement,
    required this.description,
    required this.dayTransaction,
    required this.hourTransaction,
    required this.dateTransaction,
    required this.amount,
    required this.type,
    required this.typeDescription,
    required this.creditFlag,
  });

  factory Statements.fromJson(Map<String, dynamic> json) {
    return Statements(
      idStatement: json['id_statement'] as String,
      description: json['description'] as String,
      dayTransaction: json['day_transaction'] as int,
      hourTransaction: json['hour_transaction'] as String,
      dateTransaction: json['date_transaction'] as String,
      amount: (json['amount'] as String).toCurrencyDouble(),
      type: json['type'] as String,
      typeDescription: json['type_description'] as String,
      creditFlag: json['credit_flag'] as int,
    );
  }

  final String idStatement;
  final String description;
  final int dayTransaction;
  final String hourTransaction;
  final String dateTransaction;
  final double amount;
  final String type;
  final String typeDescription;
  final int creditFlag;
}
