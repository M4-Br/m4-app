// lib/features/accounting/model/accounting_summary_model.dart

import 'package:app_flutter_miban4/core/helpers/extensions/numbers.dart';

class AccountingSummaryModel {
  final String cnpj;
  final String referenceDate;
  final String taxClass;
  final String incomeRange;
  final double currentTaxDue;
  final int dueDay;
  final List<TaxObligation> history;

  AccountingSummaryModel({
    required this.cnpj,
    required this.referenceDate,
    required this.taxClass,
    required this.incomeRange,
    required this.currentTaxDue,
    required this.dueDay,
    required this.history,
  });

  factory AccountingSummaryModel.fromJson(Map<String, dynamic> json) {
    return AccountingSummaryModel(
        cnpj: json['cnpj'] as String,
        referenceDate: json['reference_date'] as String,
        taxClass: json['tax_class'] as String,
        incomeRange: json['income_range'] as String,
        currentTaxDue: (json['current_tax_due'] as String).toCurrencyDouble(),
        dueDay: json['due_date'] as int,
        history: (json['history'] as List<dynamic>)
            .map((e) => TaxObligation.fromJson(e as Map<String, dynamic>))
            .toList());
  }
}

class TaxObligation {
  final String monthYear;
  final double value;
  final String status;

  TaxObligation({
    required this.monthYear,
    required this.value,
    required this.status,
  });

  factory TaxObligation.fromJson(Map<String, dynamic> json) {
    return TaxObligation(
      monthYear: json[''] as String,
      value: (json[''] as String).toCurrencyDouble(),
      status: json[''] as String,
    );
  }
}
