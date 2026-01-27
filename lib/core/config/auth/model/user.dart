import 'package:flutter/material.dart';

class Payload {
  const Payload({
    required this.id,
    required this.companyId,
    required this.username,
    required this.email,
    required this.document,
    required this.cardColor,
    required this.cardFontColor,
    required this.qrCode,
    required this.aliasAccount,
    required this.avatarUrl,
    required this.fullName,
    required this.phone,
    this.userId,
  });

  factory Payload.fromJson(Map<String, dynamic> json) {
    final cardColorString = json['card_color'] as String? ?? '002A4D';
    final cardFontColorString = json['card_font_color'] as String? ?? 'FFFFFF';

    return Payload(
      id: json['individual_id'] as int,
      userId: json['user_id'] as int?,
      companyId: json['company_id'] as int?,
      username: json['username'] as String,
      email: json['email'] as String,
      document: json['document'] as String,
      cardColor: _colorFromHex(cardColorString),
      cardFontColor: _colorFromHex(cardFontColorString),
      qrCode: json['qrcode'] as String,
      aliasAccount: json['alias_account'] != null
          ? AliasAccount.fromJson(json['alias_account'] as Map<String, dynamic>)
          : null,
      avatarUrl: json['avatar_url'] as String?,
      fullName: json['full_name'] as String,
      phone: Phone.fromJson(json['phone'] as Map<String, dynamic>),
    );
  }

  final int id;
  final int? userId;
  final int? companyId;
  final String username;
  final String email;
  final String document;
  final Color cardColor;
  final Color cardFontColor;
  final String qrCode;
  final AliasAccount? aliasAccount;
  final String? avatarUrl;
  final String fullName;
  final Phone phone;

  Payload copyWith({
    int? id,
    int? userId,
    int? companyId,
    String? username,
    String? email,
    String? document,
    Color? cardColor,
    Color? cardFontColor,
    String? qrCode,
    AliasAccount? aliasAccount,
    String? avatarUrl,
    String? fullName,
    Phone? phone,
  }) {
    return Payload(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      companyId: companyId ?? this.companyId,
      username: username ?? this.username,
      email: email ?? this.email,
      document: document ?? this.document,
      cardColor: cardColor ?? this.cardColor,
      cardFontColor: cardFontColor ?? this.cardFontColor,
      qrCode: qrCode ?? this.qrCode,
      aliasAccount: aliasAccount ?? this.aliasAccount,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      fullName: fullName ?? this.fullName,
      phone: phone ?? this.phone,
    );
  }
}

Color _colorFromHex(String hexColor) {
  final hexCode = hexColor.replaceAll('#', '');
  return Color(int.parse('FF$hexCode', radix: 16));
}

class Phone {
  const Phone({required this.phonePrefix, required this.phoneNumber});

  factory Phone.fromJson(Map<String, dynamic> json) {
    return Phone(
      phonePrefix: json['phone_prefix'] as int,
      phoneNumber: json['phone_number'] as String,
    );
  }

  final int phonePrefix;
  final String phoneNumber;
}

class AliasAccount {
  const AliasAccount({
    required this.accountId,
    required this.accountDigit,
    required this.accountNumber,
    required this.accountStatus,
    required this.accountType,
    required this.bankNumber,
    required this.bankNumberPagme,
    required this.branchDigit,
    required this.branchNumber,
    required this.economyAccountId,
    required this.economyAccountNumber,
    required this.economyAccountType,
  });

  factory AliasAccount.fromJson(Map<String, dynamic> json) {
    return AliasAccount(
      accountId: json['account_id'] as String,
      accountDigit: json['account_digit'] as String,
      accountNumber: json['account_number'] as String,
      accountStatus: json['account_status'] as String,
      accountType: json['account_type'] as String,
      bankNumber: json['bank_number'] as String,
      bankNumberPagme: json['bank_number_pagme'] as String,
      branchDigit: json['branch_digit'] as String,
      branchNumber: json['branch_number'] as String,
      economyAccountId: json['economy_account_id'] as String,
      economyAccountNumber: json['economy_account_number'] as String,
      economyAccountType: json['economy_account_type'] as String,
    );
  }

  final String accountId;
  final String accountDigit;
  final String accountNumber;
  final String accountStatus;
  final String accountType;
  final String bankNumber;
  final String bankNumberPagme;
  final String branchDigit;
  final String branchNumber;
  final String economyAccountId;
  final String economyAccountNumber;
  final String economyAccountType;
}

class User {
  const User({
    required this.payload,
    required this.token,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      payload: Payload.fromJson(json['payload']),
      token: json['token'] as String,
    );
  }

  final Payload payload;
  final String token;

  User copyWith({
    Payload? payload,
    String? token,
  }) {
    return User(
      payload: payload ?? this.payload,
      token: token ?? this.token,
    );
  }
}
