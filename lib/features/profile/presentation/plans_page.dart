import 'package:app_flutter_miban4/core/config/app/app_colors.dart';
import 'package:app_flutter_miban4/core/helpers/extensions/numbers.dart'; // Corrigido para extensão de Double/BRL
import 'package:app_flutter_miban4/core/helpers/utils/app_button.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_text.dart';
import 'package:app_flutter_miban4/features/profile/controller/plans_controller.dart';
import 'package:app_flutter_miban4/features/profile/model/plans_response.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PlansPage extends GetView<PlansController> {
  const PlansPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: AppText.titleLarge(
          context,
          'PACOTES',
          color: Colors.white,
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
        if (controller.isLoading.value && controller.plans.value == null) {
          return const Center(
            child: CircularProgressIndicator(
              color: secondaryColor,
            ),
          );
        }

        if (controller.plans.value != null &&
            controller.plans.value!.isNotEmpty) {
          return _buildPlansList(controller.plans.value!);
        }

        return Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppText.bodyMedium(
                  context,
                  'plans_empty'.tr,
                ),
                const SizedBox(height: 16),
                AppButton(
                  buttonType: AppButtonType.elevated,
                  onPressed: controller.fetchPlansDetails,
                  labelText: 'try_again'.tr,
                )
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _buildPlansList(List<PlanItem> plansList) {
    return ListView.builder(
      itemCount: plansList.length,
      itemBuilder: (context, index) {
        final plan = plansList[index];

        return Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: Column(
            children: [
              Container(
                color: thirdColor,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              plan.description,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'plan_actual'.tr,
                            style: const TextStyle(color: Colors.white),
                          ),
                          Text(
                            plan.monthlyPayment.toPlanValue(),
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                          Text(
                            'plan_monthly'.tr,
                            style: const TextStyle(color: Colors.white),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
              if (plan.data.isEmpty)
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text('Nenhuma vantagem cadastrada neste plano.'),
                )
              else
                ...plan.data.map((dataItem) {
                  return Column(
                    children: [
                      ListTile(
                        title: Text(
                          dataItem.typeDescription,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('${dataItem.free} ${'plan_total'.tr}'),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text('plan_add'.tr),
                                Text(dataItem.fee.toPlanValue()),
                              ],
                            ),
                          ],
                        ),
                        onTap: () {},
                      ),
                      Divider(
                        thickness: 0.2,
                        color: Colors.grey.shade800,
                        height: 1,
                      ),
                    ],
                  );
                }),
            ],
          ),
        );
      },
    );
  }
}
