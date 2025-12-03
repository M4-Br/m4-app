// Importe sua extensão aqui
import 'package:app_flutter_miban4/core/helpers/extensions/numbers.dart';

class PixDecodeResponse {
  final bool success;
  final String agentMode;
  final String agentWithdrawalIspb;
  final bool allowChange;
  final bool allowAcceptance;
  final double changeAmount;
  final String city;
  final int codeType;
  final String dateCreated;
  final String dateExpiration;
  final String datePresentation;
  final String description;
  final List<Details> details;
  final double discount;
  final DateTime? dueDate;
  final double fees;
  final double finalAmount;
  final String idEndToEnd;
  final String idTx;
  final Payee payee;
  final Payer payer;
  final double purchaseAmount;
  final String? review;
  final String title;
  final String type;
  final double withdrawalAmount;
  final String? zipCode;

  PixDecodeResponse({
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
    this.review,
    required this.title,
    required this.type,
    required this.withdrawalAmount,
    this.zipCode,
  });

  factory PixDecodeResponse.fromJson(Map<String, dynamic> json) {
    return PixDecodeResponse(
      success: json['success'] as bool? ?? false,
      agentMode: json['agent_mode'] as String? ?? '',
      agentWithdrawalIspb: json['agent_withdrawal_ispb'] as String? ?? '',
      allowChange: json['allow_change'] as bool? ?? false,
      allowAcceptance: json['allow_acceptance'] as bool? ?? false,
      changeAmount:
          (json['change_amount'] as String? ?? '0').toCurrencyDouble(),
      city: json['city'] as String? ?? '',
      codeType: json['code_type'] as int? ?? 0,
      dateCreated: json['date_created'] as String? ?? '',
      dateExpiration: json['date_expiration'] as String? ?? '',
      datePresentation: json['date_presentation'] as String? ?? '',
      description: json['description'] as String? ?? '',
      details: json['details'] != null
          ? List<Details>.from(json['details'].map((x) => Details.fromJson(x)))
          : [],
      discount: (json['discount'] as String? ?? '0').toCurrencyDouble(),
      dueDate:
          json['due_date'] != null ? DateTime.tryParse(json['due_date']) : null,
      fees: (json['fees'] as String? ?? '0').toCurrencyDouble(),
      finalAmount: (json['final_amount'] as String? ?? '0').toCurrencyDouble(),
      idEndToEnd: json['id_end_to_end'] as String? ?? '',
      idTx: json['id_tx'] as String? ?? '',
      payee: Payee.fromJson(json['payee'] ?? {}),
      payer: Payer.fromJson(json['payer'] ?? {}),
      purchaseAmount:
          (json['purchase_amount'] as String? ?? '0').toCurrencyDouble(),
      review: json['review'] as String?,
      title: json['title'] as String? ?? '',
      type: json['type'] as String? ?? '',
      withdrawalAmount:
          (json['withdrawal_amount'] as String? ?? '0').toCurrencyDouble(),
      zipCode: json['zip_code'] as String?,
    );
  }
}

class Details {
  String title;
  String content;

  Details({required this.title, required this.content});

  factory Details.fromJson(Map<String, dynamic> json) {
    return Details(
      title: json['title'] as String? ?? '',
      content: json['content'] as String? ?? '',
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
      bankAccountNumber: json['bank_account_number'] as String? ?? '',
      bankAccountType: json['bank_account_type'] as String? ?? '',
      bankBranchNumber: json['bank_branch_number'] as String? ?? '',
      bankName: json['bank_name'] as String? ?? '',
      beneficiaryType: json['beneficiary_type'] as String? ?? '',
      document: json['document'] as String? ?? '',
      key: json['key'] as String? ?? '',
      ispb: json['ispb'] as String? ?? '',
      name: json['name'] as String? ?? '',
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
      name: json['name'] as String? ?? '',
      beneficiaryType: json['beneficiary_type'] as String? ?? '',
      document: json['document'] as String? ?? '',
    );
  }
}
