import 'package:get_storage/get_storage.dart';

class AppHeader {
  const AppHeader();

  Map<String, String> get headers {
    final box = GetStorage();
    final token = box.read('token');
    final language = box.read('language');

    return {
      'subscription-key': 'a0991d6076cf4b74976383eedc2a30dc',
      'app-key': '2z4R55CZdPiuKVJeOnCmWp8krhexXzINcKwOc22y1US49TaBEHqDJhN3wMqp',
      'Accept-Language': language ?? 'pt_BR',
      'Content-Type': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };
  }
}
