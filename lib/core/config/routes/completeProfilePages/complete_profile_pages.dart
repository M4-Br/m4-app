import 'package:app_flutter_miban4/core/config/auth/service/auth_guard.dart';
import 'package:app_flutter_miban4/core/config/routes/app_routes.dart';
import 'package:app_flutter_miban4/features/completeProfile/bindings/complete_profile_address_bindings.dart';
import 'package:app_flutter_miban4/features/completeProfile/bindings/complete_profile_document_choose_bindings.dart';
import 'package:app_flutter_miban4/features/completeProfile/bindings/complete_profile_document_photo_bindings.dart';
import 'package:app_flutter_miban4/features/completeProfile/bindings/complete_profile_personal_data_bindings.dart';
import 'package:app_flutter_miban4/features/completeProfile/bindings/complete_profile_profession_bindings.dart';
import 'package:app_flutter_miban4/features/completeProfile/bindings/complete_profile_review_bindings.dart';
import 'package:app_flutter_miban4/features/completeProfile/bindings/complete_profile_selfie_bindings.dart';
import 'package:app_flutter_miban4/features/completeProfile/bindings/complete_profile_selfie_confirm_bindings.dart';
import 'package:app_flutter_miban4/features/completeProfile/bindings/complete_profile_selfie_document_bindings.dart';
import 'package:app_flutter_miban4/features/completeProfile/presentation/complete_profile_address_page.dart';
import 'package:app_flutter_miban4/features/completeProfile/presentation/complete_profile_document_choose_page.dart';
import 'package:app_flutter_miban4/features/completeProfile/presentation/complete_profile_document_photo_page.dart';
import 'package:app_flutter_miban4/features/completeProfile/presentation/complete_profile_document_selfie_page.dart';
import 'package:app_flutter_miban4/features/completeProfile/presentation/complete_profile_personal_data_page.dart';
import 'package:app_flutter_miban4/features/completeProfile/presentation/complete_profile_profession_page.dart';
import 'package:app_flutter_miban4/features/completeProfile/presentation/complete_profile_review_page.dart';
import 'package:app_flutter_miban4/features/completeProfile/presentation/complete_profile_selfie_confirm_page.dart';
import 'package:app_flutter_miban4/features/completeProfile/presentation/complete_profile_selfie_page.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

class CompletePropfilePages {
  static final List<GetPage> pages = [
    GetPage(
        name: AppRoutes.completeAddress,
        page: () => const CompleteProfileAddressPage(),
        binding: CompleteProfileAddressBindings(),
        middlewares: [AuthGuard()]),
    GetPage(
        name: AppRoutes.completeProfession,
        page: () => const CompleteProfileProfessionPage(),
        binding: CompleteProfileProfessionBindings(),
        middlewares: [AuthGuard()]),
    GetPage(
        name: AppRoutes.completePersonalData,
        page: () => const CompleteProfilePersonalDataPage(),
        binding: CompleteProfilePersonalDataBinding(),
        middlewares: [AuthGuard()]),
    GetPage(
        name: AppRoutes.completeDocumentChoose,
        page: () => const CompleteProfileDocumentChoosePage(),
        binding: CompleteProfileDocumentChooseBindings(),
        middlewares: [AuthGuard()]),
    GetPage(
        name: AppRoutes.completeDocumentPhoto,
        page: () => const CompleteProfileDocumentPhotoPage(),
        binding: CompleteProfileDocumentPhotoBindings(),
        middlewares: [AuthGuard()]),
    GetPage(
        name: AppRoutes.completeDocumentPhotoSelfie,
        page: () => const CompleteProfileSelfieDocumentPage(),
        binding: CompleteProfileSelfieDocumentBindings(),
        middlewares: [AuthGuard()]),
    GetPage(
        name: AppRoutes.completeSelfie,
        page: () => const CompleteProfileSelfiePage(),
        binding: CompleteProfileSelfieBindings(),
        middlewares: [AuthGuard()]),
    GetPage(
        name: AppRoutes.completeConfirmSelfie,
        page: () => const CompleteProfileConfirmSelfiePage(),
        binding: CompleteProfileConfirmSelfieBinding(),
        middlewares: [AuthGuard()]),
    GetPage(
        name: AppRoutes.completeInReview,
        page: () => const CompleteProfileReviewPage(),
        binding: CompleteProfileReviewBindings(),
        middlewares: [AuthGuard()]),
  ];
}
