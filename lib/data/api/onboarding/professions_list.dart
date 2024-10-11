import 'dart:convert';
import 'package:app_flutter_miban4/data/api/url/url_api.dart';
import 'package:app_flutter_miban4/data/model/onboarding/get_profession.dart';
import 'package:http/http.dart' as http;

Future<List<Professions>> getProfessions() async {
  final headers = {
    'subscription-key': 'a0991d6076cf4b74976383eedc2a30dc',
    'app-key': '2z4R55CZdPiuKVJeOnCmWp8krhexXzINcKwOc22y1US49TaBEHqDJhN3wMqp',
  };

  try {
    final url = Uri.parse("${ApiUrls.baseUrl}/v2/register/individual/step4/type");
    final response = await http.get(url, headers: headers);

    if(response.statusCode == 200 || response.statusCode == 201) {
      final List<dynamic> jsonList = json.decode(response.body);
      final List<Professions> professionsList = jsonList.map((jsonItem) => Professions.fromJson(jsonItem)).toList();

      return professionsList;
    } else {
      throw Exception('${response.statusCode}, ${response.body}, ${response.reasonPhrase}');
    }
  } catch(e) {
    throw Exception(e.toString());
  }
}