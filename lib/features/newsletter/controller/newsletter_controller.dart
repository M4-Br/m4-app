import 'package:app_flutter_miban4/core/config/log/logger.dart';
import 'package:app_flutter_miban4/core/config/routes/app_routes.dart';
import 'package:app_flutter_miban4/core/helpers/controller/base_controller.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_dialogs.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_toaster.dart';
import 'package:app_flutter_miban4/features/newsletter/model/newsletter_model.dart';
import 'package:app_flutter_miban4/features/newsletter/repository/newsletter_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsletterController extends BaseController {
  final NewsletterRepository _repository = NewsletterRepository();

  final RxList<NewsletterModel> newsList = <NewsletterModel>[].obs;
  final RxBool isFilterLoading = false.obs;

  final RxString selectedSourceFilter = 'Todas'.obs;
  final RxString selectedCategoryFilter = 'Todas'.obs;

  @override
  void onInit() {
    super.onInit();
    fetchNewsFromApi(isInitial: true);
  }

  Future<void> fetchNewsFromApi({bool isInitial = false}) async {
    if (isInitial) {
      isLoading.value = true;
    } else {
      isFilterLoading.value = true;
    }

    try {
      String query = 'economia OR negócios OR MEI OR empreendedorismo';
      String categoryName = 'Destaque';

      if (selectedCategoryFilter.value != 'Todas') {
        query = selectedCategoryFilter.value;
        categoryName = selectedCategoryFilter.value;
      }

      final results = await _repository.fetchNews(query, categoryName);

      if (results.isNotEmpty) {
        newsList.assignAll(results);
      } else if (isInitial) {
        newsList.clear();
      }
    } catch (e, s) {
      AppLogger.I().error('Erro ao buscar notícias', e, s);
      if (isInitial) {
        ShowToaster.toasterInfo(
            message: 'Não foi possível carregar as notícias.', isError: true);
      }
    } finally {
      isLoading.value = false;
      isFilterLoading.value = false;
    }
  }

  void setSourceFilter(String source) {
    selectedSourceFilter.value = source;
  }

  void setCategoryFilter(String category) {
    if (selectedCategoryFilter.value != category) {
      selectedCategoryFilter.value = category;
      fetchNewsFromApi();
    }
  }

  Future<void> openNews(NewsletterModel news) async {
    final String url = news.url;
    final String title = news.title;

    if (url.isEmpty) {
      ShowToaster.toasterInfo(
          message: 'Link da notícia indisponível.', isError: true);
      return;
    }

    CustomDialogs.showConfirmationDialog(
      title: 'Serviço Externo',
      content:
          'Você está acessando um serviço externo e a Yooconn não se responsabiliza pelos dados fornecidos.',
      confirmText: 'Acessar',
      cancelText: 'Cancelar',
      onConfirm: () async {
        Get.back();
        if (kIsWeb) {
          final uri = Uri.parse(url);
          if (await canLaunchUrl(uri)) {
            await launchUrl(uri, mode: LaunchMode.externalApplication);
          }
        } else {
          Get.toNamed(AppRoutes.webView, arguments: {
            'url': url,
            'title': title,
          });
        }
      },
    );
  }
}
