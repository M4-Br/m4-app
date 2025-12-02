import 'package:app_flutter_miban4/core/config/app/app_colors.dart';
import 'package:app_flutter_miban4/core/helpers/extensions/strings.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_dimens.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_loading.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_text.dart';
import 'package:app_flutter_miban4/features/geral/widgets/app_bar.dart';
import 'package:app_flutter_miban4/features/geral/widgets/body_page.dart';
import 'package:app_flutter_miban4/features/pix/limits/controller/pix_limits_controller.dart';
import 'package:app_flutter_miban4/features/pix/limits/model/pix_limits_response.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PixLimitsPage extends GetView<PixLimitsController> {
  const PixLimitsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'pix_myLimits'.tr,
      ),
      body: Obx(() {
        if (controller.isLoading.value && controller.pixLimits.value == null) {
          return const Center(child: AppLoading());
        }

        final response = controller.pixLimits.value;

        if (response == null || !response.success || response.data.isEmpty) {
          return Center(
              child: AppText.bodyLarge(context, 'Nenhum limite encontrado.'));
        }

        return CustomPageBody(
          padding: const EdgeInsets.all(AppDimens.kDefaultPadding),
          children: response.data.map((limit) {
            return _buildLimitCard(
              context,
              limitData: limit,
            );
          }).toList(),
        );
      }),
    );
  }

  Widget _buildLimitCard(BuildContext context, {required LimitData limitData}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: AppText.titleMedium(
            context,
            limitData.limitDescription,
            color: Colors.black54,
          ),
        ),
        Card(
          elevation: 2,
          color: Colors.grey.shade100,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Icon(_getIconForType(limitData.limitType),
                    color: primaryColor, size: 28),
                const SizedBox(width: 16),
                Expanded(
                  child: AppText.headlineSmall(
                    context,
                    limitData.accountLimit.toBRL(),
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
      ],
    );
  }

  IconData _getIconForType(String type) {
    switch (type.toUpperCase()) {
      case 'P2P':
        return Icons.person_outline;
      case 'P2B':
        return Icons.store_outlined;
      case 'SAME_OWNERSHIP':
        return Icons.person_pin_circle_outlined;
      case 'NIGHT':
        return Icons.nights_stay_outlined;
      default:
        return Icons.attach_money;
    }
  }
}
