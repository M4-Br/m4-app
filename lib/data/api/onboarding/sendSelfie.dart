import 'dart:convert';
import 'dart:io';
import 'package:app_flutter_miban4/data/api/url/url_api.dart';
import 'package:app_flutter_miban4/data/util/helpers/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as imageLib;
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:path_provider/path_provider.dart';

Future<Map<String, dynamic>> sendSelfie(File image) async {
  String id = await SharedPreferencesFunctions.getString(key: 'id');

  // Redimensione a imagem antes de enviar
  final resizedImage = await resizeImage(image);

  String apiUrl = '${ApiUrls.baseUrl}/v2/register/individual/step8/$id';

  Map<String, String> headers = {
    'subscription-key': 'a0991d6076cf4b74976383eedc2a30dc',
    'app-key': '2z4R55CZdPiuKVJeOnCmWp8krhexXzINcKwOc22y1US49TaBEHqDJhN3wMqp',
  };

  var request = http.MultipartRequest('POST', Uri.parse(apiUrl));
  request.headers.addAll(headers);

  var multipartFile = await http.MultipartFile.fromPath(
      'file_path', resizedImage.path,
      contentType: MediaType('image', 'jpg'));

  request.fields['_method'] = 'POST';
  request.files.add(multipartFile);

  var response = await request.send();
  var statusCode = response.statusCode;

  var responseBody = await response.stream.bytesToString();
  var jsonMap = json.decode(responseBody);

  if (statusCode == 200) {
    if (jsonMap['success'] == true) {
      return jsonMap;
    } else {
      return jsonMap;
    }
  } else {
    Get.snackbar('Erro ${response.statusCode}', jsonMap['message'],
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 5),
        icon: SvgPicture.asset('assets/images/miban4_colored_logo.svg'),
        backgroundColor: Colors.white,
        padding: const EdgeInsets.all(8));
    return jsonMap;
  }
}

Future<File> resizeImage(File image) async {
  imageLib.Image imageData = imageLib.decodeImage(image.readAsBytesSync())!;
  imageLib.Image resizedImage = imageLib.copyResize(imageData, width: 480);
  final directory = await getTemporaryDirectory();
  final resizedFile = File('${directory.path}/resized_image.jpg');
  await resizedFile.writeAsBytes(imageLib.encodeJpg(resizedImage, quality: 50));
  return resizedFile;
}
