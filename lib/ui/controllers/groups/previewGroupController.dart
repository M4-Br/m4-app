import 'package:app_flutter_miban4/data/api/groups/getGroupData.dart';
import 'package:get/get.dart';

class PreviewGroupController extends GetxController {
  var isLoading = false.obs;
  Rx<Map<String, dynamic>?> groupResponse = Rx<Map<String, dynamic>?>(null);

  Future<void> previewGroup(String id) async {
    isLoading(true);

    try {
      final Map<String, dynamic> response = await getGroupData(id);

      if (response['data']['id'].toString().isNotEmpty) {
        groupResponse.value = response;
      } else {
        print(response.toString());
      }
    } catch (e) {
      isLoading(false);
    } finally {
      isLoading(false);
    }
  }
}
