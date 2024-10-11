
import 'package:app_flutter_miban4/data/api/pix/pixGetLimits.dart';
import 'package:app_flutter_miban4/data/model/pix/pixMyLimits.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class MyLimitsController extends GetxController {
  var isLoading = false.obs;
  final pixLimits = Rx<PixLimits?>(null);

  Future<PixLimits> myLimits() async {
    isLoading(true);

    try {
      PixLimits limits = await pixGetLimits();

      if(limits.success == true) {
        pixLimits.value = limits;
        isLoading(false);
        return limits;
      } else {
        return limits;
      }
    } catch (error) {
      PixLimits limits = await pixGetLimits();
      isLoading(false);
      return limits;
    }
  }
}