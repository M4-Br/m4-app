import 'package:app_flutter_miban4/core/config/auth/model/verify_user_response.dart';
import 'package:app_flutter_miban4/core/config/auth/repositories/auth_repository.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AuthRepository', () {
    test('deve chamar verifyAccount e retornar resposta', () async {
      final repository = AuthRepository();

      final response = await repository.verifyAccount(document: "33279287898");

      // Aqui você valida o que espera de volta
      expect(response, isA<VerifyUserResponse?>());
      // Se você tiver algum campo específico esperado:
      // expect(response?.status, equals("valid"));

      expect(response?.document, equals('33279287898'));
    });
  });
}
