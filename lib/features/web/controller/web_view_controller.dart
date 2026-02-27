import 'dart:ui';
import 'package:app_flutter_miban4/core/config/log/logger.dart';
import 'package:flutter/foundation.dart';
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
    _initWebView();
  }

  void _initWebView() {
    final args = Get.arguments;
    String urlToLoad = '';

    if (args != null && args is Map) {
      urlToLoad = args['url'] ?? '';
      title.value = args['title'] ?? 'Detalhes';
    }

    if (urlToLoad.isEmpty) {
      urlToLoad = 'about:blank';
      Get.snackbar('Erro', 'Link inválido ou não encontrado.');
    }

    webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int p) => progress.value = p,
          onPageStarted: (String url) => isLoading.value = true,
          onPageFinished: (String url) => isLoading.value = false,
          onWebResourceError: (WebResourceError error) {
            isLoading.value = false;
            if (kDebugMode) {
              print('Erro WebView: ${error.description}');
            }
          },
          onNavigationRequest: (NavigationRequest request) {
            return NavigationDecision.navigate;
          },
        ),
      );

    try {
      webViewController.loadRequest(Uri.parse(urlToLoad));
    } catch (e, s) {
      AppLogger.I().error('Web View', e, s);
      if (kDebugMode) {
        print('Erro ao carregar URL: $e');
      }
    }
  }
}
