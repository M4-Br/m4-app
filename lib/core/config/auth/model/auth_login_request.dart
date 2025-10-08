// 1. Importe a constante kIsWeb
import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:io';
import 'package:get/get.dart';

class AuthLoginRequest {
  const AuthLoginRequest({
    required this.document,
    required this.password,
  });

  final String document;
  final String password;

  bool get isAndroid => !kIsWeb && Platform.isAndroid;

  String get version {
    if (kIsWeb) {
      return '${'version_app'.tr}W';
    }
    return isAndroid ? '${'version_app'.tr}A' : '${'version_app'.tr}I';
  }

  Map<String, dynamic> toJson() {
    return {
      'document': document,
      'password': password,
      // 4. Use o getter corrigido aqui também
      'is_android': isAndroid,
      'version': version
    };
  }
}
