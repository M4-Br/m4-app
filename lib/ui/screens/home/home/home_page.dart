import 'package:app_flutter_miban4/data/model/home/home.dart';
import 'package:app_flutter_miban4/data/model/userData/user.dart';
import 'package:app_flutter_miban4/ui/colors/app_colors.dart';
import 'package:app_flutter_miban4/ui/components/home/card.dart';
import 'package:app_flutter_miban4/ui/components/home/homeIcons.dart';
import 'package:app_flutter_miban4/ui/components/home/home_detail/clipper.dart';
import 'package:app_flutter_miban4/ui/controllers/home/home_controller.dart';
import 'package:app_flutter_miban4/ui/controllers/login/user_controller.dart';
import 'package:app_flutter_miban4/ui/controllers/notifications/notifications_controller.dart';
import 'package:app_flutter_miban4/ui/screens/home/barcodePayment/barcode_scan.dart';
import 'package:app_flutter_miban4/ui/screens/home/credit/credit_screen.dart';
import 'package:app_flutter_miban4/ui/screens/home/groups/group_screen.dart';
import 'package:app_flutter_miban4/ui/screens/home/notifications/notifications_page.dart';
import 'package:app_flutter_miban4/ui/screens/home/paymentLink/paymentLinkValue.dart';
import 'package:app_flutter_miban4/ui/screens/home/pix/pixHome.dart';
import 'package:app_flutter_miban4/ui/screens/home/pix/pixReceive.dart';
import 'package:app_flutter_miban4/ui/screens/home/savings/savings_screen.dart';
import 'package:app_flutter_miban4/ui/screens/home/store/store_page.dart';
import 'package:app_flutter_miban4/ui/screens/home/transfer/qrcode_screen.dart';
import 'package:app_flutter_miban4/ui/screens/home/transfer/transfer_contact_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
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
    String? defaulter = box.read('defaulter');

    HomeController homeController = Get.find();

    List<IconModel> manualIcons = [
      IconModel(
          id: "20",
          icon: "assets/icons/ic_group_blue.png",
          title: AppLocalizations.of(context)!.home_groups),
      IconModel(
          id: "21",
          icon: "assets/icons/ic_economy_blue.png",
          title: AppLocalizations.of(context)!.home_economy),
      IconModel(
          id: "22",
          icon: "assets/icons/ic_credit_blue.png",
          title: AppLocalizations.of(context)!.home_credit),
    ];

    final List<String> iconPaths = [
      'assets/icons/ic_home_payment.png',
      'assets/icons/ic_home_qrcode.png',
      'assets/icons/ic_home_payment_invoice.png',
      'assets/icons/ic_home_transfer.png',
      'assets/icons/ic_home_recharge.png',
      'assets/icons/ic_store.png',
      'assets/icons/ic_home_pix.png'
    ];

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
                            IconModel iconModel = homeController.icons[index];
                            return HomeIcons(
                              iconUrl: iconPaths[index],
                              text: iconModel.title!,
                              isLocal: true,
                              onPressed: () async {
                                switch (iconModel.id) {
                                  case "1":
                                    Get.to(() => const PaymentLinkValue(),
                                        transition: Transition.rightToLeft);
                                    break;
                                  case "2":
                                    Get.to(() => const QrcodeScreen(),
                                        transition: Transition.rightToLeft);
                                    break;
                                  case "10":
                                    Get.to(() => const BarcodeScanScreen(),
                                        transition: Transition.rightToLeft);
                                    break;
                                  case "11":
                                    Get.to(() => const TransferContactPage(),
                                        transition: Transition.rightToLeft);
                                    break;
                                  case "12":
                                    Get.defaultDialog(
                                        title: AppLocalizations.of(context)!
                                            .message,
                                        content: Column(
                                          children: [
                                            Text(AppLocalizations.of(context)!
                                                .unavailable),
                                            Padding(
                                              padding: const EdgeInsets.all(16),
                                              child: SizedBox(
                                                height: 45,
                                                width: double.infinity,
                                                child: ElevatedButton(
                                                  onPressed: () => Get.back(),
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        secondaryColor,
                                                    shape:
                                                        RoundedRectangleBorder(
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
                                            )
                                          ],
                                        ));
                                    break;
                                  case "14":
                                    Get.to(() => const StorePage(),
                                        transition: Transition.rightToLeft);
                                    break;
                                  case "19":
                                    Get.to(() => PixHome(),
                                        transition: Transition.rightToLeft);
                                    break;
                                  default:
                                    break;
                                }
                              },
                            );
                          } else {
                            IconModel manualIcon = manualIcons[
                                index - homeController.icons.length];
                            return HomeIcons(
                              iconUrl: manualIcon.icon!,
                              text: manualIcon.title!,
                              isLocal: true,
                              onPressed: () async {
                                switch (manualIcon.id) {
                                  case "20":
                                    if (defaulter == 'true') {
                                      Get.defaultDialog(
                                          backgroundColor: Colors.white,
                                          title: AppLocalizations.of(context)!
                                              .message,
                                          titleStyle: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                          content: Column(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                  AppLocalizations.of(context)!
                                                      .block_access,
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                              ElevatedButton(
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
                                                      color: Colors.white),
                                                ),
                                              )
                                            ],
                                          ));
                                    } else {
                                      Get.to(() => const GroupsScreen(),
                                          transition: Transition.rightToLeft);
                                    }
                                    break;
                                  case "21":
                                    if (defaulter == 'true') {
                                      Get.defaultDialog(
                                          backgroundColor: Colors.white,
                                          title: AppLocalizations.of(context)!
                                              .message,
                                          titleStyle: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                          content: Column(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                  AppLocalizations.of(context)!
                                                      .block_access,
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                              ElevatedButton(
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
                                                      color: Colors.white),
                                                ),
                                              )
                                            ],
                                          ));
                                    } else {
                                      Get.to(() => const SavingsScreen(),
                                          transition: Transition.rightToLeft);
                                    }
                                    break;
                                  case "22":
                                    if (defaulter == 'true') {
                                      Get.defaultDialog(
                                          backgroundColor: Colors.white,
                                          title: AppLocalizations.of(context)!
                                              .message,
                                          titleStyle: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                          content: Column(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                  AppLocalizations.of(context)!
                                                      .block_access,
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                              ElevatedButton(
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
                                                      color: Colors.white),
                                                ),
                                              )
                                            ],
                                          ));
                                    } else {
                                      Get.to(() => const CreditScreen(),
                                          transition: Transition.rightToLeft);
                                      break;
                                    }
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
