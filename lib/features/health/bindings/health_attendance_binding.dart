import 'package:app_flutter_miban4/features/health/controller/health_attendance_controller.dart';
import 'package:get/get.dart';

class HealthAttendanceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HealthAttendanceController>(() => HealthAttendanceController());
  }
}
