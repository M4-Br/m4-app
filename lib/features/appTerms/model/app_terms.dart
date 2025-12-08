class AppTerms {
  const AppTerms({
    required this.text,
  });

  final String text;

  factory AppTerms.fromJson(Map<String, dynamic> json) {
    return AppTerms(text: json['text'] as String);
  }
}
