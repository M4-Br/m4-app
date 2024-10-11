import 'package:app_flutter_miban4/data/api/groups/groupStart.dart';
import 'package:app_flutter_miban4/ui/screens/home/groups/create_group/group_created.dart';
import 'package:get/get.dart';

class StartGroupController extends GetxController {
  var isLoading = false.obs;

  Future<void> startGroup(String id) async {
    try {
      isLoading(true);
      await groupStart(id).then((response) {
        if (response['message'] == 'success') {
          Get.off(() => const GroupCreated(),
              transition: Transition.rightToLeft);
        }
      });
    } catch (e) {
      throw Exception(e.toString());
    } finally {
      isLoading(false);
    }
  }
}
