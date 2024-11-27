class PlansModel {
  final bool success;
  final ServicePlan servicePlan;

  PlansModel({
    required this.success,
    required this.servicePlan,
  });

  factory PlansModel.fromJson(Map<String, dynamic> json) {
    return PlansModel(
      success: json['success'],
      servicePlan: ServicePlan.fromJson(json['service_plan']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'service_plan': servicePlan.toJson(),
    };
  }
}

class ServicePlan {
  final String id;
  final String name;
  final String description;
  final String monthlyPayment;
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
      monthlyPayment: json['monthly_payment'],
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

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'monthly_payment': monthlyPayment,
      'contract_date': contractDate,
      'renew_date': renewDate,
      'remaining_free': remainingFree,
      'data': data.map((item) => item.toJson()).toList(),
      'products': products.map((item) => item.toJson()).toList(),
      'renew': renew,
      'default': isDefault,
    };
  }
}

class ServiceData {
  final String type;
  final String typeDescription;
  final int remainingFree;
  final int fee;
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
      fee: json['fee'],
      free: json['free'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'type_description': typeDescription,
      'remaining_free': remainingFree,
      'fee': fee,
      'free': free,
    };
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

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'description': description,
      'fee': fee,
      'free': free,
    };
  }
}
