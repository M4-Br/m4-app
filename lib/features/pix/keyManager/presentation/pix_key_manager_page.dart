import 'package:app_flutter_miban4/core/config/app/app_colors.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_text.dart';
import 'package:app_flutter_miban4/features/geral/widgets/app_bar.dart';
import 'package:app_flutter_miban4/features/geral/widgets/body_page.dart';
import 'package:app_flutter_miban4/features/pix/keyManager/controller/pix_key_manager_controller.dart';
import 'package:app_flutter_miban4/ui/widgets/dialogs/custom_dialogs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PixKeyManagerPage extends GetView<PixKeyManagerController> {
  const PixKeyManagerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFe9eaf0),
      appBar: CustomAppBar(
        title: 'pix_keyManager'.tr,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
              child: CircularProgressIndicator(color: primaryColor));
        }

        return Stack(
          children: [
            CustomPageBody(
              padding: EdgeInsets.zero,
              children: [
                if (controller.pixKeysData.value == null ||
                    controller.pixKeysData.value!.success == false)
                  _buildEmptyState(context)
                else
                  _buildKeysList(context),
              ],
            ),
            if (controller.isLoading.value)
              Container(
                color: Colors.black.withOpacity(0.3),
                child: const Center(
                  child: CircularProgressIndicator(color: Colors.white),
                ),
              ),
          ],
        );
      }),
    );
  }

  Widget _buildKeysList(BuildContext context) {
    final keys = controller.pixKeysData.value!;

    return Padding(
      padding: const EdgeInsets.only(bottom: 100),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSection(context, 'pix_phoneKey'.tr, keys.phones, 'phone'),
          _buildSection(
              context, 'pix_documentKey'.tr, keys.documents, 'document'),
          _buildSection(context, 'pix_emailKey'.tr, keys.emails, 'email'),
          _buildSection(context, 'pix_randomKey'.tr, keys.evps, 'evp'),
          const SizedBox(height: 32),
          Center(
            child: AppText.bodyMedium(
              context,
              'pix_fiveKeys'.tr,
              color: Colors.black54,
            ),
          ),
          const SizedBox(height: 16),
          _buildCreateButton(context),
        ],
      ),
    );
  }

  Widget _buildSection(
      BuildContext context, String title, List<dynamic> items, String type) {
    if (items.isEmpty) return const SizedBox.shrink();

    final validItems = items.where((item) => item.key.isNotEmpty).toList();
    if (validItems.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
          child: AppText.titleMedium(context, title, color: Colors.black87),
        ),
        ...validItems.map((item) => _buildKeyCard(context, item.key, type)),
      ],
    );
  }

  Widget _buildKeyCard(BuildContext context, String key, String type) {
    final formattedKey = controller.formatKey(key, type);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          )
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Expanded(
            child: Text(
              formattedKey,
              style: const TextStyle(fontSize: 16, color: Colors.black87),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          // Ações
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: const Icon(Icons.copy_rounded, color: Colors.grey),
                tooltip: 'Copiar',
                onPressed: () => controller.copyKeyToClipboard(key),
              ),
              IconButton(
                icon: const Icon(Icons.delete_outline_rounded,
                    color: Colors.redAccent),
                tooltip: 'Excluir',
                onPressed: () => _showDeleteConfirmation(context, key),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildCreateButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SizedBox(
        width: double.infinity,
        height: 50,
        child: ElevatedButton(
          onPressed: () => controller.goToAddKey(),
          style: ElevatedButton.styleFrom(
            backgroundColor: secondaryColor,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
            elevation: 2,
          ),
          child: Text(
            'pix_createNewKey'.tr,
            style: const TextStyle(
                color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.vpn_key_off_outlined, size: 64, color: Colors.grey),
          const SizedBox(height: 16),
          AppText.bodyLarge(context, 'pix_noKeys'.tr, color: Colors.grey),
          const SizedBox(height: 32),
          _buildCreateButton(context),
        ],
      ),
    );
  }

  void _showDeleteConfirmation(BuildContext context, String key) {
    CustomDialogs.showConfirmationDialog(
        content: 'pix_keyExclude'.tr,
        onConfirm: () => controller.deleteKey(key));
  }
}
