import 'dart:convert';
import 'package:app_flutter_miban4/data/api/url/url_api.dart';
import 'package:app_flutter_miban4/data/model/pix/pixChageLimits.dart';
import 'package:app_flutter_miban4/data/util/helpers/shared_preferences.dart';
import 'package:http/http.dart' as http;

Future<AccountLimit> pixChangeLimit(String limitType, String amount) async {

  String token = await SharedPreferencesFunctions.getString(key: 'token');

  try {
    final headers = {
      'Authorization': 'Bearer $token',
      'subscription-key': 'a0991d6076cf4b74976383eedc2a30dc',
      'app-key': '2z4R55CZdPiuKVJeOnCmWp8krhexXzINcKwOc22y1US49TaBEHqDJhN3wMqp',
    };

    final body = {
        "limit_type": limitType,
        "account_limit": amount
    };
    
    final url = Uri.parse('${ApiUrls.baseUrl}/pix/limits');
    final response = await http.put(url, headers: headers, body: body);

    if (response.statusCode == 200 || response.statusCode == 201) {
      final jsonData = json.decode(response.body);
      final newLimit = AccountLimit.fromJson(jsonData);

      return newLimit;
    } else {
      throw Exception(
        'Erro na chamada: ${response.statusCode.toString()} ${response.reasonPhrase.toString()}'
      );
    }

  } catch (e) {
    throw Exception(e.toString());
  }
}