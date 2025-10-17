import 'package:app_flutter_miban4/core/helpers/extensions/numbers.dart';

class UserPlansResponse {
  final bool success;
  final ServicePlan servicePlan;

  UserPlansResponse({
    required this.success,
    required this.servicePlan,
  });

  factory UserPlansResponse.fromJson(Map<String, dynamic> json) {
    return UserPlansResponse(
      success: json['success'],
      servicePlan: ServicePlan.fromJson(json['service_plan']),
    );
  }
}

class ServicePlan {
  final String id;
  final String name;
  final String description;
  final double monthlyPayment;
  final String contractDate;
  final String renewDate;
  final int remainingFree;
  final List<ServiceData> data;
  final List<Product> products;
  final bool renew;
  final bool isDefault;

  ServicePlan({
    required this.id,
    required this.name,
    required this.description,
    required this.monthlyPayment,
    required this.contractDate,
    required this.renewDate,
    required this.remainingFree,
    required this.data,
    required this.products,
    required this.renew,
    required this.isDefault,
  });

  factory ServicePlan.fromJson(Map<String, dynamic> json) {
    return ServicePlan(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      monthlyPayment: (json['monthly_payment'] as String).toCurrencyDouble(),
      contractDate: json['contract_date'],
      renewDate: json['renew_date'],
      remainingFree: json['remaining_free'],
      data: (json['data'] as List)
          .map((item) => ServiceData.fromJson(item))
          .toList(),
      products: (json['products'] as List)
          .map((item) => Product.fromJson(item))
          .toList(),
      renew: json['renew'],
      isDefault: json['default'],
    );
  }
}

class ServiceData {
  final String type;
  final String typeDescription;
  final int remainingFree;
  final double fee;
  final int free;

  ServiceData({
    required this.type,
    required this.typeDescription,
    required this.remainingFree,
    required this.fee,
    required this.free,
  });

  factory ServiceData.fromJson(Map<String, dynamic> json) {
    return ServiceData(
      type: json['type'],
      typeDescription: json['type_description'],
      remainingFree: json['remaining_free'],
      fee: (json['fee'] as String).toCurrencyDouble(),
      free: json['free'],
    );
  }
}

class Product {
  final String type;
  final String description;
  final int fee;
  final int free;

  Product({
    required this.type,
    required this.description,
    required this.fee,
    required this.free,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      type: json['type'],
      description: json['description'],
      fee: json['fee'],
      free: json['free'],
    );
  }
}
