import 'package:app_flutter_miban4/ui/config/theme_app.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebviewPage extends StatefulWidget {
  const WebviewPage({super.key, required this.url, required this.pageTitle});
  final String url;
  final String pageTitle;

  @override
  State<WebviewPage> createState() => _WebviewPageState();
}

class _WebviewPageState extends State<WebviewPage> {
  final controller = WebViewController();

  @override
  void initState() {
    controller.setJavaScriptMode(JavaScriptMode.unrestricted);
    controller.loadRequest(Uri.parse(widget.url));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        centerTitle: true,
        title: Text(
          widget.pageTitle,
          style: const TextStyle(color: Colors.white),
        ),
        leading: IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(
              Icons.arrow_back_ios_outlined,
              color: Colors.white,
            )),
      ),
      body: WebViewWidget(controller: controller),
    );
  }
}
