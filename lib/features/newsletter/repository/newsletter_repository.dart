import 'dart:convert';

import 'package:app_flutter_miban4/features/newsletter/model/newsletter_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class NewsletterRepository {
  final String _apiKey = dotenv.env['NEWS_KEY'] ?? '';

  Future<List<NewsletterModel>> fetchNews(
      String query, String categoryName) async {
    String apiUrl =
        'https://newsapi.org/v2/everything?q=$query&language=pt&sortBy=publishedAt&apiKey=$_apiKey';

    if (kIsWeb) {
      apiUrl = 'https://corsproxy.io/?${Uri.encodeComponent(apiUrl)}';
    }
    final url = Uri.parse(apiUrl);

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List articles = data['articles'] ?? [];

      return articles
          .map((article) => NewsletterModel.fromJson(article, categoryName))
          .where((news) => news.title != 'Notícia indisponível')
          .toList();
    } else {
      throw Exception(
          'Falha ao carregar notícias (Status: ${response.statusCode})');
    }
  }
}
