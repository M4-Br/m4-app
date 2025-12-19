class ProfileStep {
  final int stepId;
  final String name;
  final bool done;

  ProfileStep({
    required this.stepId,
    required this.name,
    required this.done,
  });

  factory ProfileStep.fromJson(Map<String, dynamic> json) {
    return ProfileStep(
      stepId: json['step_id'] as int,
      name: json['name'] as String,
      done: json['done'] as bool,
    );
  }
}

class CompleteProfileResponse {
  final int id;
  final List<ProfileStep> steps;

  CompleteProfileResponse({
    required this.id,
    required this.steps,
  });

  factory CompleteProfileResponse.fromJson(Map<String, dynamic> json) {
    var stepsList = json['steps'] as List;
    List<ProfileStep> stepsItems =
        stepsList.map((i) => ProfileStep.fromJson(i)).toList();

    return CompleteProfileResponse(
      id: json['id'],
      steps: stepsItems,
    );
  }
}
