import 'dart:convert';

class UserData {
  bool success;
  Payload payload;
  String token;
  String? message;

  UserData({
    required this.success,
    required this.payload,
    required this.token,
    this.message,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      success: json['success'],
      payload: Payload.fromJson(json['payload']),
      token: json['token'] ?? "",
      message: json['message'],
    );
  }
}

class Payload {
  dynamic individualId;
  dynamic companyId;
  String accountId;
  int accountNumber;
  String document;
  String email;
  String username;
  String fullName;
  String documentName;
  String birthDate;
  String avatarUrl;
  String cardColor;
  String fontColor;
  String qrcode;
  bool updateProfession;
  Address address;
  Phone phone;
  String typePerson;
  bool menuCard;
  bool menuBanner;
  bool loginServicePlan;
  bool device;
  AliasAccount aliasAccount;

  Payload({
    required this.individualId,
    required this.companyId,
    required this.accountId,
    required this.accountNumber,
    required this.document,
    required this.email,
    required this.username,
    required this.fullName,
    required this.documentName,
    required this.birthDate,
    required this.avatarUrl,
    required this.cardColor,
    required this.fontColor,
    required this.qrcode,
    required this.updateProfession,
    required this.address,
    required this.phone,
    required this.typePerson,
    required this.menuCard,
    required this.menuBanner,
    required this.loginServicePlan,
    required this.device,
    required this.aliasAccount,
  });

  factory Payload.fromJson(Map<String, dynamic> json) {
    return Payload(
      individualId: json['individual_id'],
      companyId: json['company_id'],
      accountId: json['account_id'] ?? "",
      accountNumber: json['account_number'] ?? 0,
      document: json['document'] ?? "",
      email: json['email'] ?? "",
      username: json['username'] ?? "",
      fullName: json['full_name'] ?? "",
      documentName: json['document_name'] ?? "",
      birthDate: json['birth_date'] ?? "",
      avatarUrl: json['avatar_url'] ?? "",
      cardColor: json['card_color'] ?? "002A4D",
      fontColor: json['card_font_color'] ?? "FFFFFF",
      qrcode: json['qrcode'] ?? "",
      updateProfession: json['update_profession'] ?? false,
      address: Address.fromJson(json['address'] ?? {}),
      phone: Phone.fromJson(json['phone'] ?? {}),
      typePerson: json['type_person'] ?? "",
      menuCard: json['menu_card'] ?? false,
      menuBanner: json['menu_banner'] ?? false,
      loginServicePlan: json['login_service_plan'] ?? false,
      device: json['device'] ?? false,
      aliasAccount: AliasAccount.fromJson(json['alias_account'] ?? {}),
    );
  }
}

class Address {
  String postalCode;
  int addressTypeId;
  String street;
  String number;
  String neighborhood;
  String state;
  String city;
  String country;

  Address({
    required this.postalCode,
    required this.addressTypeId,
    required this.street,
    required this.number,
    required this.neighborhood,
    required this.state,
    required this.city,
    required this.country,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      postalCode: json['postal_code'] ?? "",
      addressTypeId: json['address_type_id'] ?? 0,
      street: json['street'] ?? "",
      number: json['number'] ?? "",
      neighborhood: json['neighborhood'] ?? "",
      state: json['state'] ?? "",
      city: json['city'] ?? "",
      country: json['country'] ?? "",
    );
  }
}

class Phone {
  int phonePrefix;
  String phoneNumber;

  Phone({
    required this.phonePrefix,
    required this.phoneNumber,
  });

  factory Phone.fromJson(Map<String, dynamic> json) {
    return Phone(
      phonePrefix: json['phone_prefix'] ?? 0,
      phoneNumber: json['phone_number'] ?? "",
    );
  }
}

class AliasAccount {
  String id;
  String accountDigit;
  String accountNumber;
  String accountStatus;
  String accountType;
  String bankNumber;
  String bankNumberPagme;
  String branchDigit;
  String branchNumber;
  String economyAccountId;
  String economyAccountNumber;
  String economyAccountType;

  AliasAccount({
    required this.id,
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
      id: json['account_id'] ?? '',
      accountDigit: json['account_digit'] ?? '',
      accountNumber: json['account_number'] ?? '',
      accountStatus: json['account_status'] ?? '',
      accountType: json['account_type'] ?? '',
      bankNumber: json['bank_number'] ?? '',
      bankNumberPagme: json['bank_number_pagme'] ?? '',
      branchDigit: json['branch_digit'] ?? '',
      branchNumber: json['branch_number'] ?? '',
      economyAccountId: json['economy_account_id'] ?? '',
      economyAccountNumber: json['economy_account_number'] ?? '',
      economyAccountType: json['economy_account_type'] ?? '',
    );
  }
}
