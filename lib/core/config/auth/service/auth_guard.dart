import 'package:app_flutter_miban4/core/config/auth/service/auth_service.dart';
import 'package:app_flutter_miban4/core/config/log/logger.dart';
import 'package:app_flutter_miban4/core/config/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthGuard extends GetMiddleware {
  @override
  int? get priority => 1;

  @override
  RouteSettings? redirect(String? route) {
    if (!AuthService.to.isLogged) {
      AppLogger.I().info('Auth Guard blocked a route: $route');
      return const RouteSettings(name: AppRoutes.splash);
    }

    return null;
  }
}
