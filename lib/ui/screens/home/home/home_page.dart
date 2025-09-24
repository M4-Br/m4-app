import 'package:app_flutter_miban4/data/model/home/home.dart';
import 'package:app_flutter_miban4/data/model/userData/user.dart';
import 'package:app_flutter_miban4/ui/colors/app_colors.dart';
import 'package:app_flutter_miban4/ui/components/home/card.dart';
import 'package:app_flutter_miban4/ui/components/home/homeIcons.dart';
import 'package:app_flutter_miban4/ui/components/home/home_detail/clipper.dart';
import 'package:app_flutter_miban4/ui/controllers/home/home_controller.dart';
import 'package:app_flutter_miban4/ui/controllers/login/user_controller.dart';
import 'package:app_flutter_miban4/ui/controllers/notifications/notifications_controller.dart';
import 'package:app_flutter_miban4/ui/screens/home/barcodePayment/barcode_camera.dart';
import 'package:app_flutter_miban4/ui/screens/home/barcodePayment/barcode_scan.dart';
import 'package:app_flutter_miban4/ui/screens/home/notifications/notifications_page.dart';
import 'package:app_flutter_miban4/ui/screens/home/partners/webview_page.dart';
import 'package:app_flutter_miban4/ui/screens/home/paymentLink/paymentLinkValue.dart';
import 'package:app_flutter_miban4/ui/screens/home/pix/pixHome.dart';
import 'package:app_flutter_miban4/ui/screens/home/pix/pixReceive.dart';
import 'package:app_flutter_miban4/ui/screens/home/qrcodePayment/qr_code_camera.dart';
import 'package:app_flutter_miban4/ui/screens/home/services/services_page.dart';
import 'package:app_flutter_miban4/ui/screens/home/store/store_page.dart';
import 'package:app_flutter_miban4/ui/screens/home/transfer/transfer_contact_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final UserController _userController = Get.put(UserController());
  final NotificationsController _notifications =
      Get.put(NotificationsController());
  bool notifications = false;
  final box = GetStorage();

  @override
  void initState() {
    super.initState();
    getNotifications();
  }

  getNotifications() async {
    await _notifications.notificationsIcon();
    setState(() {
      notifications = _notifications.hasUnreadNotifications.value;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    HomeController homeController = Get.find();

    List<IconModel> manualIcons = [
      // IconModel(
      //     id: "20",
      //     icon: "assets/icons/ic_group_blue.png",
      //     title: 'home_groups'.tr),
      // IconModel(
      //     id: "21",
      //     icon: "assets/icons/ic_economy_blue.png",
      //     title: 'home_economy'.tr),
      // IconModel(
      //     id: "22",
      //     icon: "assets/icons/ic_credit_blue.png",
      //     title: 'home_credit'.tr),

      IconModel(
          id: "23",
          icon: "assets/icons/ic_contabil.png",
          title: "contability_title".tr),
      IconModel(
          id: "24", icon: "assets/icons/ic_services.png", title: "services_title".tr),
    ];

    final Map<String, String> localIconPaths = {
      "1": 'assets/icons/ic_home_payment.png',
      "2": 'assets/icons/ic_home_qrcode.png',
      "10": 'assets/icons/ic_home_payment_invoice.png',
      "11": 'assets/icons/ic_home_transfer.png',
      "12": 'assets/icons/ic_home_recharge.png',
      "14": 'assets/icons/ic_home_store.png',
      "19": 'assets/icons/ic_home_pix.png',
      "30": 'assets/icons/ic_home_faq.png',
      "31": 'assets/icons/ic_home_warning.png',
    };

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Obx(() {
        UserData? userData = _userController.userData.value;
        return Stack(
          children: [
            ClipPath(
              clipper: BackWaveClipper(),
              child: Container(
                color: secondaryColor,
                height: 280,
              ),
            ),
            ClipPath(
              clipper: FrontWaveClipper(),
              child: Container(
                color: primaryColor,
                height: 240,
              ),
            ),
            Positioned(
              top: 40,
              left: 16,
              right: 16,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () async {
                      Get.to(
                          () => const PixReceive(
                                type: 1,
                              ),
                          transition: Transition.rightToLeft);
                    },
                    icon: const Icon(
                      Icons.qr_code_2,
                      color: Colors.white,
                      size: 32,
                    ),
                  ),
                  Text(
                    userData!.payload.username,
                    style: const TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  IconButton(
                      onPressed: () {
                        Get.to(() => const Notifications(),
                            transition: Transition.rightToLeft);
                      },
                      icon: const Icon(
                        Icons.notifications,
                        color: Colors.red,
                        size: 32,
                      )),
                ],
              ),
            ),
            const Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: EdgeInsets.only(top: 90),
                child: HomeCard(),
              ),
            ),
            Obx(() {
              if (homeController.isLoading.value) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: secondaryColor,
                  ),
                );
              } else if (homeController.error.value.isNotEmpty) {
                return Center(
                  child: Text(
                    homeController.error.value,
                    textAlign: TextAlign.center,
                  ),
                );
              } else if (homeController.icons.isEmpty) {
                return const Center(
                  child: Text(
                    "Erro ao carregar",
                    textAlign: TextAlign.center,
                  ),
                );
              } else {
                return Column(
                  children: [
                    Stack(
                      children: [
                        ClipPath(
                          clipper: BackWaveClipper(),
                          child: Container(
                            color: secondaryColor,
                            height: 280,
                          ),
                        ),
                        ClipPath(
                          clipper: FrontWaveClipper(),
                          child: Container(
                            color: primaryColor,
                            height: 240,
                          ),
                        ),
                        Positioned(
                          top: 40,
                          left: 16,
                          right: 16,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                onPressed: () async {
                                  Get.to(
                                      () => const PixReceive(
                                            type: 1,
                                          ),
                                      transition: Transition.rightToLeft);
                                },
                                icon: const Icon(
                                  Icons.qr_code_2,
                                  color: Colors.white,
                                  size: 32,
                                ),
                              ),
                              Text(
                                userData.payload.username,
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                              IconButton(
                                onPressed: () {
                                  Get.to(() => const Notifications(),
                                      transition: Transition.rightToLeft);
                                },
                                icon: notifications == false
                                    ? const Icon(
                                        Icons.notifications,
                                        color: Colors.white,
                                        size: 32,
                                      )
                                    : const Icon(
                                        Icons.notifications_active,
                                        color: Colors.red,
                                        size: 32,
                                      ),
                              ),
                            ],
                          ),
                        ),
                        const Align(
                          alignment: Alignment.topCenter,
                          child: Padding(
                            padding: EdgeInsets.only(top: 90),
                            child: HomeCard(),
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: GridView.builder(
                        scrollDirection: Axis.vertical,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          childAspectRatio: 1.0,
                        ),
                        itemCount:
                            homeController.icons.length + manualIcons.length,
                        itemBuilder: (context, index) {
                          if (index < homeController.icons.length) {
                            // Ícones vindos do controller
                            IconModel iconModel = homeController.icons[index];

                            return HomeIcons(
                              iconUrl: localIconPaths[iconModel.id]!,
                              text: iconModel.title!,
                              isLocal: true,
                              onPressed: () async {
                                switch (iconModel.id) {
                                  case "1":
                                    Get.to(() => const PaymentLinkValue(),
                                        transition: Transition.rightToLeft);
                                    break;
                                  case "2":
                                    Get.to(() => const QrCodeCamera(),
                                        transition: Transition.rightToLeft);
                                    break;
                                  case "10":
                                    Get.to(() => const BarcodeCamera(),
                                        transition: Transition.rightToLeft);
                                    break;
                                  case "11":
                                    Get.to(() => const TransferContactPage(),
                                        transition: Transition.rightToLeft);
                                    break;
                                  case "12":
                                    Get.defaultDialog(
                                      title: 'message'.tr,
                                      content: Column(
                                        children: [
                                          Text('unavailable'.tr),
                                          Padding(
                                            padding: const EdgeInsets.all(16),
                                            child: SizedBox(
                                              height: 45,
                                              width: double.infinity,
                                              child: ElevatedButton(
                                                onPressed: () => Get.back(),
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      secondaryColor,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            45),
                                                  ),
                                                ),
                                                child: const Text(
                                                  'OK',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 16,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                    break;
                                  case "14":
                                    Get.to(() => const StorePage(),
                                        transition: Transition.rightToLeft);
                                    break;
                                  case "19":
                                    Get.to(() => PixHome(),
                                        transition: Transition.rightToLeft);
                                    break;
                                  case "30":
                                    Get.to(
                                        () => WebviewPage(
                                              url: 'https://miban4.com',
                                              pageTitle: iconModel.title!,
                                            ),
                                        transition: Transition.rightToLeft);
                                    break;
                                  case "31":
                                    Get.to(
                                        () => WebviewPage(
                                              url: 'https://miban4.com/#faq',
                                              pageTitle: iconModel.title!,
                                            ),
                                        transition: Transition.rightToLeft);
                                    break;
                                }
                              },
                            );
                          } else {
                            // Ícones manuais
                            IconModel manualIcon = manualIcons[
                                index - homeController.icons.length];

                            return HomeIcons(
                              iconUrl: manualIcon.icon!,
                              text: manualIcon.title!,
                              isLocal: true,
                              onPressed: () async {
                                switch (manualIcon.id) {
                                  case "23":
                                    //TODO: Contabilidade
                                    break;
                                  case "24":
                                    Get.to(() => const ServicesPage(), transition: Transition.rightToLeft);
                                    break;
                                }
                              },
                            );
                          }
                        },
                      ),
                    ),
                  ],
                );
              }
            }),
          ],
        );
      }),
    );
  }
}
