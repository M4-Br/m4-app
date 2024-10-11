class PixClaim {
  final int totalDocs;
  final int limit;
  final int totalPages;
  final int page;
  final int pagingCounter;
  final bool hasPrevPage;
  final bool hasNextPage;
  final int prevPage;
  final int nextPage;
  final List<Item> items;

  PixClaim({
    required this.totalDocs,
    required this.limit,
    required this.totalPages,
    required this.page,
    required this.pagingCounter,
    required this.hasPrevPage,
    required this.hasNextPage,
    required this.prevPage,
    required this.nextPage,
    required this.items,
  });

  factory PixClaim.fromJson(Map<String, dynamic> json) {
    return PixClaim(
      totalDocs: json['totalDocs'],
      limit: json['limit'],
      totalPages: json['totalPages'],
      page: json['page'],
      pagingCounter: json['pagingCounter'],
      hasPrevPage: json['hasPrevPage'],
      hasNextPage: json['hasNextPage'],
      prevPage: json['prevPage'],
      nextPage: json['nextPage'],
      items: (json['items'] as List<dynamic>)
          .map((itemJson) => Item.fromJson(itemJson))
          .toList(),
    );
  }
}

class Item {
  final String playerType;
  final int idAccount;
  final String ispb;
  final Claim claim;

  Item({
    required this.playerType,
    required this.idAccount,
    required this.ispb,
    required this.claim,
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      playerType: json['playerType'],
      idAccount: json['idAccount'],
      ispb: json['ispb'],
      claim: Claim.fromJson(json['claim']),
    );
  }
}

class Claim {
  final String key;
  final String keyType;
  final String claimType;
  final String claimStatus;
  final String dateKeyClaimed;
  final String lastModified;
  final String grantorDeadline;
  final String claimDeadline;
  final String claimUUID;

  Claim({
    required this.key,
    required this.keyType,
    required this.claimType,
    required this.claimStatus,
    required this.dateKeyClaimed,
    required this.lastModified,
    required this.grantorDeadline,
    required this.claimDeadline,
    required this.claimUUID,
  });

  factory Claim.fromJson(Map<String, dynamic> json) {
    return Claim(
      key: json['key'],
      keyType: json['keyType'],
      claimType: json['claimType'],
      claimStatus: json['claimStatus'],
      dateKeyClaimed: json['dateKeyClaimed'],
      lastModified: json['lastModified'],
      grantorDeadline: json['grantorDeadline'],
      claimDeadline: json['claimDeadline'],
      claimUUID: json['claimUUID'],
    );
  }
}