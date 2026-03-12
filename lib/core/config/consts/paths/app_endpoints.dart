import 'package:app_flutter_miban4/core/helpers/url_helper.dart';

class AppEndpoints {
  static String baseUrl = UrlHelper.url;

  //login
  static const String verifyAccount = '/v2/individual/';
  static const String authLogin = '/v3/auth';

  //onboarding
  static const String onboardingDocument = '/v2/register/individual';
  static const String onboardingBasicData = '/v2/register/individual/step1';
  static const String onboardingConfirmEmail =
      '/v2/register/individual/step1/validate';
  static const onboardingPhone = '/v2/register/individual/step2';
  static const onboardingPhoneConfirm =
      '/v2/register/individual/step2/validate';
  static const String onboardingRegisterPassword =
      '/v2/register/individual/step9';

  //notifications
  static const String notifications = '/notifications';

  //balance
  static const String balance = '/account/balance';

  //home
  static const String fetchIcons = '/app/home_info';

  //profile
  static const String plans = '/plans';
  static const String userParams = '/payment_capacity/params';
  static const String userCapacity = '/payment_capacity/';

  //statements
  static const String statement = '/v2/statements';
  static const String statementInvoice = '/statement/ted/';

  //payment link
  static const String paymentLink = '/transactions/link/create';

  //pix
  static const String pixKeyManager = '/pix/dict';
  static const String pixLimits = '/pix/limits';
  static const String pixReceive = '/pix/code/static';
  static const String pixValidateKey = '/pix/dict/validate';
  static const String pixTransfer = '/pix/transfers';
  static const String pixScheduled = '/pix/scheduled';
  static const String pixCodeDecode = '/pix/code/decode';

  //services
  static const String services = '/service';

  //storage
  static const String store = '/voucher/merchants';

  //policy
  static const String privacyPolicy = '/app/privacy-policy';

  // terms
  static const String terms = '/app/terms';

  //barcode
  static const String barcode = '/payment/validate';
  static const String barcodePayment = '/transactions/payment';

  //transfer
  static const String tranferP2P = '/transactions/p2p';
  static const String transferTED = '/transactions/ted';
  static const String transferFindContact = '/account/document';

  //complete profile
  static const String completeAddress = '/v2/register/individual/step3';
  static const String completeProfession = '/v2/register/individual/step4';
  static const String completePersonalData = '/v2/register/individual/step5';
  static const String completeDocumentPhoto = '/v2/register/individual/step6';
  static const String completeDocumentSelfie = '/v2/register/individual/step7';
  static const String completeSelfie = '/v2/register/individual/step8';
  static const String getDocument = '/account/document';
  static const String sendToken = '/user/send_code_email';
  static const String validateEmail = '/user/validate_email';

  //cep
  static const String cep = '/viacep';

  //profession
  static const String profession = '/v2/register/individual/step4/type';

  //favorites
  static const String favorites = '/favorites/';

  //Bank List
  static const String bankList = '/banks_list';

  //Offers List
  static const String offers = '/offers';

  //Accounting
  static const String accountingData = '/tax_data';

  //Marketplace
  static const String marketplaceCategory = '/partner/category';
  static const String marketplaceProduct = '/partner/product';
  static const String marketplaceale = '/partner/product_sale';
}
