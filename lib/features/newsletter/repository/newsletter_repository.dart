import 'dart:convert';
import 'package:app_flutter_miban4/features/newsletter/model/newsletter_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:app_flutter_miban4/core/config/log/logger.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

class NewsletterRepository {
  final String _gnewsKey =
      const String.fromEnvironment('GNEWS_KEY', defaultValue: '') != ''
          ? const String.fromEnvironment('GNEWS_KEY')
          : dotenv.env['GNEWS_KEY'] ?? '';

  final String _newsApiKey = dotenv.env['NEWS_API_KEY'] ?? '';

  Future<List<NewsletterModel>> fetchNews(
      String query, String categoryName) async {
    try {
      // Tenta GNews como fonte primária
      final gnewsResults = await _fetchFromGNews(query, categoryName);
      if (gnewsResults.isNotEmpty) return gnewsResults;
    } catch (e, s) {
      AppLogger.I()
          .error('GNews falhou ou retornou vazio, tentando fallback...', e, s);
    }

    try {
      if (_newsApiKey.isNotEmpty) {
        return await _fetchFromNewsApi(query, categoryName);
      }
    } catch (e, s) {
      AppLogger.I().error('Fallback NewsAPI falhou', e, s);
    }

    return [];
  }

  Future<List<NewsletterModel>> _fetchFromGNews(
      String query, String categoryName) async {
    final String apiUrl =
        'https://gnews.io/api/v4/search?q=$query&lang=pt&country=br&max=15&apikey=$_gnewsKey';

    AppLogger.I().info('Buscando GNews: $query');

    String finalUrl = apiUrl;
    if (kIsWeb) {
      // Proxy mais transparente para evitar CORS na Web
      finalUrl = 'https://corsproxy.io/?${Uri.encodeComponent(apiUrl)}';
    }

    final response =
        await http.get(Uri.parse(finalUrl)).timeout(const Duration(seconds: 10));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List articles = data['articles'] ?? [];
      return articles
          .map((article) => NewsletterModel.fromJson(article, categoryName))
          .where((news) =>
              news.title != 'Notícia indisponível' && news.title.isNotEmpty)
          .toList();
    }
    throw Exception('GNews Status: ${response.statusCode}');
  }

  Future<List<NewsletterModel>> _fetchFromNewsApi(
      String query, String categoryName) async {
    // NewsAPI.org - Fallback
    final String apiUrl =
        'https://newsapi.org/v2/everything?q=$query&language=pt&sortBy=publishedAt&pageSize=15&apiKey=$_newsApiKey';

    AppLogger.I().info('Buscando NewsAPI: $query');

    String finalUrl = apiUrl;
    if (kIsWeb) {
      // Proxy mais transparente para evitar CORS na Web
      finalUrl = 'https://corsproxy.io/?${Uri.encodeComponent(apiUrl)}';
    }

    final response =
        await http.get(Uri.parse(finalUrl)).timeout(const Duration(seconds: 10));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List articles = data['articles'] ?? [];

      return articles
          .map((article) {
            String formattedDate = '';
            if (article['publishedAt'] != null) {
              try {
                final DateTime dt = DateTime.parse(article['publishedAt']);
                formattedDate = DateFormat('dd/MM/yyyy').format(dt);
              } catch (_) {}
            }

            return NewsletterModel(
              title: article['title'] ?? '',
              description: article['description'] ?? '',
              source: article['source']?['name'] ?? 'NewsAPI',
              url: article['url'] ?? '',
              imageUrl: article['urlToImage'] ?? '',
              category: categoryName,
              date: formattedDate,
            );
          })
          .where((news) => news.title.isNotEmpty)
          .toList();
    }
    throw Exception('NewsAPI Status: ${response.statusCode}');
  }
}
