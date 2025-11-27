import 'package:app_flutter_miban4/core/helpers/extensions/strings.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_button.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_text.dart';
import 'package:app_flutter_miban4/features/profile/controller/plans_controller.dart';
import 'package:app_flutter_miban4/features/profile/model/plans_response.dart';
import 'package:app_flutter_miban4/ui/config/theme_app.dart';
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
          'account_plans'.tr,
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
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(
              color: secondaryColor,
            ),
          );
        }

        if (controller.plans.value != null) {
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

  Widget _buildPlansList(UserPlansResponse plans) {
    return ListView.builder(
      itemCount: plans.servicePlan.products.length,
      itemBuilder: (context, index) {
        final plan = plans.servicePlan.products[index];
        return Column(
          children: [
            Container(
              color: thirdColor,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          plans.servicePlan.name,
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                        Text(
                          '${'plan_date'.tr} ${plans.servicePlan.renewDate}',
                          style: const TextStyle(color: Colors.white),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          'plan_actual'.tr,
                          style: const TextStyle(color: Colors.white),
                        ),
                        Text(
                          plans.servicePlan.monthlyPayment.toBRL(),
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
            ListTile(
              title: Text(
                plan.type,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          '${plans.servicePlan.data[index].remainingFree.toString()} ${'available_plan'.tr}'),
                      Text(
                          '${plans.servicePlan.data[index].free.toString()} ${'plan_total'.tr}')
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('plan_add'.tr),
                      Text(plans.servicePlan.data[index].fee.toBRL()),
                    ],
                  ),
                ],
              ),
              onTap: () {},
            ),
            Divider(
              thickness: 0.2,
              color: Colors.grey.shade800,
            ),
          ],
        );
      },
    );
  }
}
