import 'package:app_flutter_miban4/core/helpers/controller/base_controller.dart';
import 'package:app_flutter_miban4/features/newsletter/model/newsletter_model.dart';
import 'package:app_flutter_miban4/features/newsletter/repository/newsletter_repository.dart';
import 'package:get/get.dart';

class NewsletterController extends BaseController {
  final NewsletterRepository _repository = NewsletterRepository();

  final RxList<NewsletterModel> newsList = <NewsletterModel>[].obs;

  final RxString selectedSourceFilter = 'Todas'.obs;
  final RxString selectedCategoryFilter = 'Todas'.obs;

  @override
  void onInit() {
    super.onInit();
    fetchNewsFromApi();
  }

  Future<void> fetchNewsFromApi() async {
    await executeSafe(() async {
      newsList.clear();

      String query = 'economia OR negócios OR MEI OR empreendedorismo';
      String categoryName = 'Destaque';

      if (selectedCategoryFilter.value != 'Todas') {
        query = selectedCategoryFilter.value;
        categoryName = selectedCategoryFilter.value;
      }

      final results = await _repository.fetchNews(query, categoryName);

      newsList.assignAll(results);
    }, message: 'Erro ao buscar as notícias na internet.');
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
}
