import 'package:app_flutter_miban4/core/config/auth/model/auth_login_request.dart';
import 'package:app_flutter_miban4/core/config/auth/model/user.dart';
import 'package:app_flutter_miban4/core/config/auth/model/verify_user_response.dart';
import 'package:app_flutter_miban4/core/config/consts/paths/app_endpoints.dart';
import 'package:app_flutter_miban4/core/helpers/connection/app_connection.dart';

class AuthRepository {
  Future<VerifyUserResponse?> verifyAccount({required String document}) async {
    return await ApiConnection().get(
        endpoint: '${AppEndpoints.verifyAccount}$document',
        fromJson: (json) => VerifyUserResponse.fromJson(json));
  }

  Future<User> authLogin({required AuthLoginRequest loginRequest}) async {
    return await ApiConnection().post(
        endpoint: AppEndpoints.authLogin,
        body: loginRequest.toJson(),
        fromJson: (json) => User.fromJson(json));
  }
}
