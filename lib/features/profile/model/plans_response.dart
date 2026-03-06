class PlansResponse {
  final bool success;
  final List<PlanItem> itens;

  PlansResponse({
    required this.success,
    required this.itens,
  });

  factory PlansResponse.fromJson(Map<String, dynamic> json) {
    return PlansResponse(
      success: json['success'] ?? false,
      itens: json['itens'] != null
          ? (json['itens'] as List).map((i) => PlanItem.fromJson(i)).toList()
          : [],
    );
  }
}

class PlanItem {
  final String id;
  final String description;
  final double monthlyPayment;
  final String createdAt;
  final String updatedAt;
  final List<PlanData> data;

  PlanItem({
    required this.id,
    required this.description,
    required this.monthlyPayment,
    required this.createdAt,
    required this.updatedAt,
    required this.data,
  });

  factory PlanItem.fromJson(Map<String, dynamic> json) {
    return PlanItem(
      id: json['id'] ?? '',
      description: json['description'] ?? '',
      // Tratamento seguro para converter a String "500" em Double
      monthlyPayment:
          double.tryParse(json['monthly_payment'].toString()) ?? 0.0,
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      data: json['data'] != null
          ? (json['data'] as List).map((i) => PlanData.fromJson(i)).toList()
          : [],
    );
  }
}

class PlanData {
  final String type;
  final String typeDescription;
  final double fee;
  final int free;

  PlanData({
    required this.type,
    required this.typeDescription,
    required this.fee,
    required this.free,
  });

  factory PlanData.fromJson(Map<String, dynamic> json) {
    return PlanData(
      type: json['type'] ?? '',
      typeDescription: json['type_description'] ?? '',
      // Tratamento seguro caso venha 0 (int) ou 0.0 (double)
      fee: (json['fee'] as num?)?.toDouble() ?? 0.0,
      free: json['free'] as int? ?? 0,
    );
  }
}
