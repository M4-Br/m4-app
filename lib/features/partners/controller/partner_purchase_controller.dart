import 'package:app_flutter_miban4/core/config/routes/app_routes.dart';
import 'package:app_flutter_miban4/core/helpers/controller/base_controller.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_toaster.dart';
import 'package:app_flutter_miban4/features/partners/model/partner_sale_model.dart';
import 'package:app_flutter_miban4/features/partners/model/partners_model.dart';
import 'package:app_flutter_miban4/features/partners/repository/partner_sale_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'dart:math';
import 'package:intl/intl.dart';

class PartnerPurchaseController extends BaseController {
  final PartnerSaleRepository _saleRepository = PartnerSaleRepository();

  late PartnerItem item;
  late String region;
  late String operationId;
  late int numericTransactionId;

  final passwordController = TextEditingController();
  final _secureStorage = const FlutterSecureStorage();

  @override
  void onInit() {
    super.onInit();

    final args = Get.arguments as Map<String, dynamic>?;
    if (args != null) {
      item = args['item'];
      region = args['region'] ?? 'Maringá';
    }

    final rand = Random();
    numericTransactionId = rand.nextInt(999999);

    operationId =
        '#Operação ${rand.nextInt(9999)}.${rand.nextInt(9999)}.${rand.nextInt(9999)}-${rand.nextInt(99)}';
  }

  @override
  void onClose() {
    passwordController.dispose();
    super.onClose();
  }

  Future<void> verifyPasswordAndConfirm() async {
    final password = passwordController.text;
    if (password.isEmpty) {
      ShowToaster.toasterInfo(message: 'A senha é obrigatória', isError: true);
      return;
    }

    final savedPassword = await _secureStorage.read(key: 'user_password');

    if (savedPassword != null && savedPassword == password) {
      Get.back();
      await _processPurchase();
    } else {
      ShowToaster.toasterInfo(message: 'Senha incorreta', isError: true);
      passwordController.clear();
    }
  }

  Future<void> _processPurchase() async {
    await executeSafe(() async {
      isLoading.value = true;

      final newSale = PartnerSale(
        userId: userRx.userId!,
        partnerProductId: int.parse(item.id),
        quantity: 1,
        totalValue: item.partnerValue,
        saleDate: DateFormat('yyyy-MM-dd').format(DateTime.now()),
        transactionId: numericTransactionId,
      );

      await _saleRepository.createSale(newSale);

      ShowToaster.toasterInfo(message: 'Compra confirmada com sucesso!');

      Get.offNamed(AppRoutes.partnerReceipt, arguments: {
        'item': item,
        'operationId': operationId,
        'transactionId': numericTransactionId,
        'date': DateFormat('dd/MM/yyyy HH:mm').format(DateTime.now()),
      });
    }, message: 'Erro ao processar a compra');

    isLoading.value = false;
  }
}
