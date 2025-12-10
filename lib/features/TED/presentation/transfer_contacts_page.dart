import 'package:app_flutter_miban4/core/config/app/app_colors.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_dimens.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_text.dart';
import 'package:app_flutter_miban4/features/TED/controller/transfer_contacts_controller.dart';
import 'package:app_flutter_miban4/features/TED/model/transfer_contacts_model.dart';
import 'package:app_flutter_miban4/features/geral/widgets/app_bar.dart';
import 'package:app_flutter_miban4/features/geral/widgets/body_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TransferContactsPage extends GetView<TransferContactsController> {
  const TransferContactsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: 'transfer'.tr,
      ),
      body: CustomPageBody(
        padding:
            const EdgeInsets.symmetric(horizontal: AppDimens.kDefaultPadding),
        children: [
          const SizedBox(height: 24),
          AppText.titleLarge(
            context,
            'transfer_to'.tr,
            color: Colors.black87,
          ),
          const SizedBox(height: 24),
          _buildNewContactButton(context),
          const SizedBox(height: 24),
          const Divider(),
          Obx(() {
            if (controller.isLoading.value) {
              return const Center(
                  child: CircularProgressIndicator(color: secondaryColor));
            }

            if (controller.contacts.isEmpty) {
              return _buildEmptyState(context);
            }
            return Column(
              children: List.generate(controller.contacts.length, (index) {
                final contact = controller.contacts[index];

                return Column(
                  children: [
                    if (index > 0) const Divider(height: 1),
                    _buildContactTile(context, contact, index),
                  ],
                );
              }),
            );
          }),
          // ----------------------
        ],
      ),
    );
  }

  Widget _buildNewContactButton(BuildContext context) {
    return InkWell(
      onTap: controller.goToNewContact,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: secondaryColor.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.add, color: secondaryColor),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText.titleMedium(
                    context,
                    'transfer_new_contact'.tr,
                  ),
                  AppText.bodySmall(context, 'CPF/CNPJ, Agência e Conta',
                      color: Colors.grey),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: Colors.grey),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40),
      child: Center(
        child: Column(
          children: [
            Icon(Icons.people_outline, size: 64, color: Colors.grey.shade300),
            const SizedBox(height: 16),
            AppText.bodyLarge(context, 'transfer_noOne'.tr, color: Colors.grey),
          ],
        ),
      ),
    );
  }

  Widget _buildContactTile(
      BuildContext context, TransferContactsModel contact, int index) {
    String subtitle = contact.document ?? '';
    if (subtitle.isEmpty && contact.accountNumber != null) {
      subtitle = 'Conta: ${contact.accountNumber}';
    }

    return Dismissible(
      key: Key(contact.hashCode.toString()),
      direction: DismissDirection.endToStart,
      background: Container(
        color: Colors.redAccent,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 16),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      onDismissed: (direction) {
        controller.removeContact(index);
      },
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        onTap: () => controller.onContactSelected(contact),
        leading: CircleAvatar(
          backgroundColor: Colors.grey.shade200,
          child: Text(
            (contact.name != null && contact.name!.isNotEmpty)
                ? contact.name![0].toUpperCase()
                : '?',
            style: const TextStyle(
                fontWeight: FontWeight.bold, color: Colors.black54),
          ),
        ),
        title: AppText.bodyMedium(
          context,
          contact.name ?? 'Sem Nome',
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        trailing: const Icon(Icons.chevron_right, color: Colors.grey),
      ),
    );
  }
}
