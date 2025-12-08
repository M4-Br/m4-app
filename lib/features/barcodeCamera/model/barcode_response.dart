import 'package:app_flutter_miban4/core/helpers/extensions/numbers.dart';

class BarcodeResponse {
  final bool success;
  final String barCode;
  final String digitableLine;
  final String dueDate;
  final String assignor;
  final Payer payer;
  final Details details;
  final double amount;

  BarcodeResponse({
    required this.success,
    required this.barCode,
    required this.digitableLine,
    required this.dueDate,
    required this.assignor,
    required this.payer,
    required this.details,
    required this.amount,
  });

  factory BarcodeResponse.fromJson(Map<String, dynamic> json) {
    return BarcodeResponse(
      success: json['success'] as bool,
      barCode: json['bar_code'] as String,
      digitableLine: json['digitable_line'] as String,
      dueDate: json['due_date'] as String,
      assignor: json['assignor'] as String,
      payer: Payer.fromJson(json['payer']),
      details: Details.fromJson(json['details']),
      amount: (json['amount'] as String).toCurrencyDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'bar_code': barCode,
      'digitable_line': digitableLine,
      'due_date': dueDate,
      'assignor': assignor,
      'payer': payer.toJson(),
      'details': details.toJson(),
      'amount': amount,
    };
  }
}

class Payer {
  final String name;
  final String document;

  Payer({
    required this.name,
    required this.document,
  });

  factory Payer.fromJson(Map<String, dynamic> json) {
    return Payer(
      name: json['name'] as String,
      document: json['document'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'document': document,
    };
  }
}

class Details {
  final String originalAmount;
  final String fine;
  final String interest;
  final String discount;
  final String finalAmount;

  Details({
    required this.originalAmount,
    required this.fine,
    required this.interest,
    required this.discount,
    required this.finalAmount,
  });

  factory Details.fromJson(Map<String, dynamic> json) {
    return Details(
      originalAmount: json['original_amount'] as String,
      fine: json['fine'] as String,
      interest: json['interest'] as String,
      discount: json['discount'] as String,
      finalAmount: json['final_amount'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'original_amount': originalAmount,
      'fine': fine,
      'interest': interest,
      'discount': discount,
      'final_amount': finalAmount,
    };
  }
}
