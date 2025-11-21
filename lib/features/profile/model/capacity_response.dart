class CapacityResponse {
  const CapacityResponse({
    required this.incomeFamily,
    required this.house,
    required this.transport,
    required this.houseCost,
    required this.transportCost,
    required this.utilitiesCost,
    required this.otherCost,
    required this.updateRegister,
    required this.updateDate,
  });

  factory CapacityResponse.fromJson(Map<String, dynamic> json) {
    return CapacityResponse(
      // CORRETO: Recebe o int de centavos
      incomeFamily: json['income_family'] as int,

      // CORRETO: Recebe a String do tipo (ex: "" ou "rent_home")
      house: json['house'] as String,

      // CORRETO: Recebe a String do tipo (ex: "" ou "public")
      transport: json['transport'] as String,

      // CORRETO: Recebe o int de centavos
      houseCost: json['house_cost'] as int,

      // CORRETO: Recebe o int de centavos
      transportCost: json['transport_cost'] as int,

      // CORRETO: Recebe o int de centavos
      utilitiesCost: json['utilities_cost'] as int,

      // CORRETO: Recebe o int de centavos
      otherCost: json['other_cost'] as int,

      updateRegister: json['update_register'] as bool,

      // Adicionei isso baseado no seu JSON
      updateDate: json['update_date'] as String?,
    );
  }

  //TODO: CORRIGIR

  // CORRETO: int (centavos)
  final int incomeFamily;

  // CORRETO: String (tipo)
  final String house;

  // CORRETO: String (tipo)
  final String transport;

  // CORRETO: int (centavos)
  final int houseCost;

  // CORRETO: int (centavos)
  final int transportCost;

  // CORRETO: int (centavos)
  final int utilitiesCost;

  // CORRETO: int (centavos)
  final int otherCost;

  final bool updateRegister;
  final String? updateDate;
}
