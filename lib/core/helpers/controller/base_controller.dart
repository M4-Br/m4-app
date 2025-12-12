import 'package:app_flutter_miban4/core/config/auth/controller/user_rx.dart';
import 'package:app_flutter_miban4/core/config/auth/model/user.dart';
import 'package:app_flutter_miban4/core/config/log/logger.dart';
import 'package:app_flutter_miban4/core/helpers/connection/api_exception.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_toaster.dart';
import 'package:get/get.dart';

abstract class BaseController extends GetxController {
  final UserRx userRx = Get.find();
  var isLoading = false.obs;

  @override
  void onInit() {
    ever(userRx.user, (User? user) {
      if (user == null) {
        userRx.handleUnauthenticatedUser();
      }
    });

    if (userRx.user.value == null) {
      userRx.handleUnauthenticatedUser();
    }
    super.onInit();
  }

  Future<void> executeSafe(Future<void> Function() action,
      {String? message}) async {
    try {
      isLoading(true);
      await action();
    } on UnauthorizedException catch (e) {
      ShowToaster.toasterInfo(message: e.message);
      userRx.handleUnauthenticatedUser();
    } on ServerException catch (e) {
      ShowToaster.toasterInfo(message: e.message);
    } on ApiException catch (e) {
      ShowToaster.toasterInfo(message: e.message);
    } catch (e, s) {
      AppLogger.I().error('Base Controller', e, s);
      rethrow;
    } finally {
      isLoading(false);
    }
  }
}
