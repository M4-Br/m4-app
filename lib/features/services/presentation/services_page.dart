import 'package:app_flutter_miban4/core/config/app/app_colors.dart';
import 'package:app_flutter_miban4/core/helpers/extensions/numbers.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_text.dart';
import 'package:app_flutter_miban4/features/geral/widgets/app_bar.dart';
import 'package:app_flutter_miban4/features/services/controller/services_controller.dart';
import 'package:app_flutter_miban4/features/services/model/services_response.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ServicesPage extends GetView<ServicesController> {
  const ServicesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: 'services_title'.tr,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
              child: CircularProgressIndicator(color: secondaryColor));
        }

        final response = controller.serviceResponse.value;
        final List data = response != null ? response.data : [];

        if (data.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.layers_clear_outlined,
                    size: 64, color: Colors.grey.shade300),
                const SizedBox(height: 16),
                AppText.bodyLarge(context, 'Nenhum serviço encontrado',
                    color: Colors.grey),
              ],
            ),
          );
        }

        // Lista
        return RefreshIndicator(
          onRefresh: controller.fetchServices,
          color: secondaryColor,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(vertical: 8),
            itemCount: data.length,
            separatorBuilder: (context, index) =>
                const Divider(height: 1, indent: 70),
            itemBuilder: (context, index) {
              final item = data[index];
              return _buildServiceTile(context, item);
            },
          ),
        );
      }),
    );
  }

  Widget _buildServiceTile(BuildContext context, ServicesData item) {
    final description = item.description;
    final tradeName = item.company.name;
    final value = item.value;

    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      leading: Container(
        height: 45,
        width: 45,
        decoration: BoxDecoration(
          color: secondaryColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Icon(Icons.receipt_long_outlined, color: secondaryColor),
      ),
      title: AppText.bodyMedium(context, description),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: 4.0),
        child: Text(
          'Empresa: $tradeName',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
      ),
      trailing: AppText.bodyMedium(
        context,
        value.toBRL(),
        color: Colors.black87,
      ),
      onTap: () {},
    );
  }
}
