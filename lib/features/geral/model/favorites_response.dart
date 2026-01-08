class FavoriteContactModel {
  final String favoriteId;
  final String nickname;
  final String fullName;
  final String document;
  final List<PixKeyModel> pixKeys;
  final List<BankAccountModel> bankAccounts;

  FavoriteContactModel({
    required this.favoriteId,
    required this.nickname,
    required this.fullName,
    required this.document,
    required this.pixKeys,
    required this.bankAccounts,
  });

  factory FavoriteContactModel.fromJson(Map<String, dynamic> json) {
    return FavoriteContactModel(
      favoriteId: json['favorite_id'] ?? '',
      nickname: json['nickname'] ?? '',
      fullName: json['full_name'] ?? '',
      document: json['document'] ?? '',
      pixKeys: (json['pix_keys'] as List<dynamic>?)
              ?.map((e) => PixKeyModel.fromJson(e))
              .toList() ??
          [],
      bankAccounts: (json['bank_accounts'] as List<dynamic>?)
              ?.map((e) => BankAccountModel.fromJson(e))
              .toList() ??
          [],
    );
  }
}

class PixKeyModel {
  final String key;
  final String type;

  PixKeyModel({
    required this.key,
    required this.type,
  });

  factory PixKeyModel.fromJson(Map<String, dynamic> json) {
    return PixKeyModel(
      key: json['key'] ?? '',
      type: json['type'] ?? '',
    );
  }
}

class BankAccountModel {
  final String bankName;
  final String bankCode;
  final String ispb;
  final String agency;
  final String account;
  final String type;

  BankAccountModel({
    required this.bankName,
    required this.bankCode,
    required this.ispb,
    required this.agency,
    required this.account,
    required this.type,
  });

  factory BankAccountModel.fromJson(Map<String, dynamic> json) {
    return BankAccountModel(
      bankName: json['bank_name'] ?? '',
      bankCode: json['bank_code'] ?? '',
      ispb: json['ispb'] ?? '',
      agency: json['agency'] ?? '',
      account: json['account'] ?? '',
      type: json['type'] ?? '',
    );
  }
}
