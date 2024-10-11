import 'dart:convert';
import 'package:app_flutter_miban4/data/api/url/url_api.dart';
import 'package:app_flutter_miban4/data/model/pix/pixDelete.dart';
import 'package:app_flutter_miban4/data/util/helpers/shared_preferences.dart';
import 'package:http/http.dart' as http;

Future<PixDeleteModel> deletePixKey(String key) async {

  String token = await SharedPreferencesFunctions.getString(key: 'token');

  try {
    final headers = {
      'Authorization': 'Bearer $token',
      'subscription-key': 'a0991d6076cf4b74976383eedc2a30dc',
      'app-key': '2z4R55CZdPiuKVJeOnCmWp8krhexXzINcKwOc22y1US49TaBEHqDJhN3wMqp',
      'Content-Type': 'application/json; charset=UTF-8',
    };

    final url = Uri.parse('${ApiUrls.baseUrl}/pix/dict');
    final response = await http.delete(
      url,
      headers: headers,
      body: jsonEncode(<String, dynamic>{
        'key': key,
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 202) {
      final jsonData = json.decode(response.body);
      final pixKeys = PixDeleteModel.fromJson(jsonData);

      return pixKeys;
    } else {
      throw Exception(
          'Erro na chamada da API: ${response.statusCode.toString()}');
    }
  } catch (e) {
    throw Exception(e.toString());
  }
}