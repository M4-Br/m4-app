class CompleteProfilePersonalDataRequest {
  const CompleteProfilePersonalDataRequest({
    required this.id,
    required this.username,
    required this.documentState,
    required this.documentNumber,
    required this.motherName,
    required this.gender,
    required this.birthDate,
    required this.maritalStatus,
    required this.nationality,
    required this.issuanceDate,
    this.pep = false,
    this.pepSince,
  });

  final String id;
  final String username;
  final String documentState;
  final String documentNumber;
  final String motherName;
  final String gender;
  final String birthDate;
  final String maritalStatus;
  final String nationality;
  final String issuanceDate;
  final bool pep;
  final String? pepSince;

  Map<String, dynamic> toJson() => {
        'individual_id': id,
        'document_name': username,
        'document_state': documentState,
        'document_number': documentNumber,
        'mother_name': motherName,
        'gender': gender,
        'birth_date': birthDate,
        'marital_status': maritalStatus,
        'nationality': nationality,
        'nationality_state': documentState,
        'issuance_date': issuanceDate,
        'pep': pep,
        'pep_since': pepSince
      };
}
