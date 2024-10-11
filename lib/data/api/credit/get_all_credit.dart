import 'package:app_flutter_miban4/data/api/url/url_api.dart';
import 'package:app_flutter_miban4/data/util/helpers/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<List<Map<String, dynamic>>> getCreditAllInstallments(String id, String type) async {
  String token = await SharedPreferencesFunctions.getString(key: 'token');

  final headers = {
    'Authorization': 'Bearer $token',
    'subscription-key': 'a0991d6076cf4b74976383eedc2a30dc',
    'app-key': '2z4R55CZdPiuKVJeOnCmWp8krhexXzINcKwOc22y1US49TaBEHqDJhN3wMqp',
  };

  final response = await http.get(
    Uri.parse("${ApiUrls.baseUrl}/transactions?type=$type&group_account_id=$id&per_page=500"),
    headers: headers,
  );

  try {
    if (response.statusCode == 200) {
      final body = json.decode(response.body);
      if (body is Map<String, dynamic> && body.containsKey('data')) {
        final List<dynamic> data = body['data'];
        return data.cast<Map<String, dynamic>>();
      } else {
        throw Exception('Invalid response format');
      }
    } else {
      throw Exception('Failed to load data');
    }
  } catch (e) {
    throw Exception('Error fetching transactions: $e');
  }
}
