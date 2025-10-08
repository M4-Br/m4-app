import 'package:app_flutter_miban4/core/config/auth/controller/user_controller.dart';
import 'package:app_flutter_miban4/core/config/auth/model/user.dart';
import 'package:app_flutter_miban4/data/api/url/url_api.dart';
import 'package:app_flutter_miban4/data/model/params/params.dart';
import 'package:app_flutter_miban4/data/util/helpers/mask.dart';
import 'package:app_flutter_miban4/ui/colors/app_colors.dart';
import 'package:app_flutter_miban4/ui/components/appBar/appBar_components.dart';
import 'package:app_flutter_miban4/ui/components/perfil/commomItem.dart';
import 'package:app_flutter_miban4/ui/components/perfil/expansionItem.dart';
import 'package:app_flutter_miban4/ui/components/perfil/itemMyAccount.dart';
import 'package:app_flutter_miban4/ui/screens/home/perfil/change_password_page.dart';
import 'package:app_flutter_miban4/ui/screens/home/perfil/financial_data_page.dart';
import 'package:app_flutter_miban4/ui/screens/home/perfil/plans_page.dart';
import 'package:app_flutter_miban4/ui/screens/home/pix/pixReceive.dart';
import 'package:app_flutter_miban4/features/splash/presentation/splash_page.dart';
import 'package:app_flutter_miban4/ui/screens/politics/privacy_policy_page.dart';
import 'package:app_flutter_miban4/ui/screens/politics/terms_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final UserController _userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBarDefault(
        title: 'perfil_icon'.tr,
        hasIcon: false,
      ),
      body: Obx(() {
        User? userData = _userController.user.value;
        // Params? params = getGlobalParams();

        return Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 3,
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Colors.black12),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 9,
                      ),
                      ClipOval(
                        child: SizedBox(
                          width: 120,
                          height: 100,
                          child: Image.network(formatAvatarUrl(
                              userData!.payload.avatarUrl ?? '')),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {},
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      userData!.payload.username,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Text(
                    '@ ${userData!.payload.username}',
                    style: const TextStyle(fontSize: 16),
                  )
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ExpansionItemMyAccount(
                      text: 'account_myAccount'.tr,
                      account: userData.payload.aliasAccount!.accountNumber,
                      icon: Icons.person_pin_outlined,
                      agency: userData.payload.aliasAccount!.branchNumber
                          .toString(),
                      bank: userData.payload.aliasAccount!.bankNumber,
                    ),
                    CommonItem(
                        text: 'account_myQr'.tr,
                        icon: Icons.qr_code_outlined,
                        onPressed: () {
                          Get.to(() => const PixReceive(),
                              transition: Transition.rightToLeft);
                        }),
                    ExpansionItem(
                        icon: Icons.person_2_outlined,
                        fieldName: 'account_personalData'.tr,
                        firstFieldName: 'account_name'.tr,
                        firstField: userData.payload.fullName.toString(),
                        secondFieldName: 'account_document'.tr,
                        secondField: cpfMaskFormatter
                            .maskText(userData.payload.document.toString())),
                    CommonItem(
                        text: 'account_data'.tr,
                        icon: Icons.monetization_on_outlined,
                        onPressed: () => Get.to(() => const FinancialDataPage(),
                            transition: Transition.rightToLeft)),
                    ExpansionItem(
                        icon: Icons.contact_mail_outlined,
                        fieldName: 'account_contact'.tr,
                        firstFieldName: 'EMAIL',
                        firstField: userData.payload.email.toString(),
                        secondFieldName: 'account_phone'.tr,
                        secondField:
                            '(${userData.payload.phone.phonePrefix.toString()}) ${userData.payload.phone.phoneNumber.toString()}'),
                    ExpansionTile(
                      title: Text(
                        'account_security'.tr,
                        style: const TextStyle(color: Colors.black),
                      ),
                      leading: const Icon(
                        Icons.security_outlined,
                        color: Colors.black,
                      ),
                      children: [
                        Container(
                          color: Colors.grey[100],
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(32, 8, 0, 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    Get.to(() => const ChangePasswordPage(),
                                        transition: Transition.rightToLeft);
                                  },
                                  child: Text(
                                    'change_app_password'.tr,
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.normal),
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    CommonItem(
                        text: 'account_plans'.tr,
                        icon: Icons.diamond,
                        onPressed: () {
                          Get.to(() => const PlansPage(),
                              transition: Transition.rightToLeft);
                        }),
                    CommonItem(
                        text: 'account_terms'.tr,
                        icon: Icons.paste_outlined,
                        onPressed: () {
                          Navigator.push(
                              context,
                              PageTransition(
                                  child: const TermsPage(),
                                  type: PageTransitionType.rightToLeft));
                        }),
                    CommonItem(
                        text: 'account_privacy'.tr,
                        icon: Icons.table_view_outlined,
                        onPressed: () {
                          Navigator.push(
                              context,
                              PageTransition(
                                  child: const PrivacyPolicyPage(),
                                  type: PageTransitionType.rightToLeft));
                        }),
                    ExpansionItem(
                        icon: Icons.help_outline,
                        fieldName: 'account_helper'.tr,
                        firstFieldName: 'SAC',
                        firstField: '',

                        // params?.sacMibanka4.isNotEmpty ?? false
                        //     ? params!.sacMibanka4[0].value
                        //     : '',
                        secondFieldName: 'EMAIL',
                        secondField: 'sac@mibanka4.com'),
                    CommonItem(
                      text: 'account_logout'.tr,
                      icon: Icons.exit_to_app_outlined,
                      onPressed: () {
                        _showLogoutConfirmation(context);
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Text(
                        'version'.tr,
                        style: const TextStyle(color: Colors.black54),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }

  void _showLogoutConfirmation(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      builder: (BuildContext context) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  'logout'.tr,
                  style: const TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 16),
              const Divider(
                height: 1,
                color: Colors.black12,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  Get.back();
                  Get.offAll(() => const SplashPage(),
                      transition: Transition.cupertino);
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Center(
                    child: Text(
                      'logout_exit'.tr,
                      style:
                          const TextStyle(fontSize: 16, color: secondaryColor),
                    ),
                  ),
                ),
              ),
              const Divider(
                height: 1,
                color: Colors.black12,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  Get.back();
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Center(
                    child: Text(
                      'cancel'.tr,
                      style:
                          const TextStyle(fontSize: 16, color: Colors.black54),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  String formatAvatarUrl(String avatarUrl) {
    const baseUrl = ApiUrls.baseUrl;
    final regex = RegExp(r'^.*(/storage.*)$');
    final match = regex.firstMatch(avatarUrl);
    if (match != null) {
      return '$baseUrl${match.group(1)}';
    } else {
      // Caso a URL não esteja no formato esperado, retorne uma URL padrão ou trate o erro de acordo.
      return '$baseUrl/api/default_avatar.jpg';
    }
  }
}
