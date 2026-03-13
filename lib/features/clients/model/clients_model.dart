import 'dart:convert';

class ClientModel {
  final String id;
  final String userId; // Para garantir que o cliente é do usuário logado
  final String name;
  final String phone;
  final String cpf;
  final String email;
  final String address;
  final String notes;

  ClientModel({
    required this.id,
    required this.userId,
    required this.name,
    required this.phone,
    required this.cpf,
    required this.email,
    required this.address,
    required this.notes,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'name': name,
      'phone': phone,
      'cpf': cpf,
      'email': email,
      'address': address,
      'notes': notes,
    };
  }

  factory ClientModel.fromMap(Map<String, dynamic> map) {
    return ClientModel(
      id: map['id'] ?? '',
      userId: map['userId'] ?? '',
      name: map['name'] ?? '',
      phone: map['phone'] ?? '',
      cpf: map['cpf'] ?? '',
      email: map['email'] ?? '',
      address: map['address'] ?? '',
      notes: map['notes'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());
  factory ClientModel.fromJson(String source) =>
      ClientModel.fromMap(json.decode(source));
}
