import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebviewController extends GetxController {
  late final WebViewController webViewController;
  final title = ''.obs;
  final isLoading = true.obs;
  final progress = 0.obs;

  @override
  void onInit() {
    super.onInit();
    _loadArguments();
    _initWebViewController();
  }

  void _loadArguments() {
    final args = Get.arguments;

    String url = '';

    if (args != null && args is Map<String, dynamic>) {
      url = args['url'] ?? '';
      title.value = args['title'] ?? '';
    }
    if (url.isNotEmpty) {}
  }

  void _initWebViewController() {
    final args = Get.arguments as Map<String, dynamic>?;
    final url = args?['url'] ?? 'https://google.com';
    webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int p) {
            progress.value = p;
          },
          onPageStarted: (String url) {
            isLoading.value = true;
          },
          onPageFinished: (String url) {
            isLoading.value = false;
          },
          onWebResourceError: (WebResourceError error) {
            // Pode adicionar log de erro aqui se quiser
            isLoading.value = false;
          },
        ),
      )
      ..loadRequest(Uri.parse(url));
  }
}
