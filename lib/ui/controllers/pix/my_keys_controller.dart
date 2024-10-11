
import 'package:app_flutter_miban4/data/api/pix/pixKeys.dart';
import 'package:app_flutter_miban4/data/model/pix/pixKeys.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class MyKeysController extends GetxController {
  final isLoading = RxBool(false);
  final pixKeys = Rx<PixKeys?>(null);
  final error = RxString('');

  Future<PixKeys> getKeys() async {
    isLoading(true);

    try {
      PixKeys keys = await fetchPixKeys();
      pixKeys.value = keys;
      isLoading(false);
      return keys;
    } catch (error) {
      PixKeys keys = await fetchPixKeys();
      isLoading(false);
      return keys;
    } finally {
      isLoading.value = false;
    }
  }
}