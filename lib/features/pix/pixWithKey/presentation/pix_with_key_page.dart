import 'package:app_flutter_miban4/core/config/app/app_colors.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_button.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_dimens.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_text.dart';
import 'package:app_flutter_miban4/features/geral/widgets/app_bar.dart';
import 'package:app_flutter_miban4/features/geral/widgets/body_page.dart';
import 'package:app_flutter_miban4/features/pix/pixWithKey/controller/pix_with_key_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PixWithKeyPage extends GetView<PixWithKeyController> {
  const PixWithKeyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: 'pix_withKey'.tr,
        onBackPressed: controller.backToHome,
      ),
      body: CustomPageBody(
        padding: const EdgeInsets.all(AppDimens.kDefaultPadding),
        children: [
          const SizedBox(height: 16),
          Center(
            child: AppText.titleMedium(
              context,
              'pix_addReceiverKey'.tr,
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 32),
          TextField(
            controller: controller.keyController,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            inputFormatters: [controller.smartMaskFormatter],
            keyboardType: TextInputType.visiblePassword,
            decoration: const InputDecoration(
              labelText: 'Chave Pix',
              hintText: 'CPF, Email, Telefone ou Aleatória',
              hintStyle: TextStyle(fontSize: 16, color: Colors.grey),
              border: UnderlineInputBorder(),
              labelStyle: TextStyle(color: Colors.black54),
            ),
          ),
          const SizedBox(height: 8),
          Obx(() => Align(
                alignment: Alignment.centerLeft,
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 300),
                  opacity:
                      controller.detectedLabel.value.isNotEmpty ? 1.0 : 0.0,
                  child: Text(
                    controller.detectedLabel.value,
                    style: const TextStyle(
                        color: secondaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 14),
                  ),
                ),
              )),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            height: 45,
            child: Obx(
              () => AppButton(
                onPressed: () async {
                  controller.isButtonEnabled.value
                      ? controller.searchKey()
                      : null;
                },
                labelText: 'pix_search'.tr,
                color: controller.buttonColor,
                isLoading: controller.isLoading.value,
              ),
            ),
          ),
          const SizedBox(height: 40),
          const Text('Meus Favoritos',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          const SizedBox(height: 16),
          Obx(() {
            if (controller.fav.isLoading.value) {
              return const Center(
                  child: Padding(
                padding: EdgeInsets.all(20),
                child: CircularProgressIndicator(color: secondaryColor),
              ));
            }

            if (controller.fav.favoritesList.isEmpty) {
              return Container(
                padding: const EdgeInsets.all(16),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(12)),
                child: const Text(
                  'Você ainda não possui favoritos salvos.',
                  style: TextStyle(color: Colors.grey),
                ),
              );
            }

            return Column(
              children: controller.fav.favoritesList.map((item) {
                return Column(
                  children: [
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: CircleAvatar(
                        backgroundColor: secondaryColor.withValues(alpha: 0.1),
                        child: Text(
                            item.nickname.isNotEmpty
                                ? item.nickname[0].toUpperCase()
                                : '?',
                            style: const TextStyle(
                                color: secondaryColor,
                                fontWeight: FontWeight.bold)),
                      ),
                      title: Text(item.nickname,
                          style: const TextStyle(fontWeight: FontWeight.w600)),
                      subtitle: Text(item.fullName,
                          maxLines: 1, overflow: TextOverflow.ellipsis),
                      trailing:
                          const Icon(Icons.chevron_right, color: Colors.grey),
                      onTap: () => controller.onFavoriteSelected(item),
                    ),
                    const Divider(height: 1),
                  ],
                );
              }).toList(),
            );
          }),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}
