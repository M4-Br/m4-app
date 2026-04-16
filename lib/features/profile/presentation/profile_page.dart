import 'package:app_flutter_miban4/core/config/auth/model/user.dart';
import 'package:app_flutter_miban4/core/config/auth/service/auth_service.dart';
import 'package:app_flutter_miban4/core/config/consts/paths/app_endpoints.dart';
import 'package:app_flutter_miban4/core/config/routes/app_routes.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_button.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_loading.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_text.dart';
import 'package:app_flutter_miban4/core/helpers/formatters/mask.dart';
import 'package:app_flutter_miban4/features/profile/controller/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfilePage extends GetView<ProfileController> {
  const ProfilePage({super.key});

  final Color _greenDark = const Color(0xFF065F46);
  final Color _bgLight = const Color(0xFFF8F9FA);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bgLight,
      appBar: AppBar(
        backgroundColor: _greenDark,
        elevation: 0,
        centerTitle: false,
        title: Text('Meu Perfil',
            style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold)),
      ),
      body: Obx(() {
        final user = controller.userRx.user.value;

        if (user == null) {
          return const AppLoading();
        }

        final payload = user.payload;
        final account = payload.aliasAccount;

        return Stack(
          children: [
            // 1. Fundo verde estendido
            Container(
              height: 100,
              width: double.infinity,
              color: _greenDark,
            ),

            // 2. Conteúdo da tela
            Column(
              children: [
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    children: [
                      // --- CARD DO PERFIL E SALDOS ---
                      _buildProfileCard(context, payload),
                      const SizedBox(height: 24),

                      // --- ALERTA DE CADASTRO PENDENTE ---
                      if (controller.showCompleteProfileOption) ...[
                        _buildPendingAlert(),
                        const SizedBox(height: 16),
                      ],

                      // --- CARD DE MENU UNIFICADO ---
                      _buildMenuCard(payload, account),

                      const SizedBox(height: 24),

                      // --- BOTÃO DE SAIR ---
                      OutlinedButton.icon(
                        icon: const Icon(Icons.logout,
                            color: Colors.redAccent, size: 20),
                        label: Text('account_logout'.tr,
                            style: const TextStyle(
                                color: Colors.redAccent,
                                fontWeight: FontWeight.bold)),
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: Colors.red.shade200),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          backgroundColor: Colors.white,
                        ),
                        onPressed: () => _showLogoutConfirmation(context),
                      ),

                      // --- VERSÃO DO APP ---
                      Padding(
                        padding: const EdgeInsets.all(32),
                        child: Center(
                          child: Obx(() => Text(
                                'Versão ${controller.appVersion.value}',
                                style: TextStyle(
                                    color: Colors.grey.shade500, fontSize: 12),
                              )),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        );
      }),
    );
  }

  // --- 1. CARD SUPERIOR (FOTO, NOME, SALDOS) ---
  Widget _buildProfileCard(BuildContext context, Payload payload) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 10,
              offset: const Offset(0, 4)),
        ],
      ),
      child: Column(
        children: [
          // Info do Usuário
          Row(
            children: [
              // Avatar
              ClipOval(
                child: Image.network(
                  formatAvatarUrl(payload.avatarUrl ?? ''),
                  width: 64,
                  height: 64,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    width: 64,
                    height: 64,
                    color: const Color(0xFF1ABC9C),
                    child: Center(
                      child: Text(
                        payload.username.isNotEmpty
                            ? payload.username[0].toUpperCase()
                            : 'U',
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              // Textos
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(payload.username,
                        style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87)),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(Icons.mail_outline,
                            size: 14, color: Colors.black54),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                              payload.email.isNotEmpty
                                  ? payload.email
                                  : '@${payload.username.toLowerCase()}',
                              style: const TextStyle(
                                  fontSize: 13, color: Colors.black54),
                              overflow: TextOverflow.ellipsis),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 24),

          // Caixas de Saldo (Placeholder inspirado no seu print)
          Row(
            children: [
              Expanded(
                  child: _buildBalanceBox('R\$ 0', 'Disponível',
                      const Color(0xFFE8FDF5), const Color(0xFF059669))),
              const SizedBox(width: 12),
              Expanded(
                  child: _buildBalanceBox('R\$ 0', 'Utilizado',
                      const Color(0xFFEFF6FF), const Color(0xFF2563EB))),
              const SizedBox(width: 12),
              Expanded(
                  child: _buildBalanceBox('R\$ 0', 'Acumulado',
                      const Color(0xFFF5F3FF), const Color(0xFF9333EA))),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildBalanceBox(
      String value, String label, Color bgColor, Color textColor) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
          color: bgColor, borderRadius: BorderRadius.circular(12)),
      child: Column(
        children: [
          Text(value,
              style: TextStyle(
                  color: textColor, fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 2),
          Text(label,
              style: TextStyle(
                  color: textColor.withValues(alpha: 0.8), fontSize: 11)),
        ],
      ),
    );
  }

  // --- ALERTA DE CADASTRO ---
  Widget _buildPendingAlert() {
    return Container(
      decoration: BoxDecoration(
          color: Colors.red.shade50,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.red.shade100)),
      child: ListTile(
        leading: const Icon(Icons.error_outline, color: Colors.redAccent),
        title: const Text('Complete seu perfil',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.redAccent,
                fontSize: 14)),
        subtitle: Text('Você tem pendências no cadastro',
            style: TextStyle(color: Colors.redAccent.shade200, fontSize: 12)),
        trailing: const Icon(Icons.chevron_right, color: Colors.redAccent),
        onTap: () => controller.redirectToCompleteProfile(),
      ),
    );
  }

  // --- 2. CARD DO MENU UNIFICADO ---
  Widget _buildMenuCard(Payload payload, dynamic account) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withValues(alpha: 0.03),
              blurRadius: 10,
              offset: const Offset(0, 2))
        ],
      ),
      // Theme para remover as linhas pretas nativas do ExpansionTile
      child: Theme(
        data: Theme.of(Get.context!).copyWith(dividerColor: Colors.transparent),
        child: Column(
          children: [
            _buildExpansionMenuItem(
                Icons.person_pin_outlined, 'account_myAccount'.tr, [
              _buildDetailRow(
                  'account_bank'.tr, account?.bankNumber ?? 'Em análise'),
              _buildDetailRow(
                  'account_agency'.tr,
                  (account != null)
                      ? account.branchNumber.toString()
                      : 'Em análise'),
              _buildDetailRow(
                  'account_account'.tr, account?.accountNumber ?? 'Em análise'),
            ]),
            _buildDivider(),
            _buildExpansionMenuItem(
                Icons.person_2_outlined, 'account_personalData'.tr, [
              _buildDetailRow('account_name'.tr, payload.fullName),
              _buildDetailRow('account_document'.tr,
                  cpfMaskFormatter.maskText(payload.document)),
            ]),
            _buildSimpleMenuItem(
                Icons.factory_outlined,
                'MINHAS EMPRESAS (CNPJ)',
                () => Get.toNamed(AppRoutes.companyManager)),
            _buildDivider(),
            _buildSimpleMenuItem(Icons.monetization_on_outlined,
                'account_data'.tr, () => Get.toNamed(AppRoutes.financialData)),
            _buildDivider(),
            _buildExpansionMenuItem(
                Icons.contact_mail_outlined, 'account_contact'.tr, [
              _buildDetailRow('EMAIL', payload.email),
              _buildDetailRow('account_phone'.tr,
                  '(${payload.phone.phonePrefix}) ${payload.phone.phoneNumber}'),
            ]),
            _buildDivider(),
            _buildExpansionMenuItem(
                Icons.security_outlined, 'account_security'.tr, [
              _buildLinkRow('change_app_password'.tr,
                  () => Get.toNamed(AppRoutes.changePasswordEmailConfirm)),
            ]),
            _buildDivider(),
            _buildSimpleMenuItem(Icons.diamond_outlined, 'account_plans'.tr,
                () => Get.toNamed(AppRoutes.plans)),
            _buildDivider(),
            _buildSimpleMenuItem(Icons.paste_outlined, 'account_terms'.tr,
                () => Get.toNamed(AppRoutes.termsFromProfile)),
            _buildDivider(),
            _buildSimpleMenuItem(
                Icons.table_view_outlined,
                'account_privacy'.tr,
                () => Get.toNamed(AppRoutes.privacyPolicyFromLogin)),
            _buildDivider(),
            _buildExpansionMenuItem(Icons.help_outline, 'account_helper'.tr, [
              _buildDetailRow('EMAIL', 'sac@m4.com'),
            ]),
          ],
        ),
      ),
    );
  }

  // --- AJUDANTES DOS ITENS DE MENU ---
  Widget _buildDivider() => Divider(
      height: 1, color: Colors.grey.shade100, indent: 64, endIndent: 16);

  Widget _buildLeadingIcon(IconData icon) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Icon(icon, color: Colors.black54, size: 20),
    );
  }

  Widget _buildSimpleMenuItem(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      leading: _buildLeadingIcon(icon),
      title: Text(title,
          style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.black87)),
      trailing:
          const Icon(Icons.chevron_right, color: Colors.black38, size: 20),
      onTap: onTap,
    );
  }

  Widget _buildExpansionMenuItem(
      IconData icon, String title, List<Widget> children) {
    return ExpansionTile(
      tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      leading: _buildLeadingIcon(icon),
      iconColor: Colors.black38,
      collapsedIconColor: Colors.black38,
      title: Text(title,
          style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.black87)),
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.only(left: 64, right: 16, bottom: 16),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start, children: children),
        )
      ],
    );
  }

  Widget _buildDetailRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade500)),
          const SizedBox(height: 2),
          Text(value,
              style: const TextStyle(fontSize: 14, color: Colors.black87)),
        ],
      ),
    );
  }

  Widget _buildLinkRow(String title, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 12.0, top: 4.0),
        child: Text(title,
            style: const TextStyle(
                fontSize: 14,
                color: Color(0xFF2563EB),
                decoration: TextDecoration.underline)),
      ),
    );
  }

  // --- LÓGICA MANTIDA ORIGINALMENTE ---
  void _showLogoutConfirmation(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (BuildContext context) {
        return SafeArea(
          child: Container(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AppText.bodyMedium(context, 'logout'.tr, color: Colors.black87),
                const SizedBox(height: 24),
                SizedBox(
                    width: double.infinity,
                    child: AppButton(
                      buttonType: AppButtonType.filled,
                      onPressed: () async {
                        Get.back();
                        AuthService.to.logout();
                      },
                      labelText: 'logout_exit'.tr,
                    )),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    onPressed: () => Get.back(),
                    child: Text('cancel'.tr,
                        style: const TextStyle(
                            fontSize: 16, color: Colors.black54)),
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
    final baseUrl = AppEndpoints.baseUrl;
    final regex = RegExp(r'^.*(/storage.*)$');
    final match = regex.firstMatch(avatarUrl);

    if (match != null && match.group(1) != null) {
      return '$baseUrl${match.group(1)}';
    } else {
      return '$baseUrl/api/default_avatar.jpg';
    }
  }
}
