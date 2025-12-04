import 'package:app_flutter_miban4/core/config/routes/cameraPage/camera_pages.dart';
import 'package:app_flutter_miban4/core/config/routes/homePage/home_page.dart';
import 'package:app_flutter_miban4/core/config/routes/loginPages/login_pages.dart';
import 'package:app_flutter_miban4/core/config/routes/notificationsPage/notifications_page.dart';
import 'package:app_flutter_miban4/core/config/routes/onboardingPages/onboarding_pages.dart';
import 'package:app_flutter_miban4/core/config/routes/paymentLinkPages/payment_link_pages.dart';
import 'package:app_flutter_miban4/core/config/routes/pixPages/pix_pages.dart';
import 'package:app_flutter_miban4/core/config/routes/profilePages/profile_pages.dart';
import 'package:app_flutter_miban4/core/config/routes/servicesPages/services_pages.dart';
import 'package:app_flutter_miban4/core/config/routes/statementPages/statement_pages.dart';
import 'package:app_flutter_miban4/core/config/routes/transferPages/transfer_pages.dart';
import 'package:get/get.dart';

class AppPages {
  static final List<GetPage> pages = [
    //Login Screens
    ...LoginPages.pages,

    //Onboarding Screens
    ...OnboardingPages.pages,

    //Home Screens
    ...HomePages.page,

    //Statement Screens
    ...StatementPages.pages,

    //Profile Screens
    ...ProfilePages.pages,

    //Notifications Screen
    ...NotificationPage.notifications,

    //Transfers Screens
    ...TransferPages.transferPages,

    //Pix Screen
    ...PixPages.pages,

    //Services Screens
    ...ServicesPages.pages,

    //Payment Link Screens
    ...PaymentLinkPages.paymentLinkPages,

    //Camera Screens
    ...CameraPages.pages
  ];
}
