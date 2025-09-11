import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_pt.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es'),
    Locale('pt')
  ];

  /// No description provided for @page1.
  ///
  /// In en, this message translates to:
  /// **'Login Page'**
  String get page1;

  /// No description provided for @terms.
  ///
  /// In en, this message translates to:
  /// **'By continuing, you agree to the privacy policy'**
  String get terms;

  /// No description provided for @cpf.
  ///
  /// In en, this message translates to:
  /// **'User ID'**
  String get cpf;

  /// No description provided for @access.
  ///
  /// In en, this message translates to:
  /// **'ACCESS'**
  String get access;

  /// No description provided for @privacy_policy_title.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacy_policy_title;

  /// No description provided for @register.
  ///
  /// In en, this message translates to:
  /// **'SIGN UP'**
  String get register;

  /// No description provided for @privacy_policy_read.
  ///
  /// In en, this message translates to:
  /// **'Read to the end to accept the Privacy Policy.'**
  String get privacy_policy_read;

  /// No description provided for @terms_credit.
  ///
  /// In en, this message translates to:
  /// **'By continuing, you accept the \n credit terms'**
  String get terms_credit;

  /// No description provided for @terms_credit_read.
  ///
  /// In en, this message translates to:
  /// **'Read to the end to accept the Terms'**
  String get terms_credit_read;

  /// No description provided for @terms_read.
  ///
  /// In en, this message translates to:
  /// **'I have read, understood, and \n accept the credit terms'**
  String get terms_read;

  /// No description provided for @page2.
  ///
  /// In en, this message translates to:
  /// **'Password Page'**
  String get page2;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @forgot_password.
  ///
  /// In en, this message translates to:
  /// **'FORGOT PASSWORD'**
  String get forgot_password;

  /// No description provided for @page3.
  ///
  /// In en, this message translates to:
  /// **'Home Page'**
  String get page3;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'HOME'**
  String get home;

  /// No description provided for @card.
  ///
  /// In en, this message translates to:
  /// **'CARD'**
  String get card;

  /// No description provided for @statement.
  ///
  /// In en, this message translates to:
  /// **'STATEMENT'**
  String get statement;

  /// No description provided for @perfil.
  ///
  /// In en, this message translates to:
  /// **'PROFILE'**
  String get perfil;

  /// No description provided for @page4.
  ///
  /// In en, this message translates to:
  /// **'Onboarding Step 1 Page'**
  String get page4;

  /// No description provided for @welcome.
  ///
  /// In en, this message translates to:
  /// **'Welcome'**
  String get welcome;

  /// No description provided for @insert_cpf.
  ///
  /// In en, this message translates to:
  /// **'Enter your document to continue'**
  String get insert_cpf;

  /// No description provided for @read_policy.
  ///
  /// In en, this message translates to:
  /// **'I have read, agreed, and accepted the privacy policy'**
  String get read_policy;

  /// No description provided for @page5.
  ///
  /// In en, this message translates to:
  /// **'Onboarding Step 2 page'**
  String get page5;

  /// No description provided for @register_init.
  ///
  /// In en, this message translates to:
  /// **'Let\'s begin your registration!'**
  String get register_init;

  /// No description provided for @informations_continue.
  ///
  /// In en, this message translates to:
  /// **'Enter some information to proceed:'**
  String get informations_continue;

  /// No description provided for @full_name.
  ///
  /// In en, this message translates to:
  /// **'Full Name'**
  String get full_name;

  /// No description provided for @nickname.
  ///
  /// In en, this message translates to:
  /// **'What do you want to be called?'**
  String get nickname;

  /// No description provided for @promotional_code.
  ///
  /// In en, this message translates to:
  /// **'Promotional Code (optional)'**
  String get promotional_code;

  /// No description provided for @confirm_email.
  ///
  /// In en, this message translates to:
  /// **'Confirm your email'**
  String get confirm_email;

  /// No description provided for @page6.
  ///
  /// In en, this message translates to:
  /// **'Onboarding Step 3 Page'**
  String get page6;

  /// No description provided for @phone_register.
  ///
  /// In en, this message translates to:
  /// **'Phone Registration'**
  String get phone_register;

  /// No description provided for @for_secure_phone.
  ///
  /// In en, this message translates to:
  /// **'For your security, we will register your phone to ensure that only you can access your account.'**
  String get for_secure_phone;

  /// No description provided for @phone.
  ///
  /// In en, this message translates to:
  /// **'Phone'**
  String get phone;

  /// No description provided for @page7.
  ///
  /// In en, this message translates to:
  /// **'Onboarding Step 4 Page'**
  String get page7;

  /// No description provided for @full_address_information.
  ///
  /// In en, this message translates to:
  /// **'Provide your complete residential address:'**
  String get full_address_information;

  /// No description provided for @address_cep.
  ///
  /// In en, this message translates to:
  /// **'ZIP Code'**
  String get address_cep;

  /// No description provided for @address_type.
  ///
  /// In en, this message translates to:
  /// **'Residence Type'**
  String get address_type;

  /// No description provided for @address.
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get address;

  /// No description provided for @address_number.
  ///
  /// In en, this message translates to:
  /// **'Number'**
  String get address_number;

  /// No description provided for @address_no_number.
  ///
  /// In en, this message translates to:
  /// **'I don\'t have a number'**
  String get address_no_number;

  /// No description provided for @address_complement.
  ///
  /// In en, this message translates to:
  /// **'Complement'**
  String get address_complement;

  /// No description provided for @address_neighborhood.
  ///
  /// In en, this message translates to:
  /// **'Neighborhood'**
  String get address_neighborhood;

  /// No description provided for @address_state.
  ///
  /// In en, this message translates to:
  /// **'State'**
  String get address_state;

  /// No description provided for @address_city.
  ///
  /// In en, this message translates to:
  /// **'City'**
  String get address_city;

  /// No description provided for @page8.
  ///
  /// In en, this message translates to:
  /// **'Onboarding Step 5'**
  String get page8;

  /// No description provided for @income_inform.
  ///
  /// In en, this message translates to:
  /// **'Provide your income information:'**
  String get income_inform;

  /// No description provided for @profession.
  ///
  /// In en, this message translates to:
  /// **'Profession'**
  String get profession;

  /// No description provided for @income.
  ///
  /// In en, this message translates to:
  /// **'Income'**
  String get income;

  /// No description provided for @choose_profession.
  ///
  /// In en, this message translates to:
  /// **'Choose a profession'**
  String get choose_profession;

  /// No description provided for @page9.
  ///
  /// In en, this message translates to:
  /// **'Onboarding Step 6'**
  String get page9;

  /// No description provided for @personal_data.
  ///
  /// In en, this message translates to:
  /// **'Personal Information'**
  String get personal_data;

  /// No description provided for @pay_attention.
  ///
  /// In en, this message translates to:
  /// **'Fill in your information according to your document. Pay close attention, as these details are important for our analysis.'**
  String get pay_attention;

  /// No description provided for @document_name.
  ///
  /// In en, this message translates to:
  /// **'Your Name on the Document'**
  String get document_name;

  /// No description provided for @document_mother_name.
  ///
  /// In en, this message translates to:
  /// **'Full Mother\'s Name'**
  String get document_mother_name;

  /// No description provided for @document_gender.
  ///
  /// In en, this message translates to:
  /// **'Gender'**
  String get document_gender;

  /// No description provided for @document_birthday.
  ///
  /// In en, this message translates to:
  /// **'Date of Birth'**
  String get document_birthday;

  /// No description provided for @document_marital_status.
  ///
  /// In en, this message translates to:
  /// **'Marital Status'**
  String get document_marital_status;

  /// No description provided for @document_nationality.
  ///
  /// In en, this message translates to:
  /// **'Nationality'**
  String get document_nationality;

  /// No description provided for @document_rg.
  ///
  /// In en, this message translates to:
  /// **'RG Number'**
  String get document_rg;

  /// No description provided for @document_state.
  ///
  /// In en, this message translates to:
  /// **'State'**
  String get document_state;

  /// No description provided for @document_pep.
  ///
  /// In en, this message translates to:
  /// **'Politically Exposed Person'**
  String get document_pep;

  /// No description provided for @document_rgEmission.
  ///
  /// In en, this message translates to:
  /// **'Issuing Authority'**
  String get document_rgEmission;

  /// No description provided for @document_rg_date.
  ///
  /// In en, this message translates to:
  /// **'Date of Issue'**
  String get document_rg_date;

  /// No description provided for @document_pep_date.
  ///
  /// In en, this message translates to:
  /// **'START DATE OF PEP'**
  String get document_pep_date;

  /// No description provided for @page10.
  ///
  /// In en, this message translates to:
  /// **'Onboarding Step 7'**
  String get page10;

  /// No description provided for @choose_document.
  ///
  /// In en, this message translates to:
  /// **'What type of identification document do you want to add?'**
  String get choose_document;

  /// No description provided for @page101.
  ///
  /// In en, this message translates to:
  /// **'Onboarding Step 8'**
  String get page101;

  /// No description provided for @take_document_selfie.
  ///
  /// In en, this message translates to:
  /// **'Selfie with Document (ID)'**
  String get take_document_selfie;

  /// No description provided for @selfie_one.
  ///
  /// In en, this message translates to:
  /// **'Take your identity document and hold it in front of you.'**
  String get selfie_one;

  /// No description provided for @selfie_two.
  ///
  /// In en, this message translates to:
  /// **'Ensure the photo of the identity document is also facing forward.'**
  String get selfie_two;

  /// No description provided for @selfie_three.
  ///
  /// In en, this message translates to:
  /// **'Take a selfie with your identification document visible.'**
  String get selfie_three;

  /// No description provided for @page11.
  ///
  /// In en, this message translates to:
  /// **'Onboarding Step 9'**
  String get page11;

  /// No description provided for @every_ok.
  ///
  /// In en, this message translates to:
  /// **'Everything Ready?'**
  String get every_ok;

  /// No description provided for @plastic.
  ///
  /// In en, this message translates to:
  /// **'Remove the plastic from the document and unfold it completely'**
  String get plastic;

  /// No description provided for @front_photo.
  ///
  /// In en, this message translates to:
  /// **'FRONT PHOTO'**
  String get front_photo;

  /// No description provided for @back_photo.
  ///
  /// In en, this message translates to:
  /// **'BACK PHOTO'**
  String get back_photo;

  /// No description provided for @page12.
  ///
  /// In en, this message translates to:
  /// **'Onboarding Step 9'**
  String get page12;

  /// No description provided for @selfie.
  ///
  /// In en, this message translates to:
  /// **'Selfie Time!'**
  String get selfie;

  /// No description provided for @dont_perfect.
  ///
  /// In en, this message translates to:
  /// **'It doesn\'t need to be a perfect photo, but we have some guidelines that will help you in the process.'**
  String get dont_perfect;

  /// No description provided for @dont_gadgets.
  ///
  /// In en, this message translates to:
  /// **'Accessories are not allowed.'**
  String get dont_gadgets;

  /// No description provided for @focus_photo.
  ///
  /// In en, this message translates to:
  /// **'Frame your face.'**
  String get focus_photo;

  /// No description provided for @dont_glasses.
  ///
  /// In en, this message translates to:
  /// **'Glasses are not allowed.'**
  String get dont_glasses;

  /// No description provided for @page13.
  ///
  /// In en, this message translates to:
  /// **'Analysis Page'**
  String get page13;

  /// No description provided for @analysis_progress.
  ///
  /// In en, this message translates to:
  /// **'Analysis in progress'**
  String get analysis_progress;

  /// No description provided for @request_sent.
  ///
  /// In en, this message translates to:
  /// **'Your request has been sent.\n We are currently reviewing your registration.\n You will receive more information shortly.'**
  String get request_sent;

  /// No description provided for @know_more.
  ///
  /// In en, this message translates to:
  /// **'Want to know more about us?'**
  String get know_more;

  /// No description provided for @want.
  ///
  /// In en, this message translates to:
  /// **'YES, I DO'**
  String get want;

  /// No description provided for @back_login.
  ///
  /// In en, this message translates to:
  /// **'Back to the main page'**
  String get back_login;

  /// No description provided for @page14.
  ///
  /// In en, this message translates to:
  /// **'Approved Page'**
  String get page14;

  /// No description provided for @approved.
  ///
  /// In en, this message translates to:
  /// **'Your registration has been approved!'**
  String get approved;

  /// No description provided for @need_create_password.
  ///
  /// In en, this message translates to:
  /// **'You just need to create a \n password to start using the App.'**
  String get need_create_password;

  /// No description provided for @create_password.
  ///
  /// In en, this message translates to:
  /// **'CREATE A PASSWORD'**
  String get create_password;

  /// No description provided for @page15.
  ///
  /// In en, this message translates to:
  /// **'Create Password Page'**
  String get page15;

  /// No description provided for @create_new_password.
  ///
  /// In en, this message translates to:
  /// **'Create your password'**
  String get create_new_password;

  /// No description provided for @password_justify.
  ///
  /// In en, this message translates to:
  /// **'You will need it whenever you make a payment,\n so keep it safe and remember it.\n Your password will be a sequence of 6 numbers.'**
  String get password_justify;

  /// No description provided for @confirm_password.
  ///
  /// In en, this message translates to:
  /// **'Confirm password'**
  String get confirm_password;

  /// No description provided for @change_app_password.
  ///
  /// In en, this message translates to:
  /// **'Change app password'**
  String get change_app_password;

  /// No description provided for @change_password_password.
  ///
  /// In en, this message translates to:
  /// **'Current App password (6 Digits)'**
  String get change_password_password;

  /// No description provided for @change_password_new.
  ///
  /// In en, this message translates to:
  /// **'New App password (6 Digits)'**
  String get change_password_new;

  /// No description provided for @change_password_new_confirm.
  ///
  /// In en, this message translates to:
  /// **'Repeat new App password (6 Digits)'**
  String get change_password_new_confirm;

  /// No description provided for @change_password_validate.
  ///
  /// In en, this message translates to:
  /// **'The password must be 6 digits.'**
  String get change_password_validate;

  /// No description provided for @change_password_not_equal.
  ///
  /// In en, this message translates to:
  /// **'The passwords do not match'**
  String get change_password_not_equal;

  /// No description provided for @change_password_changed.
  ///
  /// In en, this message translates to:
  /// **'Your password has been changed'**
  String get change_password_changed;

  /// No description provided for @page17.
  ///
  /// In en, this message translates to:
  /// **'Barcode Payment'**
  String get page17;

  /// No description provided for @pay.
  ///
  /// In en, this message translates to:
  /// **'PAY'**
  String get pay;

  /// No description provided for @payment_total.
  ///
  /// In en, this message translates to:
  /// **'YOU WILL PAY A TOTAL OF:'**
  String get payment_total;

  /// No description provided for @payment_realized.
  ///
  /// In en, this message translates to:
  /// **'Payment will be realized on:'**
  String get payment_realized;

  /// No description provided for @payment_expired.
  ///
  /// In en, this message translates to:
  /// **'Invoice due date:'**
  String get payment_expired;

  /// No description provided for @payment_receiver.
  ///
  /// In en, this message translates to:
  /// **'Payee:'**
  String get payment_receiver;

  /// No description provided for @payment_barcode.
  ///
  /// In en, this message translates to:
  /// **'Barcode:'**
  String get payment_barcode;

  /// No description provided for @payment_discount.
  ///
  /// In en, this message translates to:
  /// **'Discounts:'**
  String get payment_discount;

  /// No description provided for @payment_fees.
  ///
  /// In en, this message translates to:
  /// **'Interest and Fees:'**
  String get payment_fees;

  /// No description provided for @payment_fine.
  ///
  /// In en, this message translates to:
  /// **'Penalties:'**
  String get payment_fine;

  /// No description provided for @pay_barcode.
  ///
  /// In en, this message translates to:
  /// **'PAY INVOICE'**
  String get pay_barcode;

  /// No description provided for @barcode_barcode.
  ///
  /// In en, this message translates to:
  /// **'Barcode'**
  String get barcode_barcode;

  /// No description provided for @barcode_auto.
  ///
  /// In en, this message translates to:
  /// **'Scan Barcode'**
  String get barcode_auto;

  /// No description provided for @barcode_info.
  ///
  /// In en, this message translates to:
  /// **'The bills can be paid on business days from 7 AM to 5 PM.'**
  String get barcode_info;

  /// No description provided for @barcode_info_after.
  ///
  /// In en, this message translates to:
  /// **'After this time, it will only be possible to make the payment on the next business day.'**
  String get barcode_info_after;

  /// No description provided for @page18.
  ///
  /// In en, this message translates to:
  /// **'Invoice Voucher'**
  String get page18;

  /// No description provided for @invoice_success.
  ///
  /// In en, this message translates to:
  /// **'Payment successfully completed!'**
  String get invoice_success;

  /// No description provided for @invoice_amount.
  ///
  /// In en, this message translates to:
  /// **'Amount paid:'**
  String get invoice_amount;

  /// No description provided for @invoice_date.
  ///
  /// In en, this message translates to:
  /// **'On the day:'**
  String get invoice_date;

  /// No description provided for @invoice_receiver.
  ///
  /// In en, this message translates to:
  /// **'Payee:'**
  String get invoice_receiver;

  /// No description provided for @invoice_share.
  ///
  /// In en, this message translates to:
  /// **'Generate receipt'**
  String get invoice_share;

  /// No description provided for @page19.
  ///
  /// In en, this message translates to:
  /// **'Pix Home'**
  String get page19;

  /// No description provided for @pix_manager_keys.
  ///
  /// In en, this message translates to:
  /// **'Key Management'**
  String get pix_manager_keys;

  /// No description provided for @pix_manage_data.
  ///
  /// In en, this message translates to:
  /// **'Manage your PIX data'**
  String get pix_manage_data;

  /// No description provided for @pix_myLimits.
  ///
  /// In en, this message translates to:
  /// **'My Pix limits'**
  String get pix_myLimits;

  /// No description provided for @pix_setLimit.
  ///
  /// In en, this message translates to:
  /// **'Set a PIX transaction limit'**
  String get pix_setLimit;

  /// No description provided for @pix_receive.
  ///
  /// In en, this message translates to:
  /// **'Receive Pix'**
  String get pix_receive;

  /// No description provided for @pix_receiveValue.
  ///
  /// In en, this message translates to:
  /// **'Receive through a link and QR Code'**
  String get pix_receiveValue;

  /// No description provided for @pix_key.
  ///
  /// In en, this message translates to:
  /// **'Pix with key'**
  String get pix_key;

  /// No description provided for @pix_payKey.
  ///
  /// In en, this message translates to:
  /// **'Pay with addressing key'**
  String get pix_payKey;

  /// No description provided for @pix_manualKey.
  ///
  /// In en, this message translates to:
  /// **'Pix with manual key'**
  String get pix_manualKey;

  /// No description provided for @pix_bank.
  ///
  /// In en, this message translates to:
  /// **'Pay with branch/account'**
  String get pix_bank;

  /// No description provided for @pix_qrCode.
  ///
  /// In en, this message translates to:
  /// **'Pix with QR Code'**
  String get pix_qrCode;

  /// No description provided for @pix_payQrCode.
  ///
  /// In en, this message translates to:
  /// **'Pay through a QR Code'**
  String get pix_payQrCode;

  /// No description provided for @pix_copyPaste.
  ///
  /// In en, this message translates to:
  /// **'Pix copy and paste'**
  String get pix_copyPaste;

  /// No description provided for @pix_payCopy.
  ///
  /// In en, this message translates to:
  /// **'Pay through shortcuts'**
  String get pix_payCopy;

  /// No description provided for @page20.
  ///
  /// In en, this message translates to:
  /// **'Pix My Keys'**
  String get page20;

  /// No description provided for @pix_keys.
  ///
  /// In en, this message translates to:
  /// **'ADDRESSING KEYS'**
  String get pix_keys;

  /// No description provided for @pix_noKeys.
  ///
  /// In en, this message translates to:
  /// **'No Pix keys created.'**
  String get pix_noKeys;

  /// No description provided for @pix_createKey.
  ///
  /// In en, this message translates to:
  /// **'REGISTER KEY'**
  String get pix_createKey;

  /// No description provided for @pix_keyCopied.
  ///
  /// In en, this message translates to:
  /// **'Key copied to clipboard'**
  String get pix_keyCopied;

  /// No description provided for @page21.
  ///
  /// In en, this message translates to:
  /// **'Register Key'**
  String get page21;

  /// No description provided for @pix_registerKey.
  ///
  /// In en, this message translates to:
  /// **'REGISTER NEW KEY'**
  String get pix_registerKey;

  /// No description provided for @pix_newKey.
  ///
  /// In en, this message translates to:
  /// **'New Key'**
  String get pix_newKey;

  /// No description provided for @pix_waitNewKey.
  ///
  /// In en, this message translates to:
  /// **'Please wait while we create \n your new key'**
  String get pix_waitNewKey;

  /// No description provided for @pix_createNewKey.
  ///
  /// In en, this message translates to:
  /// **'REGISTER KEY'**
  String get pix_createNewKey;

  /// No description provided for @page22.
  ///
  /// In en, this message translates to:
  /// **'Pix Key Manager'**
  String get page22;

  /// No description provided for @pix_keyManager.
  ///
  /// In en, this message translates to:
  /// **'KEY MANAGEMENT'**
  String get pix_keyManager;

  /// No description provided for @pix_phoneKey.
  ///
  /// In en, this message translates to:
  /// **'Phone'**
  String get pix_phoneKey;

  /// No description provided for @pix_documentKey.
  ///
  /// In en, this message translates to:
  /// **'Document'**
  String get pix_documentKey;

  /// No description provided for @pix_emailKey.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get pix_emailKey;

  /// No description provided for @pix_randomKey.
  ///
  /// In en, this message translates to:
  /// **'Random Key'**
  String get pix_randomKey;

  /// No description provided for @pix_haveNot.
  ///
  /// In en, this message translates to:
  /// **'You do not have registered keys'**
  String get pix_haveNot;

  /// No description provided for @pix_fiveKeys.
  ///
  /// In en, this message translates to:
  /// **'You can have up to 5 keys per account'**
  String get pix_fiveKeys;

  /// No description provided for @pix_sureDelete.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete the key?'**
  String get pix_sureDelete;

  /// No description provided for @pix_keyExclude.
  ///
  /// In en, this message translates to:
  /// **'The key will be unlinked from your account'**
  String get pix_keyExclude;

  /// No description provided for @pix_stayWithKey.
  ///
  /// In en, this message translates to:
  /// **'CONTINUE WITH THE KEY'**
  String get pix_stayWithKey;

  /// No description provided for @pix_deleteKey.
  ///
  /// In en, this message translates to:
  /// **'DELETE THE KEY'**
  String get pix_deleteKey;

  /// No description provided for @page23.
  ///
  /// In en, this message translates to:
  /// **'Pix Receive'**
  String get page23;

  /// No description provided for @pix_receiver.
  ///
  /// In en, this message translates to:
  /// **'RECEIVE PIX'**
  String get pix_receiver;

  /// No description provided for @pix_selectKey.
  ///
  /// In en, this message translates to:
  /// **'Select a key or '**
  String get pix_selectKey;

  /// No description provided for @pix_nKey.
  ///
  /// In en, this message translates to:
  /// **'create a new one'**
  String get pix_nKey;

  /// No description provided for @pix_keySelect.
  ///
  /// In en, this message translates to:
  /// **'KEY'**
  String get pix_keySelect;

  /// No description provided for @pix_optional.
  ///
  /// In en, this message translates to:
  /// **'OPTIONAL'**
  String get pix_optional;

  /// No description provided for @pix_identifier.
  ///
  /// In en, this message translates to:
  /// **'Identifier'**
  String get pix_identifier;

  /// No description provided for @pix_description.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get pix_description;

  /// No description provided for @pix_value.
  ///
  /// In en, this message translates to:
  /// **'Value (R\$)'**
  String get pix_value;

  /// No description provided for @page24.
  ///
  /// In en, this message translates to:
  /// **'Pix With Key'**
  String get page24;

  /// No description provided for @pix_withKey.
  ///
  /// In en, this message translates to:
  /// **'PIX WITH KEY'**
  String get pix_withKey;

  /// No description provided for @pix_addReceiverKey.
  ///
  /// In en, this message translates to:
  /// **'Add the receiver\'s key and perform the search:'**
  String get pix_addReceiverKey;

  /// No description provided for @pix_keyType.
  ///
  /// In en, this message translates to:
  /// **'KEY TYPE'**
  String get pix_keyType;

  /// No description provided for @pix_labelKey.
  ///
  /// In en, this message translates to:
  /// **'KEY'**
  String get pix_labelKey;

  /// No description provided for @pix_search.
  ///
  /// In en, this message translates to:
  /// **'SEARCH'**
  String get pix_search;

  /// No description provided for @pix_agencyAccount.
  ///
  /// In en, this message translates to:
  /// **'PIX WITH AGENCY AND ACCOUNT'**
  String get pix_agencyAccount;

  /// No description provided for @page25.
  ///
  /// In en, this message translates to:
  /// **'Pix Transfer'**
  String get page25;

  /// No description provided for @pix_payValue.
  ///
  /// In en, this message translates to:
  /// **'Amount to pay:'**
  String get pix_payValue;

  /// No description provided for @pix_descriptionTransfer.
  ///
  /// In en, this message translates to:
  /// **'Add description (optional)'**
  String get pix_descriptionTransfer;

  /// No description provided for @pix_transferDate.
  ///
  /// In en, this message translates to:
  /// **'Payment date:'**
  String get pix_transferDate;

  /// No description provided for @pix_institution.
  ///
  /// In en, this message translates to:
  /// **'Institution'**
  String get pix_institution;

  /// No description provided for @pix_receiverTransfer.
  ///
  /// In en, this message translates to:
  /// **'Receiver'**
  String get pix_receiverTransfer;

  /// No description provided for @pix_keyKey.
  ///
  /// In en, this message translates to:
  /// **'Key'**
  String get pix_keyKey;

  /// No description provided for @page26.
  ///
  /// In en, this message translates to:
  /// **'Create Value QRCode'**
  String get page26;

  /// No description provided for @demand_demand.
  ///
  /// In en, this message translates to:
  /// **'CASH IN'**
  String get demand_demand;

  /// No description provided for @demand_value.
  ///
  /// In en, this message translates to:
  /// **'How much to cash-in?'**
  String get demand_value;

  /// No description provided for @demand_minimum.
  ///
  /// In en, this message translates to:
  /// **'Minimum transfer amount R\$ 10.00'**
  String get demand_minimum;

  /// No description provided for @demand_fees.
  ///
  /// In en, this message translates to:
  /// **'Check fees'**
  String get demand_fees;

  /// No description provided for @page27.
  ///
  /// In en, this message translates to:
  /// **'Account Screen'**
  String get page27;

  /// No description provided for @account_myAccount.
  ///
  /// In en, this message translates to:
  /// **'MY ACCOUNT'**
  String get account_myAccount;

  /// No description provided for @account_myQr.
  ///
  /// In en, this message translates to:
  /// **'MY QR CODE'**
  String get account_myQr;

  /// No description provided for @account_personalData.
  ///
  /// In en, this message translates to:
  /// **'PERSONAL DATA'**
  String get account_personalData;

  /// No description provided for @account_name.
  ///
  /// In en, this message translates to:
  /// **'NAME'**
  String get account_name;

  /// No description provided for @account_document.
  ///
  /// In en, this message translates to:
  /// **'DOCUMENT'**
  String get account_document;

  /// No description provided for @account_contact.
  ///
  /// In en, this message translates to:
  /// **'CONTACT'**
  String get account_contact;

  /// No description provided for @account_phone.
  ///
  /// In en, this message translates to:
  /// **'PHONE'**
  String get account_phone;

  /// No description provided for @account_security.
  ///
  /// In en, this message translates to:
  /// **'SECURITY'**
  String get account_security;

  /// No description provided for @account_plans.
  ///
  /// In en, this message translates to:
  /// **'PLANS AND RATES'**
  String get account_plans;

  /// No description provided for @account_terms.
  ///
  /// In en, this message translates to:
  /// **'TERMS OF USE'**
  String get account_terms;

  /// No description provided for @account_privacy.
  ///
  /// In en, this message translates to:
  /// **'PRIVACY POLICY'**
  String get account_privacy;

  /// No description provided for @account_helper.
  ///
  /// In en, this message translates to:
  /// **'HELP'**
  String get account_helper;

  /// No description provided for @account_logout.
  ///
  /// In en, this message translates to:
  /// **'LOGOUT'**
  String get account_logout;

  /// No description provided for @account_data.
  ///
  /// In en, this message translates to:
  /// **'FINANCIAL DATA'**
  String get account_data;

  /// No description provided for @account_bank.
  ///
  /// In en, this message translates to:
  /// **'Bank'**
  String get account_bank;

  /// No description provided for @account_agency.
  ///
  /// In en, this message translates to:
  /// **'Agency'**
  String get account_agency;

  /// No description provided for @account_account.
  ///
  /// In en, this message translates to:
  /// **'Checking account'**
  String get account_account;

  /// No description provided for @account.
  ///
  /// In en, this message translates to:
  /// **'Account:'**
  String get account;

  /// No description provided for @page28.
  ///
  /// In en, this message translates to:
  /// **'Transfer'**
  String get page28;

  /// No description provided for @transfer.
  ///
  /// In en, this message translates to:
  /// **'TRANSFER'**
  String get transfer;

  /// No description provided for @transfer_to.
  ///
  /// In en, this message translates to:
  /// **'Who are you transferring to?'**
  String get transfer_to;

  /// No description provided for @transfer_noOne.
  ///
  /// In en, this message translates to:
  /// **'You don\'t have anyone registered yet.'**
  String get transfer_noOne;

  /// No description provided for @transfer_new_contact.
  ///
  /// In en, this message translates to:
  /// **'Transfer to a new contact'**
  String get transfer_new_contact;

  /// No description provided for @transfer_cpf.
  ///
  /// In en, this message translates to:
  /// **'CPF or CNPJ'**
  String get transfer_cpf;

  /// No description provided for @transfer_document.
  ///
  /// In en, this message translates to:
  /// **'Number of document'**
  String get transfer_document;

  /// No description provided for @page29.
  ///
  /// In en, this message translates to:
  /// **'Transfer Bank'**
  String get page29;

  /// No description provided for @transfer_miban.
  ///
  /// In en, this message translates to:
  /// **'Transfer to Miban4 account'**
  String get transfer_miban;

  /// No description provided for @transfer_other.
  ///
  /// In en, this message translates to:
  /// **'Transfer to another bank'**
  String get transfer_other;

  /// No description provided for @page30.
  ///
  /// In en, this message translates to:
  /// **'Transfer Value'**
  String get page30;

  /// No description provided for @transfer_value.
  ///
  /// In en, this message translates to:
  /// **'How much do you want \n to transfer?'**
  String get transfer_value;

  /// No description provided for @transfer_balance.
  ///
  /// In en, this message translates to:
  /// **'Available balance'**
  String get transfer_balance;

  /// No description provided for @transfer_minimum.
  ///
  /// In en, this message translates to:
  /// **'Minimum transfer amount'**
  String get transfer_minimum;

  /// No description provided for @transfer_balance_savings.
  ///
  /// In en, this message translates to:
  /// **'Savings balance available'**
  String get transfer_balance_savings;

  /// No description provided for @page31.
  ///
  /// In en, this message translates to:
  /// **'Transfer Confirm'**
  String get page31;

  /// No description provided for @transfer_confirm.
  ///
  /// In en, this message translates to:
  /// **'Do you want to make a \n transfer in the amount of:'**
  String get transfer_confirm;

  /// No description provided for @transfer_valueConfirm.
  ///
  /// In en, this message translates to:
  /// **'Value'**
  String get transfer_valueConfirm;

  /// No description provided for @transfer_date.
  ///
  /// In en, this message translates to:
  /// **'On the day:'**
  String get transfer_date;

  /// No description provided for @transfer_to_confirm.
  ///
  /// In en, this message translates to:
  /// **'To:'**
  String get transfer_to_confirm;

  /// No description provided for @transfer_bank.
  ///
  /// In en, this message translates to:
  /// **'Bank:'**
  String get transfer_bank;

  /// No description provided for @transfer_account.
  ///
  /// In en, this message translates to:
  /// **'Account:'**
  String get transfer_account;

  /// No description provided for @transfer_fees.
  ///
  /// In en, this message translates to:
  /// **'Fee'**
  String get transfer_fees;

  /// No description provided for @page32.
  ///
  /// In en, this message translates to:
  /// **'Transfer Success'**
  String get page32;

  /// No description provided for @transfer_success.
  ///
  /// In en, this message translates to:
  /// **'Transfer successfully completed!'**
  String get transfer_success;

  /// No description provided for @transfer_voucher.
  ///
  /// In en, this message translates to:
  /// **'VIEW RECEIPT'**
  String get transfer_voucher;

  /// No description provided for @transfer_new.
  ///
  /// In en, this message translates to:
  /// **'MAKE ANOTHER TRANSFER'**
  String get transfer_new;

  /// No description provided for @page33.
  ///
  /// In en, this message translates to:
  /// **'Transfer Voucher'**
  String get page33;

  /// No description provided for @transfer_receipt.
  ///
  /// In en, this message translates to:
  /// **'RECEIPT'**
  String get transfer_receipt;

  /// No description provided for @transfer_code.
  ///
  /// In en, this message translates to:
  /// **'Code:'**
  String get transfer_code;

  /// No description provided for @transfer_identifier.
  ///
  /// In en, this message translates to:
  /// **'Identifier:'**
  String get transfer_identifier;

  /// No description provided for @transfer_receiver.
  ///
  /// In en, this message translates to:
  /// **'Receiver:'**
  String get transfer_receiver;

  /// No description provided for @transfer_debtor.
  ///
  /// In en, this message translates to:
  /// **'Debtor:'**
  String get transfer_debtor;

  /// No description provided for @transfer_institution.
  ///
  /// In en, this message translates to:
  /// **'Institution:'**
  String get transfer_institution;

  /// No description provided for @transfer_origin.
  ///
  /// In en, this message translates to:
  /// **'Origin:'**
  String get transfer_origin;

  /// No description provided for @transfer_name.
  ///
  /// In en, this message translates to:
  /// **'Name:'**
  String get transfer_name;

  /// No description provided for @transfer_destiny.
  ///
  /// In en, this message translates to:
  /// **'Destination:'**
  String get transfer_destiny;

  /// No description provided for @transfer_authCode.
  ///
  /// In en, this message translates to:
  /// **'AUTHENTICATION CODE'**
  String get transfer_authCode;

  /// No description provided for @page34.
  ///
  /// In en, this message translates to:
  /// **'Groups Screen'**
  String get page34;

  /// No description provided for @groups_screen.
  ///
  /// In en, this message translates to:
  /// **'GROUPS'**
  String get groups_screen;

  /// No description provided for @groups_add.
  ///
  /// In en, this message translates to:
  /// **'ADD NEW GROUP'**
  String get groups_add;

  /// No description provided for @page35.
  ///
  /// In en, this message translates to:
  /// **'Create password'**
  String get page35;

  /// No description provided for @password_create.
  ///
  /// In en, this message translates to:
  /// **'Create your password'**
  String get password_create;

  /// No description provided for @password_need.
  ///
  /// In en, this message translates to:
  /// **'You will need it every time you make a payment,\n so keep it safe and remember it.\n Your password will be a sequence of 6 numbers.'**
  String get password_need;

  /// No description provided for @password_six.
  ///
  /// In en, this message translates to:
  /// **'The password must contain 6 digits'**
  String get password_six;

  /// No description provided for @password_confirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm password'**
  String get password_confirm;

  /// No description provided for @password_again.
  ///
  /// In en, this message translates to:
  /// **'Enter the password again'**
  String get password_again;

  /// No description provided for @password_equals.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get password_equals;

  /// No description provided for @page36.
  ///
  /// In en, this message translates to:
  /// **'My QR Code'**
  String get page36;

  /// No description provided for @myqr_description.
  ///
  /// In en, this message translates to:
  /// **'Use your QR code or share \n the link to receive payments'**
  String get myqr_description;

  /// No description provided for @pix_codeGenerated.
  ///
  /// In en, this message translates to:
  /// **'Code generated successfully!'**
  String get pix_codeGenerated;

  /// No description provided for @pix_dataVisible.
  ///
  /// In en, this message translates to:
  /// **'The data will be visible for reading \n by the payer.'**
  String get pix_dataVisible;

  /// No description provided for @pix_copyLink.
  ///
  /// In en, this message translates to:
  /// **'COPY LINK'**
  String get pix_copyLink;

  /// No description provided for @pix_shareCode.
  ///
  /// In en, this message translates to:
  /// **'SHARE'**
  String get pix_shareCode;

  /// No description provided for @pix_receiveAnother.
  ///
  /// In en, this message translates to:
  /// **'RECEIVE ANOTHER PIX'**
  String get pix_receiveAnother;

  /// No description provided for @pix_saveDevice.
  ///
  /// In en, this message translates to:
  /// **'SAVE TO DEVICE'**
  String get pix_saveDevice;

  /// No description provided for @pix_registerNewKey.
  ///
  /// In en, this message translates to:
  /// **'REGISTER NEW KEY'**
  String get pix_registerNewKey;

  /// No description provided for @pix_choose_new.
  ///
  /// In en, this message translates to:
  /// **'Choose an option'**
  String get pix_choose_new;

  /// No description provided for @pix_registerKey_inform.
  ///
  /// In en, this message translates to:
  /// **'Choose a key to start \n using your Pix:'**
  String get pix_registerKey_inform;

  /// No description provided for @pix_randomKeyRegister.
  ///
  /// In en, this message translates to:
  /// **'Generate Random Key'**
  String get pix_randomKeyRegister;

  /// No description provided for @pix_phone.
  ///
  /// In en, this message translates to:
  /// **'Phone'**
  String get pix_phone;

  /// No description provided for @pix_anotherEmail.
  ///
  /// In en, this message translates to:
  /// **'Another email'**
  String get pix_anotherEmail;

  /// No description provided for @pix_anotherNumber.
  ///
  /// In en, this message translates to:
  /// **'Another number'**
  String get pix_anotherNumber;

  /// No description provided for @pix_valueTo.
  ///
  /// In en, this message translates to:
  /// **'Do you want to make a \n pix in the amount of:'**
  String get pix_valueTo;

  /// No description provided for @pix_day.
  ///
  /// In en, this message translates to:
  /// **'On the day:'**
  String get pix_day;

  /// No description provided for @pix_to.
  ///
  /// In en, this message translates to:
  /// **'To:'**
  String get pix_to;

  /// No description provided for @pix_toBank.
  ///
  /// In en, this message translates to:
  /// **'Bank:'**
  String get pix_toBank;

  /// No description provided for @pix_account.
  ///
  /// In en, this message translates to:
  /// **'Account:'**
  String get pix_account;

  /// No description provided for @pix_fees.
  ///
  /// In en, this message translates to:
  /// **'Fee:'**
  String get pix_fees;

  /// No description provided for @pix_city.
  ///
  /// In en, this message translates to:
  /// **'City:'**
  String get pix_city;

  /// No description provided for @pix_due.
  ///
  /// In en, this message translates to:
  /// **'Due Date:'**
  String get pix_due;

  /// No description provided for @pix_originalAmount.
  ///
  /// In en, this message translates to:
  /// **'Original amount:'**
  String get pix_originalAmount;

  /// No description provided for @statement_title.
  ///
  /// In en, this message translates to:
  /// **'RECEIPT'**
  String get statement_title;

  /// No description provided for @statement_status.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get statement_status;

  /// No description provided for @statement_code.
  ///
  /// In en, this message translates to:
  /// **'Code'**
  String get statement_code;

  /// No description provided for @statement_value.
  ///
  /// In en, this message translates to:
  /// **'Value'**
  String get statement_value;

  /// No description provided for @statement_identifier.
  ///
  /// In en, this message translates to:
  /// **'Identifier'**
  String get statement_identifier;

  /// No description provided for @statement_destiny.
  ///
  /// In en, this message translates to:
  /// **'Destination'**
  String get statement_destiny;

  /// No description provided for @statement_institute.
  ///
  /// In en, this message translates to:
  /// **'Bank'**
  String get statement_institute;

  /// No description provided for @statement_origin.
  ///
  /// In en, this message translates to:
  /// **'Origin'**
  String get statement_origin;

  /// No description provided for @statement_document.
  ///
  /// In en, this message translates to:
  /// **'UserID'**
  String get statement_document;

  /// No description provided for @statement_noData.
  ///
  /// In en, this message translates to:
  /// **'No transactions on the selected date'**
  String get statement_noData;

  /// No description provided for @statement_agency.
  ///
  /// In en, this message translates to:
  /// **'Agency'**
  String get statement_agency;

  /// No description provided for @statement_account.
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get statement_account;

  /// No description provided for @pix_youReceived.
  ///
  /// In en, this message translates to:
  /// **'You received a charge!'**
  String get pix_youReceived;

  /// No description provided for @pix_copyAndPaste.
  ///
  /// In en, this message translates to:
  /// **'PIX COPY AND PASTE'**
  String get pix_copyAndPaste;

  /// No description provided for @pix_pasteCode.
  ///
  /// In en, this message translates to:
  /// **'Paste the code in the field below:'**
  String get pix_pasteCode;

  /// No description provided for @pix_code.
  ///
  /// In en, this message translates to:
  /// **'Code'**
  String get pix_code;

  /// No description provided for @pix_success.
  ///
  /// In en, this message translates to:
  /// **'Pix successfully completed!'**
  String get pix_success;

  /// No description provided for @display1.
  ///
  /// In en, this message translates to:
  /// **'Email Confirmation Display'**
  String get display1;

  /// No description provided for @email_confirm.
  ///
  /// In en, this message translates to:
  /// **'Email Confirmation'**
  String get email_confirm;

  /// No description provided for @email_send_code.
  ///
  /// In en, this message translates to:
  /// **'We have sent a code to the registered email'**
  String get email_send_code;

  /// No description provided for @email_perhaps.
  ///
  /// In en, this message translates to:
  /// **'If you haven\'t received the email, please check \n your junk email or spam folder'**
  String get email_perhaps;

  /// No description provided for @email_insert_code.
  ///
  /// In en, this message translates to:
  /// **'INSERT CODE HERE'**
  String get email_insert_code;

  /// No description provided for @email_send.
  ///
  /// In en, this message translates to:
  /// **'SEND CODE'**
  String get email_send;

  /// No description provided for @password_register_cnpj.
  ///
  /// In en, this message translates to:
  /// **'CNPJ password registration'**
  String get password_register_cnpj;

  /// No description provided for @email_sendCode.
  ///
  /// In en, this message translates to:
  /// **'Email confirmation'**
  String get email_sendCode;

  /// No description provided for @password_success.
  ///
  /// In en, this message translates to:
  /// **'Password Registered!'**
  String get password_success;

  /// No description provided for @password_content.
  ///
  /// In en, this message translates to:
  /// **'Your 6-digit password for the app has been successfully registered.'**
  String get password_content;

  /// No description provided for @display2.
  ///
  /// In en, this message translates to:
  /// **'Display Confirmação de Telefone'**
  String get display2;

  /// No description provided for @phone_confirm.
  ///
  /// In en, this message translates to:
  /// **'Phone Confirmation'**
  String get phone_confirm;

  /// No description provided for @balance.
  ///
  /// In en, this message translates to:
  /// **'Balance Status'**
  String get balance;

  /// No description provided for @balance_available.
  ///
  /// In en, this message translates to:
  /// **'Available Balance'**
  String get balance_available;

  /// No description provided for @balance_transational.
  ///
  /// In en, this message translates to:
  /// **'Savings Balance'**
  String get balance_transational;

  /// No description provided for @balance_insufficient.
  ///
  /// In en, this message translates to:
  /// **'Insufficient Balance'**
  String get balance_insufficient;

  /// No description provided for @home_view.
  ///
  /// In en, this message translates to:
  /// **'Home Buttons'**
  String get home_view;

  /// No description provided for @home_icon.
  ///
  /// In en, this message translates to:
  /// **'HOME'**
  String get home_icon;

  /// No description provided for @card_icon.
  ///
  /// In en, this message translates to:
  /// **'CARDS'**
  String get card_icon;

  /// No description provided for @statement_icon.
  ///
  /// In en, this message translates to:
  /// **'STATEMENT'**
  String get statement_icon;

  /// No description provided for @perfil_icon.
  ///
  /// In en, this message translates to:
  /// **'ACCOUNT'**
  String get perfil_icon;

  /// No description provided for @home_groups.
  ///
  /// In en, this message translates to:
  /// **'Groups'**
  String get home_groups;

  /// No description provided for @home_economy.
  ///
  /// In en, this message translates to:
  /// **'Savings'**
  String get home_economy;

  /// No description provided for @home_credit.
  ///
  /// In en, this message translates to:
  /// **'Credit'**
  String get home_credit;

  /// No description provided for @pix_component.
  ///
  /// In en, this message translates to:
  /// **'Pix Balance'**
  String get pix_component;

  /// No description provided for @pix_statement.
  ///
  /// In en, this message translates to:
  /// **'PIX STATEMENT'**
  String get pix_statement;

  /// No description provided for @pix_myKeys.
  ///
  /// In en, this message translates to:
  /// **'MY KEYS'**
  String get pix_myKeys;

  /// No description provided for @no_groups.
  ///
  /// In en, this message translates to:
  /// **'No group created.'**
  String get no_groups;

  /// No description provided for @group_created_in.
  ///
  /// In en, this message translates to:
  /// **'Created on:'**
  String get group_created_in;

  /// No description provided for @group_add_new.
  ///
  /// In en, this message translates to:
  /// **'Add New Group'**
  String get group_add_new;

  /// No description provided for @group_cancelled.
  ///
  /// In en, this message translates to:
  /// **'Cancelled Groups'**
  String get group_cancelled;

  /// No description provided for @group_active.
  ///
  /// In en, this message translates to:
  /// **'Active Groups'**
  String get group_active;

  /// No description provided for @group_activation_pending.
  ///
  /// In en, this message translates to:
  /// **'Activation Pending'**
  String get group_activation_pending;

  /// No description provided for @group_mutual_available.
  ///
  /// In en, this message translates to:
  /// **'Available Credit'**
  String get group_mutual_available;

  /// No description provided for @group_information.
  ///
  /// In en, this message translates to:
  /// **'INFORMATION'**
  String get group_information;

  /// No description provided for @group_members.
  ///
  /// In en, this message translates to:
  /// **'MEMBERS'**
  String get group_members;

  /// No description provided for @group_contribution.
  ///
  /// In en, this message translates to:
  /// **'Total Group Contribution'**
  String get group_contribution;

  /// No description provided for @group_att.
  ///
  /// In en, this message translates to:
  /// **'Updated on date:'**
  String get group_att;

  /// No description provided for @group_periodicity.
  ///
  /// In en, this message translates to:
  /// **'Periodicity'**
  String get group_periodicity;

  /// No description provided for @group_member_value.
  ///
  /// In en, this message translates to:
  /// **'Value per Member'**
  String get group_member_value;

  /// No description provided for @group_crated_for.
  ///
  /// In en, this message translates to:
  /// **'Created by'**
  String get group_crated_for;

  /// No description provided for @group_initial_date.
  ///
  /// In en, this message translates to:
  /// **'Start Date'**
  String get group_initial_date;

  /// No description provided for @group_final_date.
  ///
  /// In en, this message translates to:
  /// **'End Date'**
  String get group_final_date;

  /// No description provided for @group_my_contributions.
  ///
  /// In en, this message translates to:
  /// **'My Contributions'**
  String get group_my_contributions;

  /// No description provided for @group_detail.
  ///
  /// In en, this message translates to:
  /// **'Details'**
  String get group_detail;

  /// No description provided for @group_monthly.
  ///
  /// In en, this message translates to:
  /// **'Monthly'**
  String get group_monthly;

  /// No description provided for @group_bimonthly.
  ///
  /// In en, this message translates to:
  /// **'Bimonthly'**
  String get group_bimonthly;

  /// No description provided for @group_biweekly.
  ///
  /// In en, this message translates to:
  /// **'Biweekly'**
  String get group_biweekly;

  /// No description provided for @group_annual.
  ///
  /// In en, this message translates to:
  /// **'Annual'**
  String get group_annual;

  /// No description provided for @group_weekly.
  ///
  /// In en, this message translates to:
  /// **'Weekly'**
  String get group_weekly;

  /// No description provided for @group_contribution_individual.
  ///
  /// In en, this message translates to:
  /// **'Contribution'**
  String get group_contribution_individual;

  /// No description provided for @group_pending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get group_pending;

  /// No description provided for @group_open.
  ///
  /// In en, this message translates to:
  /// **'Open'**
  String get group_open;

  /// No description provided for @group_paid.
  ///
  /// In en, this message translates to:
  /// **'Paid'**
  String get group_paid;

  /// No description provided for @group_payment.
  ///
  /// In en, this message translates to:
  /// **'Payment Forecast'**
  String get group_payment;

  /// No description provided for @group_paid_date.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get group_paid_date;

  /// No description provided for @group_will_pay.
  ///
  /// In en, this message translates to:
  /// **'YOU WILL PAY'**
  String get group_will_pay;

  /// No description provided for @group_you_paid.
  ///
  /// In en, this message translates to:
  /// **'YOU PAID'**
  String get group_you_paid;

  /// No description provided for @group_day.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get group_day;

  /// No description provided for @group_installment.
  ///
  /// In en, this message translates to:
  /// **'Installment'**
  String get group_installment;

  /// No description provided for @group_group.
  ///
  /// In en, this message translates to:
  /// **'Group'**
  String get group_group;

  /// No description provided for @group_name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get group_name;

  /// No description provided for @group_account.
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get group_account;

  /// No description provided for @group_fees.
  ///
  /// In en, this message translates to:
  /// **'Fee'**
  String get group_fees;

  /// No description provided for @group_pay.
  ///
  /// In en, this message translates to:
  /// **'Pay'**
  String get group_pay;

  /// No description provided for @group_new.
  ///
  /// In en, this message translates to:
  /// **'NEW GROUP'**
  String get group_new;

  /// No description provided for @group_new_name.
  ///
  /// In en, this message translates to:
  /// **'Group Name'**
  String get group_new_name;

  /// No description provided for @group_member.
  ///
  /// In en, this message translates to:
  /// **'I\'m a Member'**
  String get group_member;

  /// No description provided for @group_data.
  ///
  /// In en, this message translates to:
  /// **'General Data'**
  String get group_data;

  /// No description provided for @group_credit_data.
  ///
  /// In en, this message translates to:
  /// **'Credit Data'**
  String get group_credit_data;

  /// No description provided for @group_interest.
  ///
  /// In en, this message translates to:
  /// **'Interest'**
  String get group_interest;

  /// No description provided for @group_installments.
  ///
  /// In en, this message translates to:
  /// **'Installments Quantity'**
  String get group_installments;

  /// No description provided for @group_priority.
  ///
  /// In en, this message translates to:
  /// **'Priority'**
  String get group_priority;

  /// No description provided for @group_late_fees.
  ///
  /// In en, this message translates to:
  /// **'Late Fees'**
  String get group_late_fees;

  /// No description provided for @group_billing.
  ///
  /// In en, this message translates to:
  /// **'Billing'**
  String get group_billing;

  /// No description provided for @group_economy_data.
  ///
  /// In en, this message translates to:
  /// **'Savings Account'**
  String get group_economy_data;

  /// No description provided for @group_period.
  ///
  /// In en, this message translates to:
  /// **'Period'**
  String get group_period;

  /// No description provided for @group_period_value.
  ///
  /// In en, this message translates to:
  /// **'Value per Period'**
  String get group_period_value;

  /// No description provided for @group_contributions_quantity.
  ///
  /// In en, this message translates to:
  /// **'Contributions Quantity'**
  String get group_contributions_quantity;

  /// No description provided for @group_members_quantity.
  ///
  /// In en, this message translates to:
  /// **'Members Quantity'**
  String get group_members_quantity;

  /// No description provided for @group_value_per_member.
  ///
  /// In en, this message translates to:
  /// **'Value per Member'**
  String get group_value_per_member;

  /// No description provided for @group_add_members.
  ///
  /// In en, this message translates to:
  /// **'Add Members'**
  String get group_add_members;

  /// No description provided for @group_search_details.
  ///
  /// In en, this message translates to:
  /// **'Search by document (UserID) to \n add members and send invitations.'**
  String get group_search_details;

  /// No description provided for @group_search.
  ///
  /// In en, this message translates to:
  /// **'Search by document'**
  String get group_search;

  /// No description provided for @group_invited.
  ///
  /// In en, this message translates to:
  /// **'Invited People'**
  String get group_invited;

  /// No description provided for @group_g.
  ///
  /// In en, this message translates to:
  /// **'Group'**
  String get group_g;

  /// No description provided for @group_created.
  ///
  /// In en, this message translates to:
  /// **'Group Created'**
  String get group_created;

  /// No description provided for @group_created_success.
  ///
  /// In en, this message translates to:
  /// **'Group created successfully!'**
  String get group_created_success;

  /// No description provided for @group_wait.
  ///
  /// In en, this message translates to:
  /// **'Please wait for members to accept your invitation.\n You can track your group\'s status \n in the Groups menu.'**
  String get group_wait;

  /// No description provided for @group_see.
  ///
  /// In en, this message translates to:
  /// **'VIEW GROUPS'**
  String get group_see;

  /// No description provided for @financial_info.
  ///
  /// In en, this message translates to:
  /// **'Customer Information'**
  String get financial_info;

  /// No description provided for @financial_inf_att.
  ///
  /// In en, this message translates to:
  /// **'Update Date'**
  String get financial_inf_att;

  /// No description provided for @financial_income.
  ///
  /// In en, this message translates to:
  /// **'Family Income (R\$ / MONTH)'**
  String get financial_income;

  /// No description provided for @financial_family.
  ///
  /// In en, this message translates to:
  /// **'Family Size'**
  String get financial_family;

  /// No description provided for @financial_house.
  ///
  /// In en, this message translates to:
  /// **'House'**
  String get financial_house;

  /// No description provided for @financial_transport.
  ///
  /// In en, this message translates to:
  /// **'Transportation'**
  String get financial_transport;

  /// No description provided for @financial_expenses.
  ///
  /// In en, this message translates to:
  /// **'Costs (R\$)'**
  String get financial_expenses;

  /// No description provided for @financial_utilities.
  ///
  /// In en, this message translates to:
  /// **'Utilities'**
  String get financial_utilities;

  /// No description provided for @financial_another_expenses.
  ///
  /// In en, this message translates to:
  /// **'Other Expenses'**
  String get financial_another_expenses;

  /// No description provided for @active.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get active;

  /// No description provided for @pending.
  ///
  /// In en, this message translates to:
  /// **'Activation Pending'**
  String get pending;

  /// No description provided for @available.
  ///
  /// In en, this message translates to:
  /// **'Available Credit'**
  String get available;

  /// No description provided for @inactive.
  ///
  /// In en, this message translates to:
  /// **'Inactive'**
  String get inactive;

  /// No description provided for @revenue_generation.
  ///
  /// In en, this message translates to:
  /// **'Revenue Generation'**
  String get revenue_generation;

  /// No description provided for @health.
  ///
  /// In en, this message translates to:
  /// **'Health'**
  String get health;

  /// No description provided for @repairs.
  ///
  /// In en, this message translates to:
  /// **'Repairs'**
  String get repairs;

  /// No description provided for @emergency_money.
  ///
  /// In en, this message translates to:
  /// **'Emergency Money'**
  String get emergency_money;

  /// No description provided for @purchases.
  ///
  /// In en, this message translates to:
  /// **'Purchases'**
  String get purchases;

  /// No description provided for @group_accept.
  ///
  /// In en, this message translates to:
  /// **'Accept'**
  String get group_accept;

  /// No description provided for @group_reject.
  ///
  /// In en, this message translates to:
  /// **'Reject'**
  String get group_reject;

  /// No description provided for @available_char.
  ///
  /// In en, this message translates to:
  /// **'available characters'**
  String get available_char;

  /// No description provided for @button.
  ///
  /// In en, this message translates to:
  /// **'Buttons'**
  String get button;

  /// No description provided for @dialogErro.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get dialogErro;

  /// No description provided for @buttonDialogClose.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get buttonDialogClose;

  /// No description provided for @buttonEnter.
  ///
  /// In en, this message translates to:
  /// **'ENTER'**
  String get buttonEnter;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'CONTINUE'**
  String get next;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @yes.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get yes;

  /// No description provided for @no.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get no;

  /// No description provided for @understood.
  ///
  /// In en, this message translates to:
  /// **'UNDERSTOOD'**
  String get understood;

  /// No description provided for @password_insert.
  ///
  /// In en, this message translates to:
  /// **'Enter your password'**
  String get password_insert;

  /// No description provided for @confirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirm;

  /// No description provided for @proceed.
  ///
  /// In en, this message translates to:
  /// **'PROCEED'**
  String get proceed;

  /// No description provided for @register_button.
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get register_button;

  /// No description provided for @off.
  ///
  /// In en, this message translates to:
  /// **'of'**
  String get off;

  /// No description provided for @credit_credit.
  ///
  /// In en, this message translates to:
  /// **'Credit'**
  String get credit_credit;

  /// No description provided for @credit_dont.
  ///
  /// In en, this message translates to:
  /// **'You haven\'t requested any credit yet'**
  String get credit_dont;

  /// No description provided for @credit_enter.
  ///
  /// In en, this message translates to:
  /// **'Enter your active groups to request a credit'**
  String get credit_enter;

  /// No description provided for @credit_groups.
  ///
  /// In en, this message translates to:
  /// **'VIEW GROUPS'**
  String get credit_groups;

  /// No description provided for @credit_contribution.
  ///
  /// In en, this message translates to:
  /// **'Your contribution'**
  String get credit_contribution;

  /// No description provided for @credit_max_loan.
  ///
  /// In en, this message translates to:
  /// **'Maximum loan'**
  String get credit_max_loan;

  /// No description provided for @credit_request_value.
  ///
  /// In en, this message translates to:
  /// **'What amount do you want to request?'**
  String get credit_request_value;

  /// No description provided for @credit_request_over.
  ///
  /// In en, this message translates to:
  /// **'Amount exceeds the maximum available'**
  String get credit_request_over;

  /// No description provided for @credit_installment.
  ///
  /// In en, this message translates to:
  /// **'Number of installments'**
  String get credit_installment;

  /// No description provided for @credit_installment_over.
  ///
  /// In en, this message translates to:
  /// **'Number of installments exceeds the maximum'**
  String get credit_installment_over;

  /// No description provided for @credit_request.
  ///
  /// In en, this message translates to:
  /// **'Request Credit'**
  String get credit_request;

  /// No description provided for @credit_simulation.
  ///
  /// In en, this message translates to:
  /// **'Credit Simulation'**
  String get credit_simulation;

  /// No description provided for @credit_you_receive.
  ///
  /// In en, this message translates to:
  /// **'You will receive'**
  String get credit_you_receive;

  /// No description provided for @credit_paid.
  ///
  /// In en, this message translates to:
  /// **'and will pay'**
  String get credit_paid;

  /// No description provided for @credit_group.
  ///
  /// In en, this message translates to:
  /// **'Group'**
  String get credit_group;

  /// No description provided for @credit_pay_total.
  ///
  /// In en, this message translates to:
  /// **'Total to pay'**
  String get credit_pay_total;

  /// No description provided for @credit_fee_value.
  ///
  /// In en, this message translates to:
  /// **'Interest'**
  String get credit_fee_value;

  /// No description provided for @credit_fees.
  ///
  /// In en, this message translates to:
  /// **'Interest Rate'**
  String get credit_fees;

  /// No description provided for @credit_services.
  ///
  /// In en, this message translates to:
  /// **'Services'**
  String get credit_services;

  /// No description provided for @credit_monthly.
  ///
  /// In en, this message translates to:
  /// **'monthly'**
  String get credit_monthly;

  /// No description provided for @credit_detail.
  ///
  /// In en, this message translates to:
  /// **'Credit Details'**
  String get credit_detail;

  /// No description provided for @credit_request_of.
  ///
  /// In en, this message translates to:
  /// **' wants a credit of'**
  String get credit_request_of;

  /// No description provided for @credit_payment.
  ///
  /// In en, this message translates to:
  /// **'Payment'**
  String get credit_payment;

  /// No description provided for @credit_fees_receive.
  ///
  /// In en, this message translates to:
  /// **'Interest to receive'**
  String get credit_fees_receive;

  /// No description provided for @credit_last_payment.
  ///
  /// In en, this message translates to:
  /// **'Last payment'**
  String get credit_last_payment;

  /// No description provided for @credit_agree.
  ///
  /// In en, this message translates to:
  /// **'Do you agree to the credit?'**
  String get credit_agree;

  /// No description provided for @credit_reject.
  ///
  /// In en, this message translates to:
  /// **'Reject'**
  String get credit_reject;

  /// No description provided for @credit_accept.
  ///
  /// In en, this message translates to:
  /// **'Accept'**
  String get credit_accept;

  /// No description provided for @credit_vote.
  ///
  /// In en, this message translates to:
  /// **'Your vote for the credit \n has been recorded!'**
  String get credit_vote;

  /// No description provided for @credit_voted_details.
  ///
  /// In en, this message translates to:
  /// **'In a few hours, you will receive the final result of the credit vote.'**
  String get credit_voted_details;

  /// No description provided for @credit_requested.
  ///
  /// In en, this message translates to:
  /// **'Credit requested!'**
  String get credit_requested;

  /// No description provided for @credit_request_wait.
  ///
  /// In en, this message translates to:
  /// **'Please wait for members to accept your credit. \nYou will receive a notification with the response to your credit.'**
  String get credit_request_wait;

  /// No description provided for @savings.
  ///
  /// In en, this message translates to:
  /// **'Savings'**
  String get savings;

  /// No description provided for @facilitator.
  ///
  /// In en, this message translates to:
  /// **'Exclusive Facilitator Role'**
  String get facilitator;

  /// No description provided for @facilitator_explain.
  ///
  /// In en, this message translates to:
  /// **'Group creation is an exclusive function of the Facilitators within Miban4. Please contact your Facilitator to request group creation. \n\nVisit our website for further details.'**
  String get facilitator_explain;

  /// No description provided for @site.
  ///
  /// In en, this message translates to:
  /// **'VISIT SITE'**
  String get site;

  /// No description provided for @popScope.
  ///
  /// In en, this message translates to:
  /// **'WillPopScope Widget'**
  String get popScope;

  /// No description provided for @exit_page.
  ///
  /// In en, this message translates to:
  /// **'Do you really want to exit?'**
  String get exit_page;

  /// No description provided for @resume_register.
  ///
  /// In en, this message translates to:
  /// **'You can continue the registration from where you left off.'**
  String get resume_register;

  /// No description provided for @validators.
  ///
  /// In en, this message translates to:
  /// **'Validators'**
  String get validators;

  /// No description provided for @validator_empty.
  ///
  /// In en, this message translates to:
  /// **'This field is required'**
  String get validator_empty;

  /// No description provided for @validator_valid_document.
  ///
  /// In en, this message translates to:
  /// **'The document must contain 11 characters'**
  String get validator_valid_document;

  /// No description provided for @validator_six_char.
  ///
  /// In en, this message translates to:
  /// **'The password contains 6 characters'**
  String get validator_six_char;

  /// No description provided for @validator_valid_email.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid email'**
  String get validator_valid_email;

  /// No description provided for @validator_password_confirm.
  ///
  /// In en, this message translates to:
  /// **'The passwords do not match'**
  String get validator_password_confirm;

  /// No description provided for @pep.
  ///
  /// In en, this message translates to:
  /// **'Individuals who have held, in the last 5 (five) years, relevant public positions, jobs, or functions in Brazil or in other countries, territories, and foreign dependencies, as well as their representatives, family members, and other individuals in their close relationships.'**
  String get pep;

  /// No description provided for @wait.
  ///
  /// In en, this message translates to:
  /// **'Please wait while we complete\n your transfer.'**
  String get wait;

  /// No description provided for @notifications.
  ///
  /// In en, this message translates to:
  /// **'NOTIFICATIONS'**
  String get notifications;

  /// No description provided for @dateRanger.
  ///
  /// In en, this message translates to:
  /// **'Date Ranger Picker'**
  String get dateRanger;

  /// No description provided for @dateSave.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get dateSave;

  /// No description provided for @dialog_success.
  ///
  /// In en, this message translates to:
  /// **'Success'**
  String get dialog_success;

  /// No description provided for @dialog_error.
  ///
  /// In en, this message translates to:
  /// **'Message'**
  String get dialog_error;

  /// No description provided for @dialog_someError.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong'**
  String get dialog_someError;

  /// No description provided for @dialog_progress.
  ///
  /// In en, this message translates to:
  /// **'Wait'**
  String get dialog_progress;

  /// No description provided for @dialog_password_incorrect.
  ///
  /// In en, this message translates to:
  /// **'Incorrect Password'**
  String get dialog_password_incorrect;

  /// No description provided for @dialog_payment.
  ///
  /// In en, this message translates to:
  /// **'Payment successfully completed!'**
  String get dialog_payment;

  /// No description provided for @group_no_group.
  ///
  /// In en, this message translates to:
  /// **'There are no groups added.'**
  String get group_no_group;

  /// No description provided for @group_no_group_detail.
  ///
  /// In en, this message translates to:
  /// **'Add your first group and save together with the community.'**
  String get group_no_group_detail;

  /// No description provided for @address_type_own.
  ///
  /// In en, this message translates to:
  /// **'Own'**
  String get address_type_own;

  /// No description provided for @address_type_rent.
  ///
  /// In en, this message translates to:
  /// **'Rent'**
  String get address_type_rent;

  /// No description provided for @address_type_financed.
  ///
  /// In en, this message translates to:
  /// **'Financed'**
  String get address_type_financed;

  /// No description provided for @address_type_company.
  ///
  /// In en, this message translates to:
  /// **'Company'**
  String get address_type_company;

  /// No description provided for @address_type_parents.
  ///
  /// In en, this message translates to:
  /// **'with parents'**
  String get address_type_parents;

  /// No description provided for @gender_male.
  ///
  /// In en, this message translates to:
  /// **'Male'**
  String get gender_male;

  /// No description provided for @gender_female.
  ///
  /// In en, this message translates to:
  /// **'Female'**
  String get gender_female;

  /// No description provided for @gender_another.
  ///
  /// In en, this message translates to:
  /// **'Another'**
  String get gender_another;

  /// No description provided for @gender_notDefined.
  ///
  /// In en, this message translates to:
  /// **'Not Defined'**
  String get gender_notDefined;

  /// No description provided for @marital_status_single.
  ///
  /// In en, this message translates to:
  /// **'Single'**
  String get marital_status_single;

  /// No description provided for @marital_status_married.
  ///
  /// In en, this message translates to:
  /// **'Married'**
  String get marital_status_married;

  /// No description provided for @marital_status_legally_separated.
  ///
  /// In en, this message translates to:
  /// **'Legally Separated'**
  String get marital_status_legally_separated;

  /// No description provided for @marital_status_widowed.
  ///
  /// In en, this message translates to:
  /// **'Widowed'**
  String get marital_status_widowed;

  /// No description provided for @marital_status_cohabitant.
  ///
  /// In en, this message translates to:
  /// **'Cohabitant'**
  String get marital_status_cohabitant;

  /// No description provided for @marital_status_separated.
  ///
  /// In en, this message translates to:
  /// **'Separated'**
  String get marital_status_separated;

  /// No description provided for @nationality_brazilian.
  ///
  /// In en, this message translates to:
  /// **'Brazilian'**
  String get nationality_brazilian;

  /// No description provided for @nationality_foreigner.
  ///
  /// In en, this message translates to:
  /// **'Foreigner'**
  String get nationality_foreigner;

  /// No description provided for @pix_send.
  ///
  /// In en, this message translates to:
  /// **'Pix Sent'**
  String get pix_send;

  /// No description provided for @pix_received.
  ///
  /// In en, this message translates to:
  /// **'Pix Received'**
  String get pix_received;

  /// No description provided for @transfer_send.
  ///
  /// In en, this message translates to:
  /// **'Transfer Sent'**
  String get transfer_send;

  /// No description provided for @transfer_received.
  ///
  /// In en, this message translates to:
  /// **'Transfer Received'**
  String get transfer_received;

  /// No description provided for @continue_barcode.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continue_barcode;

  /// No description provided for @dont_have_contribution.
  ///
  /// In en, this message translates to:
  /// **'There are no contributions to be listed.'**
  String get dont_have_contribution;

  /// No description provided for @dont_have_credit.
  ///
  /// In en, this message translates to:
  /// **'There are no credit installments to be listed.'**
  String get dont_have_credit;

  /// No description provided for @credit_paid_installment.
  ///
  /// In en, this message translates to:
  /// **'Paid Amount'**
  String get credit_paid_installment;

  /// No description provided for @voucher_group_payment.
  ///
  /// In en, this message translates to:
  /// **'Payment'**
  String get voucher_group_payment;

  /// No description provided for @voucher_group_code_payment.
  ///
  /// In en, this message translates to:
  /// **'Code:'**
  String get voucher_group_code_payment;

  /// No description provided for @voucher_group_value_payment.
  ///
  /// In en, this message translates to:
  /// **'Value:'**
  String get voucher_group_value_payment;

  /// No description provided for @voucher_origin.
  ///
  /// In en, this message translates to:
  /// **'Origin'**
  String get voucher_origin;

  /// No description provided for @voucher_destination.
  ///
  /// In en, this message translates to:
  /// **'Destination'**
  String get voucher_destination;

  /// No description provided for @savings_created_at.
  ///
  /// In en, this message translates to:
  /// **'Created at: '**
  String get savings_created_at;

  /// No description provided for @savings_savings.
  ///
  /// In en, this message translates to:
  /// **'Savings: \$'**
  String get savings_savings;

  /// No description provided for @savings_balance.
  ///
  /// In en, this message translates to:
  /// **'Savings Balance'**
  String get savings_balance;

  /// No description provided for @talk_to_us.
  ///
  /// In en, this message translates to:
  /// **'Talk to us'**
  String get talk_to_us;

  /// No description provided for @credit_approved.
  ///
  /// In en, this message translates to:
  /// **'Your credit has been approved'**
  String get credit_approved;

  /// No description provided for @name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get name;

  /// No description provided for @document.
  ///
  /// In en, this message translates to:
  /// **'UserID'**
  String get document;

  /// No description provided for @some_error.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong, please try again.'**
  String get some_error;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to log out?'**
  String get logout;

  /// No description provided for @logout_exit.
  ///
  /// In en, this message translates to:
  /// **'Log Out'**
  String get logout_exit;

  /// No description provided for @message.
  ///
  /// In en, this message translates to:
  /// **'Message'**
  String get message;

  /// No description provided for @pep_yes.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get pep_yes;

  /// No description provided for @pep_no.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get pep_no;

  /// No description provided for @invite_content.
  ///
  /// In en, this message translates to:
  /// **'It\'s necessary to invite the maximum number of members to proceed'**
  String get invite_content;

  /// No description provided for @house_own.
  ///
  /// In en, this message translates to:
  /// **'Own'**
  String get house_own;

  /// No description provided for @house_rent.
  ///
  /// In en, this message translates to:
  /// **'Rent'**
  String get house_rent;

  /// No description provided for @house_financed.
  ///
  /// In en, this message translates to:
  /// **'Funded'**
  String get house_financed;

  /// No description provided for @transport_car_own.
  ///
  /// In en, this message translates to:
  /// **'Own Car'**
  String get transport_car_own;

  /// No description provided for @transport_motor_own.
  ///
  /// In en, this message translates to:
  /// **'Own Motorcycle'**
  String get transport_motor_own;

  /// No description provided for @transport_financed_car.
  ///
  /// In en, this message translates to:
  /// **'Financed Car'**
  String get transport_financed_car;

  /// No description provided for @transport_financed_motor.
  ///
  /// In en, this message translates to:
  /// **'Financed Motorcycle'**
  String get transport_financed_motor;

  /// No description provided for @transport_public.
  ///
  /// In en, this message translates to:
  /// **'Public'**
  String get transport_public;

  /// No description provided for @group_details.
  ///
  /// In en, this message translates to:
  /// **'Group Details'**
  String get group_details;

  /// No description provided for @credit_details.
  ///
  /// In en, this message translates to:
  /// **'Credit Details'**
  String get credit_details;

  /// No description provided for @credit_vote_title_dialog.
  ///
  /// In en, this message translates to:
  /// **'Vote Confirmation'**
  String get credit_vote_title_dialog;

  /// No description provided for @credit_vote_dialog.
  ///
  /// In en, this message translates to:
  /// **'Do you want to confirm your vote'**
  String get credit_vote_dialog;

  /// No description provided for @credit_vote_accept.
  ///
  /// In en, this message translates to:
  /// **'accepting the credit'**
  String get credit_vote_accept;

  /// No description provided for @credit_vote_reject.
  ///
  /// In en, this message translates to:
  /// **'rejecting the credit'**
  String get credit_vote_reject;

  /// No description provided for @payment_link_generated.
  ///
  /// In en, this message translates to:
  /// **'Payment link generated.'**
  String get payment_link_generated;

  /// No description provided for @payment_link_receive.
  ///
  /// In en, this message translates to:
  /// **'Total to receive'**
  String get payment_link_receive;

  /// No description provided for @payment_link_share.
  ///
  /// In en, this message translates to:
  /// **'Share to start receiving'**
  String get payment_link_share;

  /// No description provided for @payment_link_share_link.
  ///
  /// In en, this message translates to:
  /// **'Share Link'**
  String get payment_link_share_link;

  /// No description provided for @payment_link_copy_link.
  ///
  /// In en, this message translates to:
  /// **'Copy Link'**
  String get payment_link_copy_link;

  /// No description provided for @bank_choose.
  ///
  /// In en, this message translates to:
  /// **'Choose a bank'**
  String get bank_choose;

  /// No description provided for @bank_search.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get bank_search;

  /// No description provided for @bank_agency.
  ///
  /// In en, this message translates to:
  /// **'Agency number (without digit)'**
  String get bank_agency;

  /// No description provided for @bank_account_type.
  ///
  /// In en, this message translates to:
  /// **'Account type'**
  String get bank_account_type;

  /// No description provided for @bank_account_number.
  ///
  /// In en, this message translates to:
  /// **'Account number'**
  String get bank_account_number;

  /// No description provided for @bank_account_digit.
  ///
  /// In en, this message translates to:
  /// **'Account digit'**
  String get bank_account_digit;

  /// No description provided for @bank_add_account.
  ///
  /// In en, this message translates to:
  /// **'Add Account'**
  String get bank_add_account;

  /// No description provided for @bank_agency_digit.
  ///
  /// In en, this message translates to:
  /// **'Agency digit'**
  String get bank_agency_digit;

  /// No description provided for @transactional_statement.
  ///
  /// In en, this message translates to:
  /// **'Transactional'**
  String get transactional_statement;

  /// No description provided for @savings_statement.
  ///
  /// In en, this message translates to:
  /// **'Savings'**
  String get savings_statement;

  /// No description provided for @account_waiting.
  ///
  /// In en, this message translates to:
  /// **'Your account is not active yet'**
  String get account_waiting;

  /// No description provided for @account_savings_waiting.
  ///
  /// In en, this message translates to:
  /// **'Your savings account is not active yet'**
  String get account_savings_waiting;

  /// No description provided for @onboarding_confirm_selfie.
  ///
  /// In en, this message translates to:
  /// **'Did the photo turn out well? Is the text clear? The image should not contain reflections.'**
  String get onboarding_confirm_selfie;

  /// No description provided for @onboarding_confirm_again.
  ///
  /// In en, this message translates to:
  /// **'Take another'**
  String get onboarding_confirm_again;

  /// No description provided for @onboarding_confirm_cool.
  ///
  /// In en, this message translates to:
  /// **'Looks good'**
  String get onboarding_confirm_cool;

  /// No description provided for @transfer_add_person.
  ///
  /// In en, this message translates to:
  /// **'Add Person'**
  String get transfer_add_person;

  /// No description provided for @share.
  ///
  /// In en, this message translates to:
  /// **'Share'**
  String get share;

  /// No description provided for @unavailable.
  ///
  /// In en, this message translates to:
  /// **'Temporarily unavailable'**
  String get unavailable;

  /// No description provided for @all_paid.
  ///
  /// In en, this message translates to:
  /// **'No transactions pending.'**
  String get all_paid;

  /// No description provided for @credit_installment_delayed.
  ///
  /// In en, this message translates to:
  /// **'Installment delayed. Additional tax and interests applied.'**
  String get credit_installment_delayed;

  /// No description provided for @first_installment.
  ///
  /// In en, this message translates to:
  /// **'Warning! The oldest value must be paid firstly!'**
  String get first_installment;

  /// No description provided for @credit_next_payment.
  ///
  /// In en, this message translates to:
  /// **'Next Payment'**
  String get credit_next_payment;

  /// No description provided for @credit_all_installments_paid.
  ///
  /// In en, this message translates to:
  /// **'All instalments paid'**
  String get credit_all_installments_paid;

  /// No description provided for @qr_code_error.
  ///
  /// In en, this message translates to:
  /// **'Error reading QR Code, please try again.'**
  String get qr_code_error;

  /// No description provided for @qr_code_try_again.
  ///
  /// In en, this message translates to:
  /// **'Try again'**
  String get qr_code_try_again;

  /// No description provided for @pix_limits_p2p.
  ///
  /// In en, this message translates to:
  /// **'PIX to individual accounts'**
  String get pix_limits_p2p;

  /// No description provided for @pix_limits_p2b.
  ///
  /// In en, this message translates to:
  /// **'PIX to business accounts'**
  String get pix_limits_p2b;

  /// No description provided for @pix_limits_same_person.
  ///
  /// In en, this message translates to:
  /// **'PIX to accounts with the same ownership'**
  String get pix_limits_same_person;

  /// No description provided for @language_portuguese.
  ///
  /// In en, this message translates to:
  /// **'Portuguese'**
  String get language_portuguese;

  /// No description provided for @language_english.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get language_english;

  /// No description provided for @language_spanish.
  ///
  /// In en, this message translates to:
  /// **'Spanish'**
  String get language_spanish;

  /// No description provided for @block_access.
  ///
  /// In en, this message translates to:
  /// **'Access blocked due to payment delay!'**
  String get block_access;

  /// No description provided for @success.
  ///
  /// In en, this message translates to:
  /// **'Success'**
  String get success;

  /// No description provided for @validator_isEmpty.
  ///
  /// In en, this message translates to:
  /// **'Fill in the field'**
  String get validator_isEmpty;

  /// No description provided for @codeLang.
  ///
  /// In en, this message translates to:
  /// **'en'**
  String get codeLang;

  /// No description provided for @version.
  ///
  /// In en, this message translates to:
  /// **'Versão 5.5.0 - Release (160)'**
  String get version;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'es', 'pt'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'pt':
      return AppLocalizationsPt();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
