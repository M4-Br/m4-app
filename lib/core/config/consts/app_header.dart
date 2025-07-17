class AppHeader {
  AppHeader({this.token});

  final String? token;

  Map<String, String> get headers {
    return {
      'subscription-key': 'a0991d6076cf4b74976383eedc2a30dc',
      'app-key': '2z4R55CZdPiuKVJeOnCmWp8krhexXzINcKwOc22y1US49TaBEHqDJhN3wMqp',
      'Accept-Language': 'pt',
      if (token != null) 'Authorization': 'Bearer $token',
    };
  }
}
