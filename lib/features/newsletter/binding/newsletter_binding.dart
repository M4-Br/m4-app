import 'package:app_flutter_miban4/features/newsletter/controller/newsletter_controller.dart';
import 'package:get/get.dart';

class NewsletterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NewsletterController>(() => NewsletterController());
  }
}
