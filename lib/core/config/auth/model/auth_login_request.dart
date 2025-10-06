import 'dart:io';

import 'package:get/get.dart';

class AuthLoginRequest {
  const AuthLoginRequest({
    required this.document,
    required this.password,
  });

  final String document;
  final String password;

  bool get isAndroid => Platform.isAndroid ? true : false;

  String get version =>
      isAndroid ? '${'version_app'.tr}A' : '${'version_app'.tr}I';

  Map<String, dynamic> toJson() {
    return {
      'document': document,
      'password': password,
      'is_android': true,
      'version': version
    };
  }
}
