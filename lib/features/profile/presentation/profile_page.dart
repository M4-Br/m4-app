import 'package:app_flutter_miban4/core/config/auth/model/user.dart';
import 'package:app_flutter_miban4/core/config/routes/app_routes.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_button.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_loading.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_text.dart';
import 'package:app_flutter_miban4/data/api/url/url_api.dart';
import 'package:app_flutter_miban4/data/util/helpers/mask.dart';
import 'package:app_flutter_miban4/features/profile/controller/profile_controller.dart';
import 'package:app_flutter_miban4/features/profile/presentation/change_password_page.dart';
import 'package:app_flutter_miban4/ui/components/appBar/appBar_components.dart';
import 'package:app_flutter_miban4/ui/screens/politics/privacy_policy_page.dart';
import 'package:app_flutter_miban4/ui/screens/politics/terms_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfilePage extends GetView<ProfileController> {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarDefault(
        title: 'perfil_icon'.tr,
        hasIcon: false,
      ),
      body: Obx(() {
        final user = controller.userRx.user.value;

        if (user == null) {
          return const AppLoading();
        }

        final payload = user.payload;
        final account = payload.aliasAccount;

        return Column(
          children: [
            _buildProfileHeader(context, payload),
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  ExpansionTile(
                    leading: const Icon(Icons.person_pin_outlined,
                        color: Colors.black),
                    title: Text('account_myAccount'.tr),
                    children: [
                      _buildExpansionContent([
                        _buildDetailRow(
                            'account_bank'.tr, account?.bankNumber ?? ''),
                        _buildDetailRow('account_agency'.tr,
                            account?.branchNumber.toString() ?? ''),
                        _buildDetailRow(
                            'account_account'.tr, account?.accountNumber ?? ''),
                      ]),
                    ],
                  ),
                  ExpansionTile(
                    leading: const Icon(Icons.person_2_outlined,
                        color: Colors.black),
                    title: Text('account_personalData'.tr),
                    children: [
                      _buildExpansionContent([
                        _buildDetailRow('account_name'.tr, payload.fullName),
                        _buildDetailRow('account_document'.tr,
                            cpfMaskFormatter.maskText(payload.document)),
                      ]),
                    ],
                  ),
                  ListTile(
                    leading: const Icon(Icons.monetization_on_outlined,
                        color: Colors.black),
                    title: Text('account_data'.tr),
                    onTap: () => Get.toNamed(
                      AppRoutes.financialData,
                    ),
                  ),
                  ExpansionTile(
                    leading: const Icon(Icons.contact_mail_outlined,
                        color: Colors.black),
                    title: Text('account_contact'.tr),
                    children: [
                      _buildExpansionContent([
                        _buildDetailRow('EMAIL', payload.email),
                        _buildDetailRow('account_phone'.tr,
                            '(${payload.phone.phonePrefix}) ${payload.phone.phoneNumber}'),
                      ]),
                    ],
                  ),
                  ExpansionTile(
                    leading: const Icon(Icons.security_outlined,
                        color: Colors.black),
                    title: Text('account_security'.tr),
                    children: [
                      Container(
                        color: Colors.grey[100],
                        width: double.infinity,
                        alignment: Alignment.centerLeft,
                        child: TextButton(
                          onPressed: () => Get.to(
                              () => const ChangePasswordPage(),
                              transition: Transition.rightToLeft),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 58.0),
                            child: Text('change_app_password'.tr,
                                style: const TextStyle(
                                    fontWeight: FontWeight.normal,
                                    color: Colors.black,
                                    fontSize: 16)),
                          ),
                        ),
                      ),
                    ],
                  ),
                  ListTile(
                    leading: const Icon(Icons.diamond, color: Colors.black),
                    title: Text('account_plans'.tr),
                    onTap: () => Get.toNamed(AppRoutes.plans),
                  ),
                  ListTile(
                    leading:
                        const Icon(Icons.paste_outlined, color: Colors.black),
                    title: Text('account_terms'.tr),
                    onTap: () => Get.to(() => const TermsPage(),
                        transition: Transition.rightToLeft),
                  ),
                  ListTile(
                    leading: const Icon(Icons.table_view_outlined,
                        color: Colors.black),
                    title: Text('account_privacy'.tr),
                    onTap: () => Get.to(() => const PrivacyPolicyPage(),
                        transition: Transition.rightToLeft),
                  ),
                  ExpansionTile(
                    leading:
                        const Icon(Icons.help_outline, color: Colors.black),
                    title: Text('account_helper'.tr),
                    children: [
                      _buildExpansionContent([
                        _buildDetailRow('EMAIL', 'sac@mibanka4.com'),
                      ]),
                    ],
                  ),
                  ListTile(
                    leading: const Icon(Icons.exit_to_app_outlined,
                        color: Colors.black),
                    title: Text('account_logout'.tr),
                    onTap: () => _showLogoutConfirmation(context),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(32),
                    child: Center(
                      child: Text(
                        'version'.tr,
                        style: const TextStyle(color: Colors.black54),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }

  Widget _buildProfileHeader(BuildContext context, Payload payload) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 24.0),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.black12)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const SizedBox(width: 48),
              ClipOval(
                child: Image.network(
                  formatAvatarUrl(payload.avatarUrl ?? ''),
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.person, size: 100),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.edit, size: 20),
                onPressed: () {/* TODO: Implementar edição de foto */},
              ),
            ],
          ),
          const SizedBox(height: 16),
          AppText.bodyLarge(context, payload.username),
          const SizedBox(height: 4),
          Text(
            '@ ${payload.username.toLowerCase()}',
            style: const TextStyle(fontSize: 16, color: Colors.black54),
          ),
        ],
      ),
    );
  }

  Widget _buildExpansionContent(List<Widget> children) {
    return Container(
      color: Colors.grey[100],
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(72, 8, 16, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    );
  }

  Widget _buildDetailRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54)),
          Text(value, style: const TextStyle(fontSize: 16)),
        ],
      ),
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
        return SafeArea(
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AppText.bodyMedium(context, 'logout'.tr),
                const SizedBox(height: 24),
                SizedBox(
                    width: double.infinity,
                    child: AppButton(
                      buttonType: AppButtonType.filled,
                      onPressed: () async {
                        Get.back();
                        Get.offAllNamed(AppRoutes.splash);
                      },
                      labelText: 'logout_exit'.tr,
                    )),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: Text(
                      'cancel'.tr,
                      style:
                          const TextStyle(fontSize: 16, color: Colors.black54),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  String formatAvatarUrl(String avatarUrl) {
    const baseUrl = ApiUrls.baseUrl;

    final regex = RegExp(r'^.*(/storage.*)$');
    final match = regex.firstMatch(avatarUrl);

    if (match != null && match.group(1) != null) {
      return '$baseUrl${match.group(1)}';
    } else {
      return '$baseUrl/api/default_avatar.jpg';
    }
  }
}
