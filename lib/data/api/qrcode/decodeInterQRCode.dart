import 'dart:convert';
import 'package:app_flutter_miban4/data/api/url/url_api.dart';
import 'package:app_flutter_miban4/data/model/qrCode/internQRCode.dart';
import 'package:app_flutter_miban4/data/util/helpers/shared_preferences.dart';
import 'package:http/http.dart' as http;

Future<InternQRCode> internQRCode() async {

  String token = await SharedPreferencesFunctions.getString(key: 'token');
  String username = await SharedPreferencesFunctions.getString(key: 'username');

  final url = Uri.parse('${ApiUrls.baseUrl}/account/username/$username');

  var headers = {
    'Authorization': 'Bearer $token',
    'subscription-key': 'a0991d6076cf4b74976383eedc2a30dc',
    'app-key': '2z4R55CZdPiuKVJeOnCmWp8krhexXzINcKwOc22y1US49TaBEHqDJhN3wMqp',
    'Content-Type': 'application/json; charset=UTF-8',
  };

  var response = await http.get(url, headers: headers);

  if (response.statusCode == 200) {
    var jsonData = json.decode(response.body);
    var internQRCode = InternQRCode.fromJson(jsonData);

    return internQRCode;
  } else {
    print(response.statusCode.toString());
    throw Exception('Erro: ${response.statusCode}');
  }

}
