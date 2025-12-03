class AppRoutes {
  //Teste de Tema
  static const String themeTest = '/theme_test';

  //Splash
  static const String splash = '/splash';

  //Rotas de Login
  static const String login = '/login';
  static const String password = '/password';
  static const String privacy = '/privacy';

  //Rotas de Onboarding
  static const String onboarding = '/onboarding';
  static const String onboardingStepOne = '/onboarding_one';
  static const String onboardingStepTwo = '/onboarding_two';
  static const String onboardingStepThree = '/onboarding_three';
  static const String onboardingStepFour = '/onboarding_four';
  static const String onboardingStepFive = '/onboarding_five';
  static const String onboardingStepSix = '/onboarding_six';
  static const String onboardingStepSeven = '/onboarding_seven';
  static const String onboardingStepEight = '/onboarding_eight';
  static const String onboardingPhoneConfirm = '/onboarding_phone_confirm';
  static const String onboardingEmailConfirm = '/onboarding_email_confirm';
  static const String onboardingDocumentChoose = '/onboarding_document_choose';
  static const String onboardingSelfieConfirm = '/onboarding_selfie_confirm';
  static const String onboardingPasswordRegister =
      '/onboarding_password_register';
  static const String onboardingPrivacyPolicy = '/onboarding_password_register';
  static const String onboardingReview = '/onboarding_review';
  static const String onboardingApproved = '/onboarding_approved';
  static const String codeValidate = '/code_validate';

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
  static const String statementInvoice = '/statement_invoice/';

  //Rotas do Profile
  static const String financialData = '$profile/financial_data';
  static const String plans = '$profile/plans';
  static const String changePassword = '/change_password';
  static const String terms = '/terms';
  static const String privacyProfile = '/privacy_policy';

  //Rotas de Notificação
  static const String notifications = '$homePage/notifications';

  //Rotas de Transferência
  static const String transferContact = '/transfer_contact';
  static const String transferNewContact = '/transfer_new_contact';
  static const String transferBank = '/transfer_bank';
  static const String transferValue = '/transfer_value';
  static const String transferConfirm = '/transfer_confirm';
  static const String transferSuccess = '/transfer_success';
  static const String transferVoucher = '/transfer_voucher';

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

  static const String pixMyKeys = '/pix_my_keys';
  static const String pixAddKey = '/pix_add_key';
  static const String pixAddValue = '/pix_add_value';
  static const String pixDecode = '/pix_code';
  static const String pixCopyPaste = '/pix_copy_paste';
  static const String pixManualKey = '/pix_manual_key';
  static const String pixNewKey = '/pix_new_key';
  static const String pixStatement = '/pix_statement';
  static const String pixSuccess = '/pix_success';

  //Rotas de Serviços
  static const String services = '/services';

  //Rotas Links de Pagamento
  static const String paymentLink = '/payment_link';
  static const String paymentLinkGenerated = '$paymentLink/generated';
}
