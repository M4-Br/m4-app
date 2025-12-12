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
