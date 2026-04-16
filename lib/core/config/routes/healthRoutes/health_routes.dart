import 'package:app_flutter_miban4/core/config/auth/service/auth_guard.dart';
import 'package:app_flutter_miban4/core/config/routes/app_routes.dart';
import 'package:app_flutter_miban4/features/health/bindings/health_attendance_binding.dart';
import 'package:app_flutter_miban4/features/health/bindings/health_bindings.dart';
import 'package:app_flutter_miban4/features/health/bindings/health_plans_bionding.dart';
import 'package:app_flutter_miban4/features/health/bindings/health_scheduling_binding.dart';
import 'package:app_flutter_miban4/features/health/presentation/health_attendance_page.dart';
import 'package:app_flutter_miban4/features/health/presentation/health_home_page.dart';
import 'package:app_flutter_miban4/features/health/presentation/health_plans_page.dart';
import 'package:app_flutter_miban4/features/health/presentation/health_scheduling_page.dart';
import 'package:get/get.dart';

class HealthPages {
  static final List<GetPage> pages = [
    GetPage(
        name: AppRoutes.healthHome,
        page: () => HealthHomePage(),
        binding: HealthBinding(),
        middlewares: [AuthGuard()]),
    GetPage(
        name: AppRoutes.healthPlans,
        page: () => HealthPlansPage(),
        binding: HealthPlansBinding(),
        middlewares: [AuthGuard()]),
    GetPage(
        name: AppRoutes.healthAttendance,
        page: () => HealthAttendancePage(),
        binding: HealthAttendanceBinding(),
        middlewares: [AuthGuard()]),
    GetPage(
        name: AppRoutes.healthScheduling,
        page: () => HealthSchedulingPage(),
        binding: HealthSchedulingBinding(),
        middlewares: [AuthGuard()]),
  ];
}
