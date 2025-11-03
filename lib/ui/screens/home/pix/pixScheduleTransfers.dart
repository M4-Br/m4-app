import 'package:app_flutter_miban4/data/model/pix/pixScheduled.dart';
import 'package:app_flutter_miban4/ui/controllers/pix/pix_scheduled.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../colors/app_colors.dart';

class PixScheduleTransfers extends StatefulWidget {
  const PixScheduleTransfers({super.key});

  @override
  State<PixScheduleTransfers> createState() => _PixScheduleTransfersState();
}

class _PixScheduleTransfersState extends State<PixScheduleTransfers> {
  final controller = Get.put(PixScheduledController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'pix_schedule_transfer'.tr,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: primaryColor,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(
            Icons.arrow_back_ios_outlined,
            color: Colors.white,
          ),
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(color: secondaryColor),
          );
        }

        final pixList = controller.scheduledPixList;

        if (pixList.isEmpty) {
          return Center(
            child: Text(
              controller.message.value.isNotEmpty
                  ? controller.message.value
                  : 'Nenhum Pix agendado',
              style: const TextStyle(fontSize: 16, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
          );
        }

        return RefreshIndicator(
          onRefresh: controller.fetchScheduledPix,
          child: ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: pixList.length,
            itemBuilder: (context, index) {
              final pix = pixList[index];
              return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 3,
                margin: const EdgeInsets.symmetric(vertical: 8),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Nome e valor
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              pix.counterpartyName,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Text(
                            'R\$ ${pix.amount.toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: secondaryColor,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Data do Pix: ${pix.pixDate}',
                        style: const TextStyle(color: Colors.black54),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Situação: ${pix.status}',
                        style: TextStyle(
                          color: pix.occurrence == 'AGENDADO'
                              ? Colors.orange
                              : Colors.green,
                        ),
                      ),
                      const SizedBox(height: 4),
                      if (pix.status.isNotEmpty)
                        Text(
                          'Obs: ${pix.occurrence}',
                          style: const TextStyle(color: Colors.black54),
                        ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      }),
    );
  }
}
