import 'dart:convert';
import 'package:app_flutter_miban4/data/api/url/url_api.dart';
import 'package:app_flutter_miban4/data/model/home/home.dart';
import 'package:app_flutter_miban4/data/util/helpers/shared_preferences.dart';
import 'package:http/http.dart' as http;

Future<List<IconModel>> homeIcons() async {

  String codeLang = await SharedPreferencesFunctions.getString(key: 'codeLang');

  final headers = {
    'subscription-key': 'a0991d6076cf4b74976383eedc2a30dc',
    'app-key': '2z4R55CZdPiuKVJeOnCmWp8krhexXzINcKwOc22y1US49TaBEHqDJhN3wMqp',
    'Accept-Language': codeLang
  };

  final response = await http.get(
      Uri.parse("${ApiUrls.baseUrl}/app/home_info"),
      headers: headers);

  try {
    if (response.statusCode == 200 || response.statusCode == 201) {
      final jsonMap = json.decode(response.body);

      List<IconModel> icons = (jsonMap['home_items'] as List)
          .map((item) => IconModel.fromJson(item))
          .toList();

      return icons;
    } else {
      final jsonErrorMap = json.decode(response.body);
      final errorMessage = jsonErrorMap['message'] ?? "Erro desconhecido";
      throw Exception(errorMessage);
    }
  } catch (e) {
    throw Exception(e.toString());
  }
}
