class CompleteProfileAddressRequest {
  const CompleteProfileAddressRequest({
    required this.individualId,
    required this.postalCode,
    required this.type,
    required this.street,
    required this.number,
    required this.neighborhood,
    required this.complement,
    required this.state,
    required this.city,
  });

  final int individualId;
  final String postalCode;
  final String type;
  final String street;
  final String number;
  final String neighborhood;
  final String complement;
  final String state;
  final String city;

  Map<String, dynamic> toJson() {
    return {
      'individual_id': individualId,
      'postal_code': postalCode,
      'type': type,
      'street': street,
      'number': number,
      'neighborhood': neighborhood,
      'complement': complement,
      'state': state,
      'city': city,
    };
  }
}
