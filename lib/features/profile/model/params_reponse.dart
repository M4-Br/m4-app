class ParamsReponse {
  const ParamsReponse({
    required this.home,
    required this.transport,
  });

  factory ParamsReponse.fromJson(Map<String, dynamic> json) {
    return ParamsReponse(
      home: (json['customer_home'] as List<dynamic>)
          .map((e) => CustomerHome.fromJson(e as Map<String, dynamic>))
          .toList(),
      transport: (json['customer_transport'] as List<dynamic>)
          .map((e) => CustomerTransport.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  final List<CustomerHome> home;
  final List<CustomerTransport> transport;
}

class CustomerHome {
  const CustomerHome({
    required this.id,
    required this.label,
    required this.value,
    required this.description,
  });

  factory CustomerHome.fromJson(Map<String, dynamic> json) {
    return CustomerHome(
      id: json['id'] as int,
      label: json['label'] as String,
      value: json['value'] as String,
      description: json['description'] as String,
    );
  }

  final int id;
  final String label;
  final String value;
  final String description;
}

class CustomerTransport {
  const CustomerTransport({
    required this.id,
    required this.label,
    required this.value,
    required this.description,
  });

  factory CustomerTransport.fromJson(Map<String, dynamic> json) {
    return CustomerTransport(
      id: json['id'] as int,
      label: json['label'] as String,
      value: json['value'] as String,
      description: json['description'] as String,
    );
  }

  final int id;
  final String label;
  final String value;
  final String description;
}
