import 'package:app_flutter_miban4/data/model/plans/plans_model.dart';
import 'package:app_flutter_miban4/ui/config/theme_app.dart';
import 'package:app_flutter_miban4/ui/controllers/plans/plans_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class PlansPage extends StatefulWidget {
  const PlansPage({super.key});

  @override
  State<PlansPage> createState() => _PlansPageState();
}

class _PlansPageState extends State<PlansPage> {
  final _plansController = Get.put(PlansController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'account_plans'.tr,
          style: const TextStyle(color: Colors.white, fontSize: 16),
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
      body: FutureBuilder<PlansModel>(
        future: _plansController.getPlan(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: secondaryColor,
              ),
            );
          } else if (snapshot.hasError) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Get.defaultDialog(
                title: 'dialogErro'.tr,
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('dialog_someError'.tr),
                    ElevatedButton(
                      onPressed: () => Get.back(),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: secondaryColor,
                      ),
                      child: const Text(
                        'OK',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              );
            });
            return const SizedBox.shrink();
          } else if (snapshot.hasData) {
            final data = snapshot.data!;
            return _buildPlansList(data);
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }

  Widget _buildPlansList(PlansModel plans) {
    final currencyFormat =
        NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$');
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
                          currencyFormat.format(double.parse(
                                  plans.servicePlan.monthlyPayment.toString()) /
                              100),
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
                plan.typeDescription,
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
                      Text(
                        currencyFormat.format(double.parse(
                                plans.servicePlan.data[index].fee.toString()) /
                            100),
                      )
                    ],
                  ),
                ],
              ),
              onTap: () {
                // Adicione ações aqui, se necessário
              },
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
