import 'package:flutter/foundation.dart';

class BankUser {
  final int? id;
  final String? personId;
  final int? individualId;
  final String? personType;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? accountId;
  final String? branch;
  final String? branchName;
  final String? accountNumber;
  final String? accountType;
  final String? bankCode;
  final String? bankName;
  final String? economyAccountId;
  final String? economyAccountNumber;
  final String? economyAccountType;

  BankUser({
    this.id,
    this.personId,
    this.individualId,
    this.personType,
    this.createdAt,
    this.updatedAt,
    this.accountId,
    this.branch,
    this.branchName,
    this.accountNumber,
    this.accountType,
    this.bankCode,
    this.bankName,
    this.economyAccountId,
    this.economyAccountNumber,
    this.economyAccountType,
  });

  factory BankUser.fromJson(Map<String, dynamic> json) {
    return BankUser(
      id: json['person']['id'],
      personId: json['person']['person_id'],
      individualId: json['person']['individual_id'],
      personType: json['person']['person_type'],
      createdAt: DateTime.parse(json['person']['created_at']),
      updatedAt: DateTime.parse(json['person']['updated_at']),
      accountId: json['person']['account_id'],
      branch: json['person']['branch'],
      branchName: json['person']['branch_name'],
      accountNumber: json['person']['account_number'],
      accountType: json['person']['account_type'],
      bankCode: json['person']['bank_code'],
      bankName: json['person']['bank_name'],
      economyAccountId: json['person']['economy_account_id'],
      economyAccountNumber: json['person']['economy_account_number'],
      economyAccountType: json['person']['economy_account_type'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'person_id': personId,
      'individual_id': individualId,
      'person_type': personType,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
      'account_id': accountId,
      'branch': branch,
      'branch_name': branchName,
      'account_number': accountNumber,
      'account_type': accountType,
      'bank_code': bankCode,
      'bank_name': bankName,
      'economy_account_id': economyAccountId,
      'economy_account_number': economyAccountNumber,
      'economy_account_type': economyAccountType,
    };
  }
}
