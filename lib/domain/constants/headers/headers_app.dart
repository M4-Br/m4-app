
class Headers {
  static const _subscriptionKey = 'a0991d6076cf4b74976383eedc2a30dc';
  static const _appKey = '2z4R55CZdPiuKVJeOnCmWp8krhexXzINcKwOc22y1US49TaBEHqDJhN3wMqp';

  // Headers sem o token de autorização
  static Map<String, String> get defaultHeaders => {
    'subscription-key': _subscriptionKey,
    'app-key': _appKey,
  };

  // Headers com o token de autorização
  static Map<String, String> tokenHeaders(String token) => {
    'Authorization': 'Bearer $token',
    'subscription-key': _subscriptionKey,
    'app-key': _appKey,
  };
}