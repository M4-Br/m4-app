import 'package:app_flutter_miban4/ui/routes/homePage/home_page.dart';
import 'package:app_flutter_miban4/ui/routes/loginPages/login_pages.dart';
import 'package:app_flutter_miban4/ui/routes/notificationsPage/notifications_page.dart';
import 'package:app_flutter_miban4/ui/routes/onboardingPages/onboarding_pages.dart';
import 'package:app_flutter_miban4/ui/routes/pixPages/pix_pages.dart';
import 'package:app_flutter_miban4/ui/routes/profilePages/profile_pages.dart';
import 'package:app_flutter_miban4/ui/routes/servicesPages/services_pages.dart';
import 'package:app_flutter_miban4/ui/routes/statementPages/statement_pages.dart';
import 'package:app_flutter_miban4/ui/routes/transferPages/transfer_pages.dart';
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
    ...NotificationsPage.notifications,

    //Transfers Screens
    ...TransferPages.transferPages,

    //Pix Screen
    ...PixPages.pages,

    //Services Screens
    ...ServicesPages.pages
  ];
}
