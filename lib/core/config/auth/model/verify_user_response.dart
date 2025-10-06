class VerifyUserResponse {
  const VerifyUserResponse({
    required this.id,
    required this.documentType,
    required this.firstAccess,
    required this.defaulter,
    required this.document,
    required this.steps,
  });

  factory VerifyUserResponse.fromJson(Map<String, dynamic> json) {
    return VerifyUserResponse(
      id: json['id'] as int,
      documentType: json['type'] as String,
      document: json['document'] as String,
      firstAccess: json['first_access'] as bool,
      defaulter: json['defaulter_user'] as bool,
      steps: (json['steps'] as List<dynamic>)
          .map((e) => Steps.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  final int id;
  final String document;
  final String documentType;
  final bool firstAccess;
  final bool defaulter;
  final List<Steps> steps;
}

class Steps {
  const Steps({
    required this.id,
    required this.done,
    required this.name,
  });

  factory Steps.fromJson(Map<String, dynamic> json) {
    return Steps(
      id: json['step_id'] as int,
      done: json['done'] as bool,
      name: json['name'] as String,
    );
  }

  final int id;
  final bool done;
  final String name;
}
