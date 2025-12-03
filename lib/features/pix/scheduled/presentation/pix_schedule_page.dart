import 'package:app_flutter_miban4/core/config/app/app_colors.dart';
import 'package:app_flutter_miban4/core/helpers/extensions/strings.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_text.dart';
import 'package:app_flutter_miban4/features/geral/widgets/app_bar.dart';
import 'package:app_flutter_miban4/features/pix/scheduled/controller/pix_schedule_controller.dart';
import 'package:app_flutter_miban4/features/pix/scheduled/model/pix_schedule_response.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PixSchedulePage extends GetView<PixScheduleController> {
  const PixSchedulePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: CustomAppBar(
        title: 'pix_schedule_transfer'.tr,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
              child: CircularProgressIndicator(color: secondaryColor));
        }

        if (controller.scheduledPixList.isEmpty) {
          return _buildEmptyState(context);
        }

        return RefreshIndicator(
          onRefresh: controller.fetchScheduledPix,
          color: secondaryColor,
          child: ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: controller.scheduledPixList.length,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final pix = controller.scheduledPixList[index];
              return _buildPixCard(context, pix);
            },
          ),
        );
      }),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.event_busy, size: 64, color: Colors.grey.shade400),
          const SizedBox(height: 16),
          AppText.bodyLarge(
            context,
            controller.message.value.isNotEmpty
                ? controller.message.value
                : 'Nenhum Pix agendado',
            color: Colors.grey,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          TextButton.icon(
              onPressed: controller.fetchScheduledPix,
              icon: const Icon(Icons.refresh, color: secondaryColor),
              label: const Text('Tentar novamente',
                  style: TextStyle(color: secondaryColor)))
        ],
      ),
    );
  }

  Widget _buildPixCard(BuildContext context, PixScheduled pix) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: AppText.titleMedium(
                    context,
                    pix.counterpartyName,
                  ),
                ),
                const SizedBox(width: 8),
                AppText.titleMedium(
                  context,
                  pix.amount.toBRL(),
                  color: secondaryColor,
                ),
              ],
            ),
            const SizedBox(height: 12),
            const Divider(height: 1, color: Colors.black12),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText.bodySmall(context, 'Data', color: Colors.grey),
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        const Icon(Icons.calendar_today,
                            size: 14, color: Colors.black54),
                        const SizedBox(width: 4),
                        AppText.bodyMedium(context, pix.pixDate),
                      ],
                    ),
                  ],
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                      color: controller
                          .getStatusColor(pix.status)
                          .withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                          color: controller
                              .getStatusColor(pix.status)
                              .withOpacity(0.5))),
                  child: AppText.bodySmall(
                    context,
                    pix.status,
                    color: controller.getStatusColor(pix.status),
                  ),
                ),
              ],
            ),
            if (pix.occurrence.isNotEmpty) ...[
              const SizedBox(height: 8),
              AppText.bodySmall(
                context,
                'Recorrência: ${pix.occurrence}',
                color: Colors.grey.shade600,
              ),
            ]
          ],
        ),
      ),
    );
  }
}
