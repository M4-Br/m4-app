import 'package:app_flutter_miban4/ui/colors/app_colors.dart';
import 'package:app_flutter_miban4/ui/controllers/services/services_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ServicesPage extends StatelessWidget {
  const ServicesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ServicesController());

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "services_title".tr,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: primaryColor,
        leading: BackButton(
          onPressed: () => Get.back(),
          color: Colors.white,
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(color: secondaryColor),
          );
        }

        final service = controller.service.value;

        if (service == null || service.data.isEmpty) {
          return const Center(child: Text("Nenhum serviço encontrado"));
        }

        return ListView.separated(
          separatorBuilder: (context, index) => const Divider(),
          itemCount: service.data.length,
          itemBuilder: (context, index) {
            final item = service.data[index];
            return ListTile(
              title: Text(item.description),
              subtitle: Text("Empresa: ${item.company.tradeName}"),
              trailing: Text("R\$ ${(item.value / 100).toStringAsFixed(2)}"),
            );
          },
        );
      }),
    );
  }
}
