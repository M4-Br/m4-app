
class UserPlanModel {
  final bool success;
  final List<Item> items;

  UserPlanModel({
    required this.success,
    required this.items,
  });

  factory UserPlanModel.fromJson(Map<String, dynamic> json) {
    return UserPlanModel(
      success: json['success'],
      items: (json['itens'] as List)
          .map((item) => Item.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'itens': items.map((item) => item.toJson()).toList(),
    };
  }
}

class Item {
  final String id;
  final String description;
  final String monthlyPayment;
  final String createdAt;
  final String updatedAt;
  final List<Data> data;

  Item({
    required this.id,
    required this.description,
    required this.monthlyPayment,
    required this.createdAt,
    required this.updatedAt,
    required this.data,
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      id: json['id'],
      description: json['description'],
      monthlyPayment: json['monthly_payment'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      data: (json['data'] as List)
          .map((dataItem) => Data.fromJson(dataItem))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'description': description,
      'monthly_payment': monthlyPayment,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'data': data.map((dataItem) => dataItem.toJson()).toList(),
    };
  }
}

class Data {
  final String type;
  final String typeDescription;
  final int fee;
  final int free;

  Data({
    required this.type,
    required this.typeDescription,
    required this.fee,
    required this.free,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      type: json['type'],
      typeDescription: json['type_description'],
      fee: json['fee'],
      free: json['free'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'type_description': typeDescription,
      'fee': fee,
      'free': free,
    };
  }
}
