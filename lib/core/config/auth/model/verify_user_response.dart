class VerifyUserResponse {
  const VerifyUserResponse({
    required this.id,
    required this.document,
    required this.documentType,
    required this.email,
    required this.firstAccess,
    required this.defaulter,
    required this.steps,
    required this.userData,
  });

  factory VerifyUserResponse.fromJson(Map<String, dynamic> json) {
    return VerifyUserResponse(
      id: json['id'] as int,
      document: json['document'] as String,
      documentType: json['type'] as String,
      email: json['email'] as String?,
      firstAccess: json['first_access'] as bool,
      defaulter: json['defaulter_user'] as bool,
      steps: (json['steps'] as List<dynamic>)
          .map((e) => Steps.fromJson(e as Map<String, dynamic>))
          .toList(),
      userData: UserData.fromJson(json['user'] as Map<String, dynamic>),
    );
  }

  final int id;
  final String document;
  final String documentType;
  final String? email;
  final bool firstAccess;
  final bool defaulter;
  final List<Steps> steps;
  final UserData userData;
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

class UserData {
  const UserData({
    required this.id,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(id: json['id']);
  }

  final int id;
}
