import 'package:app_flutter_miban4/ui/colors/app_colors.dart';
import 'package:app_flutter_miban4/ui/components/appBar/appBar_components.dart';
import 'package:app_flutter_miban4/ui/controllers/qrcode/qrcode_controller.dart';
import 'package:app_flutter_miban4/ui/screens/home/home_view_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class QrcodeScreen extends StatefulWidget {
  const QrcodeScreen({super.key});

  @override
  State<QrcodeScreen> createState() => _QrcodeScreenState();
}

class _QrcodeScreenState extends State<QrcodeScreen> {
  final QrcodeController _qrcodeController = Get.put(QrcodeController());

  @override
  void initState() {
    super.initState();
    _scanCode();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarDefault(
        title: 'PIX',
        backPage: () => Get.off(() => const HomeViewPage(),
            transition: Transition.leftToRight),
      ),
      body: Obx(() {
        return _qrcodeController.isLoading.value == true
            ? const Center(
                child: CircularProgressIndicator(
                  color: primaryColor,
                ),
              )
            : Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.qr_code_error,
                      style: const TextStyle(color: Colors.black, fontSize: 18),
                    ),
                    const Spacer(),
                    SizedBox(
                      height: 45,
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () => _scanCode(),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: secondaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(45),
                          ),
                        ),
                        child: Text(
                          AppLocalizations.of(context)!.qr_code_try_again,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 16),
                        ),
                      ),
                    )
                  ],
                ),
              );
      }),
    );
  }

  Future<void> _scanCode() async {
    try {
      await _qrcodeController.scanQrCode();
    } catch (error) {
      throw Exception(error);
    }
  }
}
