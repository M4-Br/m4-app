import 'package:intl/intl.dart';

class NewsletterModel {
  final String title;
  final String description;
  final String source;
  final String url; // <-- Adicionado para o link real da notícia
  final String imageUrl; // <-- Adicionado para a foto da notícia
  final String category;
  final String date;

  NewsletterModel({
    required this.title,
    required this.description,
    required this.source,
    required this.url,
    required this.imageUrl,
    required this.category,
    required this.date,
  });

  factory NewsletterModel.fromJson(
      Map<String, dynamic> json, String categoryName) {
    String formattedDate = '';
    final rawDate = json['publishedAt'];
    if (rawDate != null) {
      final DateTime dt = DateTime.parse(rawDate);
      formattedDate = DateFormat('dd/MM/yyyy').format(dt);
    }

    final safeTitle = json['title'] == '[REMOVED]'
        ? 'Notícia indisponível'
        : (json['title'] ?? 'Sem título');

    return NewsletterModel(
      title: safeTitle,
      description: json['description'] ?? 'Sem descrição disponível.',
      source: json['source']?['name'] ?? 'Fonte Desconhecida',
      url: json['url'] ?? '',
      imageUrl: json['image'] ?? '',
      category: categoryName,
      date: formattedDate,
    );
  }
}
