import 'package:app_flutter_miban4/core/config/app/app_colors.dart';
import 'package:app_flutter_miban4/features/geral/widgets/app_bar.dart';
import 'package:app_flutter_miban4/features/web/controller/web_view_controller.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebviewPage extends GetView<WebviewController> {
  const WebviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: controller.title.string),
      body: Stack(
        children: [
          WebViewWidget(controller: controller.webViewController),
          Obx(() {
            if (controller.isLoading.value && controller.progress.value < 100) {
              return LinearProgressIndicator(
                value: controller.progress.value / 100,
                backgroundColor: Colors.transparent,
                color: secondaryColor,
                minHeight: 4,
              );
            }
            return const SizedBox.shrink();
          }),
        ],
      ),
    );
  }
}
