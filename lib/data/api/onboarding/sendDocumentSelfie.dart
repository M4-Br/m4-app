import 'dart:convert';
import 'dart:io';
import 'package:app_flutter_miban4/data/api/url/url_api.dart';
import 'package:app_flutter_miban4/data/util/helpers/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:image/image.dart' as imageLib;
import 'package:path_provider/path_provider.dart';

Future<bool> sendDocumentSelfie(File image) async {
  String id = await SharedPreferencesFunctions.getString(key: 'id');

  String apiUrl = '${ApiUrls.baseUrl}/v2/register/individual/step7/$id';

  Map<String, String> headers = {
    'subscription-key': 'a0991d6076cf4b74976383eedc2a30dc',
    'app-key': '2z4R55CZdPiuKVJeOnCmWp8krhexXzINcKwOc22y1US49TaBEHqDJhN3wMqp',
  };

  final resizedImage = await resizeImage(image);

  try {
    var request = http.MultipartRequest('POST', Uri.parse(apiUrl));
    request.headers.addAll(headers);

    var multipartFile = http.MultipartFile.fromPath(
        'file_path', resizedImage.path,
        contentType: MediaType('image', 'jpg'));

    request.fields['_method'] = 'POST';
    request.files.add(await multipartFile);

    var response = await request.send();

    if (response.statusCode == 200 ||
        response.statusCode == 201 ||
        response.statusCode == 202) {
      var responseBody = await response.stream.bytesToString();
      print('Sucesso! A resposta do servidor é: $responseBody');
      return true;
    } else {
      var responseBody = await response.stream.bytesToString();
      var jsonMap = json.decode(responseBody);
      var errorMessage = jsonMap['error_message'];
      return false;
    }
  } catch (e) {
    print('Erro ao fazer a chamada HTTP: $e');
    return false;
  }
}

Future<File> resizeImage(File image) async {
  imageLib.Image imageData = imageLib.decodeImage(image.readAsBytesSync())!;
  imageLib.Image resizedImage =
      imageLib.copyResize(imageData, width: 600);
  final directory = await getTemporaryDirectory();
  final resizedFile = File('${directory.path}/resized_image.jpg');
  await resizedFile.writeAsBytes(imageLib.encodeJpg(resizedImage));
  return resizedFile;
}
