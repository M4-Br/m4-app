class OfferResponse {
  bool? success;
  List<OfferModel>? data;

  OfferResponse({this.success, this.data});

  OfferResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <OfferModel>[];
      json['data'].forEach((v) {
        data!.add(OfferModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OfferModel {
  int? id;
  int? individualId;
  String? title;
  DateTime? startDate;
  DateTime? endDate;
  List<OfferItemModel>? offerItems;

  OfferModel({
    this.id,
    this.individualId,
    this.title,
    this.startDate,
    this.endDate,
    this.offerItems,
  });

  OfferModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    individualId = json['individual_id'];
    title = json['title'];
    startDate = json['start_date'] != null
        ? DateTime.tryParse(json['start_date'])
        : null;
    endDate =
        json['end_date'] != null ? DateTime.tryParse(json['end_date']) : null;
    if (json['offer_items'] != null) {
      offerItems = <OfferItemModel>[];
      json['offer_items'].forEach((v) {
        offerItems!.add(OfferItemModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['individual_id'] = individualId;
    data['title'] = title;
    data['start_date'] = startDate?.toIso8601String();
    data['end_date'] = endDate?.toIso8601String();
    if (offerItems != null) {
      data['offer_items'] = offerItems!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OfferItemModel {
  int? id;
  int? offerId;
  int? originalPrice;
  int? offerPrice;
  int? discountValue;
  String? offerUrl;
  String? status;

  OfferItemModel({
    this.id,
    this.offerId,
    this.originalPrice,
    this.offerPrice,
    this.discountValue,
    this.offerUrl,
    this.status,
  });

  OfferItemModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] as int;
    offerId = json['offer_id'] as int?;
    originalPrice = json['original_price'] as int?;
    offerPrice = json['offer_price'] as int?;
    discountValue = json['discount_value'] as int?;
    offerUrl = json['offer_url'] as String?;
    status = json['status'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['offer_id'] = offerId;
    data['original_price'] = originalPrice;
    data['offer_price'] = offerPrice;
    data['discount_value'] = discountValue;
    data['offer_url'] = offerUrl;
    data['status'] = status;
    return data;
  }
}
