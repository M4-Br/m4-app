import 'package:app_flutter_miban4/core/config/app/app_colors.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_text.dart';
import 'package:app_flutter_miban4/features/store/controller/store_controller.dart';
import 'package:app_flutter_miban4/features/store/model/store_response.dart';
import 'package:app_flutter_miban4/features/geral/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StorePage extends GetView<StoreController> {
  const StorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(
        title: 'Lojas Parceiras',
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
              child: CircularProgressIndicator(color: secondaryColor));
        }

        if (controller.storeList.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.storefront_outlined,
                    size: 64, color: Colors.grey.shade300),
                const SizedBox(height: 16),
                AppText.bodyLarge(context, 'Nenhuma loja encontrada',
                    color: Colors.grey),
              ],
            ),
          );
        }

        return RefreshIndicator(
          onRefresh: controller.getMerchants,
          color: secondaryColor,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(vertical: 12),
            itemCount: controller.storeList.length,
            separatorBuilder: (context, index) =>
                const Divider(height: 1, indent: 80),
            itemBuilder: (context, index) {
              final store = controller.storeList[index];
              return _buildStoreTile(context, store);
            },
          ),
        );
      }),
    );
  }

  Widget _buildStoreTile(BuildContext context, StoreResponse store) {
    return ListTile(
      onTap: () => controller.onStoreTap(store),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      leading: Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.network(
            store.merchantIcon,
            fit: BoxFit.cover,
            errorBuilder: (c, e, s) =>
                const Icon(Icons.store, color: secondaryColor),
          ),
        ),
      ),
      title: AppText.bodyMedium(
        context,
        store.merchantName,
        color: Colors.black87,
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 4),
          Row(
            children: [
              Icon(Icons.label_outline, size: 14, color: Colors.grey.shade600),
              const SizedBox(width: 4),
              Text(
                store.merchantCategory.toUpperCase(),
                style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade600,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 2),
          // Descrição
          Text(
            store.merchantDescription,
            style: TextStyle(fontSize: 12, color: Colors.grey.shade500),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
      trailing: const Icon(Icons.chevron_right, color: Colors.grey),
    );
  }
}
