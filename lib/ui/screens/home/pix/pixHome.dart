import 'package:app_flutter_miban4/data/api/balance/balanceAPI.dart';
import 'package:app_flutter_miban4/data/model/userData/balance.dart';
import 'package:app_flutter_miban4/features/balance/model/balance_response.dart';
import 'package:app_flutter_miban4/ui/components/appBar/appBar_components.dart';
import 'package:app_flutter_miban4/ui/components/pix/itens_home.dart';
import 'package:app_flutter_miban4/ui/components/pix/pix_balance.dart';
import 'package:app_flutter_miban4/features/home/presentation/home_view_page.dart';
import 'package:app_flutter_miban4/ui/screens/home/pix/pixCopyPaste.dart';
import 'package:app_flutter_miban4/ui/screens/home/pix/pixKeyManager.dart';
import 'package:app_flutter_miban4/ui/screens/home/pix/pixManualKey.dart';
import 'package:app_flutter_miban4/ui/screens/home/pix/pixMyLimits.dart';
import 'package:app_flutter_miban4/ui/screens/home/pix/pixReceive.dart';
import 'package:app_flutter_miban4/ui/screens/home/pix/pixScheduleTransfers.dart';
import 'package:app_flutter_miban4/ui/screens/home/pix/pixWithKey.dart';
import 'package:app_flutter_miban4/ui/screens/home/qrcodePayment/qr_code_camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PixHome extends StatefulWidget {
  late Balance? balance;

  PixHome({super.key, this.balance});

  @override
  State<PixHome> createState() => _PixHomeState();
}

class _PixHomeState extends State<PixHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withAlpha(240),
      appBar: AppBarDefault(
        title: 'PIX',
        backPage: () => Get.off(() => const HomeViewPage(),
            transition: Transition.leftToRight),
      ),
      body: Column(
        children: [
          const PixBalance(),
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10)),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 32, 16, 8),
                      child: PixHomeItens(
                          name: 'pix_manager_keys'.tr,
                          description: 'pix_manage_data'.tr,
                          onPressed: () {
                            Get.to(() => const PixKeyManager(),
                                transition: Transition.rightToLeft);
                          },
                          icon: Icons.account_tree_outlined),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                      child: PixHomeItens(
                          name: 'pix_myLimits'.tr,
                          description: 'pix_setLimit'.tr,
                          onPressed: () {
                            Get.to(() => const PixMyLimits(),
                                transition: Transition.rightToLeft);
                          },
                          icon: Icons.attach_money_outlined),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                      child: PixHomeItens(
                          name: 'pix_receive'.tr,
                          description: 'pix_receiveValue'.tr,
                          onPressed: () {
                            Get.to(() => const PixReceive(),
                                transition: Transition.rightToLeft);
                          },
                          icon: Icons.pix_outlined),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                      child: PixHomeItens(
                          name: 'pix_key'.tr,
                          description: 'pix_payKey'.tr,
                          onPressed: () {
                            Get.to(() => const PixWithKey(),
                                transition: Transition.rightToLeft);
                          },
                          icon: Icons.phonelink_sharp),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                      child: PixHomeItens(
                          name: 'pix_schedule_transfer'.tr,
                          description: 'Gerencie seus pix agendados',
                          onPressed: () {
                            Get.to(() => const PixScheduleTransfers(),
                                transition: Transition.rightToLeft);
                          },
                          icon: Icons.schedule_outlined),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                      child: PixHomeItens(
                          name: 'pix_manualKey'.tr,
                          description: 'pix_bank'.tr,
                          onPressed: () {
                            Get.to(() => const PixManualKey(),
                                transition: Transition.rightToLeft);
                          },
                          icon: Icons.account_balance_outlined),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                      child: PixHomeItens(
                          name: 'pix_qrCode'.tr,
                          description: 'pix_payQrCode'.tr,
                          onPressed: () {
                            Get.to(() => const QrCodeCamera(),
                                transition: Transition.rightToLeft);
                          },
                          icon: Icons.qr_code_2_outlined),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 32),
                      child: PixHomeItens(
                          name: 'pix_copyPaste'.tr,
                          description: 'pix_payCopy'.tr,
                          onPressed: () async {
                            await getBalance().then((balance) => {
                                  Get.to(
                                      () => PixCopyPaste(
                                            balance: BalanceResponse(
                                                success: true,
                                                balance: 12,
                                                balanceCents: 12,
                                                transactionalValue: 12),
                                          ),
                                      transition: Transition.rightToLeft)
                                });
                          },
                          icon: Icons.copy_outlined),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
