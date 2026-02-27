import 'package:app_flutter_miban4/core/config/routes/app_routes.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_content.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_loading.dart';
import 'package:app_flutter_miban4/features/geral/widgets/app_bar.dart';
import 'package:app_flutter_miban4/features/geral/widgets/body_page.dart';
import 'package:app_flutter_miban4/features/offers/controller/offers_controller.dart';
import 'package:app_flutter_miban4/features/offers/model/offers_response.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class OffersPage extends GetView<OffersController> {
  const OffersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(title: 'services_title'.tr.toUpperCase()),
      body: CustomPageBody(
        enableIntrinsicHeight: false,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        children: [
          Obx(() {
            if (controller.isLoading.value) {
              return const Center(
                  child: Padding(
                padding: EdgeInsets.only(top: 50),
                child: AppLoading(),
              ));
            }

            if (controller.offersList.isEmpty) {
              return _buildEmptyState(context);
            }

            return ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: controller.offersList.length,
              separatorBuilder: (_, __) => const SizedBox(height: 16),
              itemBuilder: (context, index) {
                final offer = controller.offersList[index];
                return _buildOfferBanner(context, offer, index);
              },
            );
          }),
        ],
      ),
    );
  }

  Widget _buildOfferBanner(BuildContext context, OfferModel offer, int index) {
    final cleanTitle =
        offer.title?.replaceAll(RegExp(r'\s*\(.*?\)'), '') ?? 'Oferta';

    final color = _getBannerColor(index);

    final firstItem =
        offer.offerItems?.isNotEmpty == true ? offer.offerItems!.first : null;

    final price =
        firstItem?.offerPrice != null ? (firstItem!.offerPrice! / 100) : 0.00;

    final originalPrice = firstItem?.originalPrice != null
        ? (firstItem!.originalPrice! / 100)
        : 0.00;

    return GestureDetector(
      onTap: () => _openOfferUrl(firstItem?.offerUrl, cleanTitle),
      child: Container(
        height: 140,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.4),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Stack(
          children: [
            Positioned(
              right: -20,
              top: -20,
              child: CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.white.withValues(alpha: 0.1)),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        cleanTitle,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      if (offer.endDate != null)
                        Text(
                          "Válido até ${DateFormat('dd/MM').format(offer.endDate!)}",
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.9),
                            fontSize: 12,
                          ),
                        ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (originalPrice > 0)
                            Text(
                              "De R\$ ${originalPrice.toStringAsFixed(2).replaceAll('.', ',')}",
                              style: TextStyle(
                                color: Colors.white.withValues(alpha: 0.7),
                                decoration: TextDecoration.lineThrough,
                                decorationColor: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                          Text(
                            "Por R\$ ${price.toStringAsFixed(2).replaceAll('.', ',')}",
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(Icons.arrow_forward,
                            color: Colors.white),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getBannerColor(int index) {
    final colors = [
      const Color(0xFF5E35B1),
      const Color(0xFF00897B),
      const Color(0xFFE65100),
      const Color(0xFF1E88E5),
      const Color(0xFFC2185B),
    ];
    return colors[index % colors.length];
  }

  void _openOfferUrl(String? url, String title) {
    if (url != null && url.isNotEmpty) {
      _openWebView(url, title);
    } else {
      Get.snackbar(
        'Aviso',
        'Link da oferta indisponível no momento.',
        backgroundColor: Colors.orange,
        colorText: Colors.white,
      );
    }
  }

  void _openWebView(String url, String title) {
    Get.toNamed(AppRoutes.webView, arguments: {'url': url, 'title': title});
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: context.mq.size.height * 0.3),
          const Icon(Icons.local_offer_outlined, size: 60, color: Colors.grey),
          Center(
            child: Text(
              'Nenhuma oferta disponível.',
              style: TextStyle(color: Colors.grey[600], fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
