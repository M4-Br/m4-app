class AppRoutes {
  //Teste de Tema
  static const String themeTest = '/theme_test';

  //Splash
  static const String splash = '/splash';

  //Rotas de Login
  static const String login = '/login';
  static const String password = '/password';
  static const String authValidateToken = '$password/validate';
  static const String authChangePassword = '$password/change';

  //NEW ONBOARDING
  static const String onboardingDocument = '/register';
  static const String onboardingBasicData = '$onboardingDocument/initial';
  static const String onboardingConfirmEmail =
      '$onboardingDocument/confirmEmail';
  static const String onboardingPhone = '$onboardingDocument/phone';
  static const String onboardingConfirmPhone = '$onboardingDocument/phonePhone';
  static const String onboardingRegisterPassword =
      '$onboardingDocument/password';
  static const String onboardingInitialRegisterDone =
      '$onboardingDocument/done';

  //Rotas da Home
  static const String homeView = '/';
  static const String homePage = '/home';
  static const String statement = '/statement';
  static const String profile = '/profile';

  //Rotas do Extrato
  static const String statementInvoice = '$statement/invoice/';

  //Rotas do Profile
  static const String financialData = '$profile/financial_data';
  static const String plans = '$profile/plans';
  static const String changePasswordEmailConfirm = '$profile/validate';
  static const String changePasswordFromProfile = '$profile/change_password';
  static const String privacyPolicyFromProfile = '$profile/privacy_policy';
  static const String termsFromProfile = '$profile/terms';

  //Rotas de Notificação
  static const String notifications = '$homePage/notifications';

  //Rotas de Transferência
  static const String transfer = '/transfers';
  static const String transferNewContact = '$transfer/new_contact';

  static const String transferBank = '$transfer/bank';
  static const String transferValueAndConfirm = '$transfer/value';
  static const String transferSuccess = '$transfer/success';
  static const String transferVoucher = '$transfer/voucher';

  //Rotas de Pix
  static const String pixHome = '/pix';
  static const String pixKeyManager = '$pixHome/keys_manager';
  static const String pixLimits = '$pixHome/limits';

  static const String pixReceive = '$pixHome/receive';
  static const String pixReceiveQrCode = '$pixReceive/qrcode';

  static const String pixWithKey = '$pixHome/key';
  static const String pixTransfer = '$pixHome/transfer';
  static const String pixInvoice = '$pixTransfer/invoice';

  static const String pixScheduled = '$pixHome/scheduled';

  static const String pixCopyPaste = '$pixHome/paste';

  static const String pixQrCodeReader = '$pixHome/qrcode';
  static const String pixDecode = '$pixHome/code';

  static const String pixNewKey = '$pixHome/new';
  static const String pixStatement = '$pixHome/statement';

  //Rotas de Serviços
  static const String services = '/services';

  //Rotas de Loja
  static const String store = '/store';

  //Rotas Links de Pagamento
  static const String paymentLink = '/payment_link';
  static const String paymentLinkGenerated = '$paymentLink/generated';

  //Rotas de termos e politicas
  static const String privacyPolicyFromLogin = '$login/privacy_policy';

  //barcode
  static const String barcode = '/barcode';
  static const String barcodeManual = '$barcode/manual';
  static const String barcodeConfirmPayment = '$barcode/confirm';
  static const String barcodeVoucher = '$barcode/invoice';

  //web
  static const String webView = '/web';

  //Complete Profile
  static const String complete = '/complete';
  static const String completeAddress = '$complete/address';
  static const String completeProfession = '$complete/profession';
  static const String completePersonalData = '$complete/personal_data';
  static const String completeDocumentChoose = '$complete/choose';
  static const String completeDocumentPhoto = '$complete/document';
  static const String completeDocumentPhotoSelfie = '$complete/document_selfie';
  static const String completeSelfie = '$complete/selfie';
  static const String completeConfirmSelfie = '$complete/confirm_selfie';
  static const String completeInReview = '$complete/review';
}
