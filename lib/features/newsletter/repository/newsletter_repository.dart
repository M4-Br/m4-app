import 'dart:convert';
import 'package:app_flutter_miban4/features/newsletter/model/newsletter_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:app_flutter_miban4/core/config/log/logger.dart';

class NewsletterRepository {
  final String _apiKey =
      const String.fromEnvironment('GNEWS_KEY', defaultValue: '') != ''
          ? const String.fromEnvironment('GNEWS_KEY')
          : dotenv.env['GNEWS_KEY'] ?? '';

  Future<List<NewsletterModel>> fetchNews(
      String query, String categoryName) async {
    final String apiUrl =
        'https://gnews.io/api/v4/search?q=$query&lang=pt&country=br&max=20&apikey=$_apiKey';
    final url = Uri.parse(apiUrl);

    try {
      AppLogger.I().info('Buscando notícias GNews para a query: $query');

      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List articles = data['articles'] ?? [];

        return articles
            .map((article) => NewsletterModel.fromJson(article, categoryName))
            .where((news) =>
                news.title != 'Notícia indisponível' && news.title.isNotEmpty)
            .toList();
      } else {
        AppLogger.I().error('GNews falhou com status: ${response.statusCode}',
            Exception('Falha'), StackTrace.current);
        throw Exception(
            'Falha ao carregar notícias (Status: ${response.statusCode})');
      }
    } catch (e) {
      AppLogger.I()
          .error('Erro inesperado no fetchNews', e, StackTrace.current);
      rethrow;
    }
  }
}
