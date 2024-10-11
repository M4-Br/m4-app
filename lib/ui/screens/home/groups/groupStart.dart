import 'package:app_flutter_miban4/data/api/groups/groupStart.dart';
import 'package:app_flutter_miban4/ui/screens/home/groups/group_screen.dart';
import 'package:get/get.dart';

class GroupStartController extends GetxController {
  var isLoading = false.obs;

  Future<void> activeGroup(String id) async {
    isLoading(true);
    try {
      Map<String, dynamic> response = await groupStart(id);

      if (response['id'].toString().isNotEmpty) {
        Get.to(() => const GroupsScreen(), transition: Transition.rightToLeft);
      }
    } catch (e) {
      throw Exception(e.toString());
    } finally {
      isLoading(false);
    }
  }
}
