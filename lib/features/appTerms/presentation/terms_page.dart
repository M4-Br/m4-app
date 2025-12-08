import 'package:app_flutter_miban4/core/config/app/app_colors.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_dimens.dart';
import 'package:app_flutter_miban4/features/appTerms/controller/terms_controller.dart';
import 'package:app_flutter_miban4/features/geral/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_html_css/simple_html_css.dart';

class TermsPage extends GetView<TermsController> {
  const TermsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(
        title: 'Termos de Uso',
        backgroundColor: Colors.white,
        iconColor: Colors.black,
      ),
      body: SafeArea(
        child: Obx(() {
          // 1. Loading
          if (controller.isLoading.value) {
            return const Center(
              child: CircularProgressIndicator(color: secondaryColor),
            );
          }

          if (controller.termsHtmlContent.isEmpty) {
            return const Center(
              child: Text('Não foi possível carregar os termos de uso'),
            );
          }

          return Builder(
            builder: (context) {
              try {
                final Widget htmlContent = HTML.toRichText(
                  context,
                  controller.termsHtmlContent.value,
                  linksCallback: (link) {},
                  defaultTextStyle: const TextStyle(
                    color: Colors.black87,
                    fontSize: 16,
                    height: 1.5,
                  ),
                );

                return SingleChildScrollView(
                  padding: const EdgeInsets.all(AppDimens.kDefaultPadding),
                  child: htmlContent,
                );
              } catch (e) {
                return const Center(child: Text('Erro ao renderizar HTML'));
              }
            },
          );
        }),
      ),
    );
  }
}
