import 'package:app_flutter_miban4/data/api/groups/accept_invite.dart';
import 'package:app_flutter_miban4/ui/screens/home/groups/group_screen.dart';
import 'package:get/get.dart';

class InviteGroupController extends GetxController {
  var isLoading = false.obs;

  Future<void> enterGroup(String id, String type) async {
    isLoading(true);

    try {
      final Map<String, dynamic> response = await acceptRejectGroup(id, type);
      if (response['status'].toString().isNotEmpty) {
        Get.off(() => const GroupsScreen(), transition: Transition.rightToLeft);
      }
    } catch (error) {
      throw Exception(error.toString());
    } finally {
      isLoading(false);
    }
  }
}
