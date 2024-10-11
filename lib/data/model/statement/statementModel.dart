class StatementModel {
  int? totalDocs;
  int? limit;
  int? totalPages;
  int? page;
  int? pagingCounter;
  bool? hasPrevPage;
  bool? hasNextPage;
  int? prevPage;
  int? nextPage;
  List<Statement>? statements;

  StatementModel({
    this.totalDocs,
    this.limit,
    this.totalPages,
    this.page,
    this.pagingCounter,
    this.hasPrevPage,
    this.hasNextPage,
    this.prevPage,
    this.nextPage,
    this.statements,
  });

  StatementModel.fromJson(Map<String, dynamic> json) {
    totalDocs = json['totalDocs'];
    limit = json['limit'];
    totalPages = json['totalPages'];
    page = json['page'];
    pagingCounter = json['pagingCounter'];
    hasPrevPage = json['hasPrevPage'];
    hasNextPage = json['hasNextPage'];
    prevPage = json['prevPage'];
    nextPage = json['nextPage'];
    statements = json['statements']
        ?.map<Statement>((statement) => Statement.fromJson(statement))
        .toList();
  }

  Map<String, dynamic> toJson() {
    return {
      'totalDocs': totalDocs,
      'limit': limit,
      'totalPages': totalPages,
      'page': page,
      'pagingCounter': pagingCounter,
      'hasPrevPage': hasPrevPage,
      'hasNextPage': hasNextPage,
      'prevPage': prevPage,
      'nextPage': nextPage,
      'statements': statements?.map((statement) => statement.toJson()).toList(),
    };
  }
}

class Statement {
  String? idStatement;
  String? description;
  int? dayTransaction;
  String? hourTransaction;
  String? dateTransaction;
  String? amount;
  String? type;
  String? typeDescription;
  int? creditFlag;

  Statement({
    this.idStatement,
    this.description,
    this.dayTransaction,
    this.hourTransaction,
    this.dateTransaction,
    this.amount,
    this.type,
    this.typeDescription,
    this.creditFlag,
  });

  Statement.fromJson(Map<String, dynamic> json) {
    idStatement = json['id_statement'];
    description = json['description'];
    dayTransaction = json['day_transaction'];
    hourTransaction = json['hour_transaction'];
    dateTransaction = json['date_transaction'];
    amount = json['amount'];
    type = json['type'];
    typeDescription = json['type_description'];
    creditFlag = json['credit_flag'];
  }

  Map<String, dynamic> toJson() {
    return {
      'idStatement': idStatement,
      'description': description,
      'dayTransaction': dayTransaction,
      'hourTransaction': hourTransaction,
      'dateTransaction': dateTransaction,
      'amount': amount,
      'type': type,
      'typeDescription': typeDescription,
      'creditFlag': creditFlag,
    };
  }
}