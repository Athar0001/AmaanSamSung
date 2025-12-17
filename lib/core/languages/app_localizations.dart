import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'languages/app_localizations.dart';
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
    Locale('ar'),
    Locale('en'),
  ];

  /// No description provided for @continueLabel.
  ///
  /// In ar, this message translates to:
  /// **'متابعة'**
  String get continueLabel;

  /// No description provided for @email.
  ///
  /// In ar, this message translates to:
  /// **'البريد الإلكتروني'**
  String get email;

  /// No description provided for @password.
  ///
  /// In ar, this message translates to:
  /// **'كلمة المرور'**
  String get password;

  /// No description provided for @login.
  ///
  /// In ar, this message translates to:
  /// **'تسجيل الدخول'**
  String get login;

  /// No description provided for @forgotPassword.
  ///
  /// In ar, this message translates to:
  /// **'نسيت كلمة المرور؟'**
  String get forgotPassword;

  /// No description provided for @or.
  ///
  /// In ar, this message translates to:
  /// **'أو'**
  String get or;

  /// No description provided for @register.
  ///
  /// In ar, this message translates to:
  /// **'تسجيل'**
  String get register;

  /// No description provided for @orRegister.
  ///
  /// In ar, this message translates to:
  /// **'أو سجل عن طريق'**
  String get orRegister;

  /// No description provided for @createNewAccount.
  ///
  /// In ar, this message translates to:
  /// **'إنشاء حساب جديد'**
  String get createNewAccount;

  /// No description provided for @createParentAccount.
  ///
  /// In ar, this message translates to:
  /// **'إنشاء حساب الوالدين'**
  String get createParentAccount;

  /// No description provided for @personalInformation.
  ///
  /// In ar, this message translates to:
  /// **'البيانات الشخصية'**
  String get personalInformation;

  /// No description provided for @userName.
  ///
  /// In ar, this message translates to:
  /// **'اسم المستخدم'**
  String get userName;

  /// No description provided for @passwordHave8Letters.
  ///
  /// In ar, this message translates to:
  /// **'كلمة مرور تحتوي على  8 أحرف على الأقل'**
  String get passwordHave8Letters;

  /// No description provided for @passwordHave1Number.
  ///
  /// In ar, this message translates to:
  /// **'كلمة مرور تحتوي على رقم واحد على الأقل'**
  String get passwordHave1Number;

  /// No description provided for @passwordHave1LetterCapital.
  ///
  /// In ar, this message translates to:
  /// **'كلمة مرور تحتوي على حرف كبير  على الأقل'**
  String get passwordHave1LetterCapital;

  /// No description provided for @passwordHave1LetterSmall.
  ///
  /// In ar, this message translates to:
  /// **'كلمة مرور تحتوي على حرف صغير على الأقل'**
  String get passwordHave1LetterSmall;

  /// No description provided for @passwordHave1SpecialCharacter.
  ///
  /// In ar, this message translates to:
  /// **'كلمة مرور تحتوي على علامة مميزة'**
  String get passwordHave1SpecialCharacter;

  /// No description provided for @passwordMaxLength16.
  ///
  /// In ar, this message translates to:
  /// **'لا يجب أن يزيد طول كلمة المرور عن 16 حرف'**
  String get passwordMaxLength16;

  /// No description provided for @passwordMaxLength.
  ///
  /// In ar, this message translates to:
  /// **''**
  String get passwordMaxLength;

  /// No description provided for @confirmPassword.
  ///
  /// In ar, this message translates to:
  /// **'تأكيد كلمة المرور'**
  String get confirmPassword;

  /// No description provided for @readAndAgree.
  ///
  /// In ar, this message translates to:
  /// **'لقد قرأت ووافقت على'**
  String get readAndAgree;

  /// No description provided for @terms.
  ///
  /// In ar, this message translates to:
  /// **'شروط'**
  String get terms;

  /// No description provided for @and.
  ///
  /// In ar, this message translates to:
  /// **' و '**
  String get and;

  /// No description provided for @conditionsPolicy.
  ///
  /// In ar, this message translates to:
  /// **'أحكام وسياسة الخصوصية '**
  String get conditionsPolicy;

  /// No description provided for @forAmmaan.
  ///
  /// In ar, this message translates to:
  /// **' الخاصة بموقع أمان'**
  String get forAmmaan;

  /// No description provided for @chooseCountry.
  ///
  /// In ar, this message translates to:
  /// **'اختر دولتك'**
  String get chooseCountry;

  /// No description provided for @choooseYourAge.
  ///
  /// In ar, this message translates to:
  /// **'كم عمرك؟'**
  String get choooseYourAge;

  /// No description provided for @passwordNotMatch.
  ///
  /// In ar, this message translates to:
  /// **'كلمة المرور غير متطابقة'**
  String get passwordNotMatch;

  /// No description provided for @changePassword.
  ///
  /// In ar, this message translates to:
  /// **'تغيير كلمة المرور'**
  String get changePassword;

  /// No description provided for @reciveCodeBy.
  ///
  /// In ar, this message translates to:
  /// **'استلام الرمز الخاص بتعيين كلمة مرور جديدة عن طريق:'**
  String get reciveCodeBy;

  /// No description provided for @phoneNumber.
  ///
  /// In ar, this message translates to:
  /// **'رقم الهاتف'**
  String get phoneNumber;

  /// No description provided for @pleaseEnterPhoneNumber.
  ///
  /// In ar, this message translates to:
  /// **'من فضلك ادخل رقم الهاتف حتى نتمكن من إرسال الرمز الخاص بتعيين كلمة المرور الجديدة'**
  String get pleaseEnterPhoneNumber;

  /// No description provided for @pleaseEnterEmail.
  ///
  /// In ar, this message translates to:
  /// **'من فضلك ادخل البريد الإلكتروني لنتمكن من إرسال الرمز الخاص بتعيين كلمة المرور الجديدة'**
  String get pleaseEnterEmail;

  /// No description provided for @sendCode.
  ///
  /// In ar, this message translates to:
  /// **'إرسال الرمز'**
  String get sendCode;

  /// No description provided for @changeNewPassword.
  ///
  /// In ar, this message translates to:
  /// **'تعيين كلمة مرور جديدة'**
  String get changeNewPassword;

  /// No description provided for @pleaseEnterOtpCode.
  ///
  /// In ar, this message translates to:
  /// **'من فضلك أدخل رمز التحقق المكون من 6 أرقام الذي قمنا بإرساله إلى'**
  String get pleaseEnterOtpCode;

  /// No description provided for @codeValidFor.
  ///
  /// In ar, this message translates to:
  /// **'يمكنك إعادة إرسال الرمز خلال'**
  String get codeValidFor;

  /// No description provided for @seconds.
  ///
  /// In ar, this message translates to:
  /// **'ثانية'**
  String get seconds;

  /// No description provided for @didNotReceiveCode.
  ///
  /// In ar, this message translates to:
  /// **' لم يصلك رمز؟'**
  String get didNotReceiveCode;

  /// No description provided for @resendCode.
  ///
  /// In ar, this message translates to:
  /// **' إعادة إرسال'**
  String get resendCode;

  /// No description provided for @otpNotMatch.
  ///
  /// In ar, this message translates to:
  /// **'OTP غير متطابق'**
  String get otpNotMatch;

  /// No description provided for @otpMustBe6Digits.
  ///
  /// In ar, this message translates to:
  /// **'OTP يجب أن يكون 6 ارقام'**
  String get otpMustBe6Digits;

  /// No description provided for @pleaseSetNewPassword.
  ///
  /// In ar, this message translates to:
  /// **'من فضلك قم بتعيين كلمة مرور جديدة لم يتم استعمالها من قبل'**
  String get pleaseSetNewPassword;

  /// No description provided for @thisFieldRequired.
  ///
  /// In ar, this message translates to:
  /// **'هذا الحقل مطلوب'**
  String get thisFieldRequired;

  /// No description provided for @save.
  ///
  /// In ar, this message translates to:
  /// **'حفظ'**
  String get save;

  /// No description provided for @completeVerification.
  ///
  /// In ar, this message translates to:
  /// **'اكتمل التحقق'**
  String get completeVerification;

  /// No description provided for @successSubscription.
  ///
  /// In ar, this message translates to:
  /// **'تم الاشتراك بنجاح'**
  String get successSubscription;

  /// No description provided for @successSubscriptionDes.
  ///
  /// In ar, this message translates to:
  /// **'لقد اشتركت بنجاح في الباقة، يمكنك الآن الاستمتاع بمحتوى'**
  String get successSubscriptionDes;

  /// No description provided for @doneNewPassword.
  ///
  /// In ar, this message translates to:
  /// **'تم تعيين كلمة المرور!'**
  String get doneNewPassword;

  /// No description provided for @doneNewPasswordDes.
  ///
  /// In ar, this message translates to:
  /// **'تم تعيين كلمة مرور جديدة بنجاح. يمكنك الآن تسجيل الدخول بكلمة المرور الجديدة.'**
  String get doneNewPasswordDes;

  /// No description provided for @mostListened.
  ///
  /// In ar, this message translates to:
  /// **'الأكثر استماعًا'**
  String get mostListened;

  /// No description provided for @suggestions.
  ///
  /// In ar, this message translates to:
  /// **'إقتراحات'**
  String get suggestions;

  /// No description provided for @recentlyPlayed.
  ///
  /// In ar, this message translates to:
  /// **'المشغلة مؤخرًا'**
  String get recentlyPlayed;

  /// No description provided for @guestMode.
  ///
  /// In ar, this message translates to:
  /// **'وضع الضيف'**
  String get guestMode;

  /// No description provided for @youNeedToLoginToContinueWatching.
  ///
  /// In ar, this message translates to:
  /// **'إذا كنت تريد الاستمتاع بهذا المحتوى المرئي فعليك الانضام إلينا. سجل الآن'**
  String get youNeedToLoginToContinueWatching;

  /// No description provided for @addChildData.
  ///
  /// In ar, this message translates to:
  /// **'أضف بيانات طفلك'**
  String get addChildData;

  /// No description provided for @addChildDataHelpUs.
  ///
  /// In ar, this message translates to:
  /// **'أضف بيانات طفلك لتساعدنا على تقديم أفضل الاقتراحات لما يحب.'**
  String get addChildDataHelpUs;

  /// No description provided for @areYourChild.
  ///
  /// In ar, this message translates to:
  /// **'هل طفلك'**
  String get areYourChild;

  /// No description provided for @yourChildName.
  ///
  /// In ar, this message translates to:
  /// **'اسم طفلك'**
  String get yourChildName;

  /// No description provided for @boy.
  ///
  /// In ar, this message translates to:
  /// **'ولد'**
  String get boy;

  /// No description provided for @girl.
  ///
  /// In ar, this message translates to:
  /// **'بنت'**
  String get girl;

  /// No description provided for @childData.
  ///
  /// In ar, this message translates to:
  /// **'تاريخ ميلاد طفلك '**
  String get childData;

  /// No description provided for @optional.
  ///
  /// In ar, this message translates to:
  /// **'( اختياري)'**
  String get optional;

  /// No description provided for @enterVaildData.
  ///
  /// In ar, this message translates to:
  /// **'لم يتم إدخال بيانات صحيحة'**
  String get enterVaildData;

  /// No description provided for @addChildDataDes.
  ///
  /// In ar, this message translates to:
  /// **'البيانات الخاصة بتصرفات الطفل.'**
  String get addChildDataDes;

  /// No description provided for @chooseAnswer.
  ///
  /// In ar, this message translates to:
  /// **'أختر الاجابة'**
  String get chooseAnswer;

  /// No description provided for @yes.
  ///
  /// In ar, this message translates to:
  /// **'نعم'**
  String get yes;

  /// No description provided for @no.
  ///
  /// In ar, this message translates to:
  /// **'لا'**
  String get no;

  /// No description provided for @addYourChildNow.
  ///
  /// In ar, this message translates to:
  /// **'أضف طفلك الآن'**
  String get addYourChildNow;

  /// No description provided for @addAnotherParent.
  ///
  /// In ar, this message translates to:
  /// **'أضف ولي أمر آخر'**
  String get addAnotherParent;

  /// No description provided for @yourAccountsInAmaan.
  ///
  /// In ar, this message translates to:
  /// **'حساباتك في أمان'**
  String get yourAccountsInAmaan;

  /// No description provided for @parents.
  ///
  /// In ar, this message translates to:
  /// **'الوالدان'**
  String get parents;

  /// No description provided for @children.
  ///
  /// In ar, this message translates to:
  /// **'الأطفال'**
  String get children;

  /// No description provided for @anotherChild.
  ///
  /// In ar, this message translates to:
  /// **'طفل اخر'**
  String get anotherChild;

  /// No description provided for @add.
  ///
  /// In ar, this message translates to:
  /// **'إضافة'**
  String get add;

  /// No description provided for @entrance.
  ///
  /// In ar, this message translates to:
  /// **'دخول'**
  String get entrance;

  /// No description provided for @invalidData.
  ///
  /// In ar, this message translates to:
  /// **'بيانات غير صحيحة!'**
  String get invalidData;

  /// No description provided for @invalidDataDes.
  ///
  /// In ar, this message translates to:
  /// **'(إضافة بيانات سلوك الطفل، سيساعدك على اقتراح محتوى مثالي مُوجّه لطفلك، ولكن يمكنك تخطي هذا)'**
  String get invalidDataDes;

  /// No description provided for @completeData.
  ///
  /// In ar, this message translates to:
  /// **'أكمل البيانات'**
  String get completeData;

  /// No description provided for @skip.
  ///
  /// In ar, this message translates to:
  /// **'تخط'**
  String get skip;

  /// No description provided for @welcomeToAman.
  ///
  /// In ar, this message translates to:
  /// **'مرحبًا بك في أمان'**
  String get welcomeToAman;

  /// No description provided for @joinNow.
  ///
  /// In ar, this message translates to:
  /// **'انضم الآن إلى عالم الأحلام'**
  String get joinNow;

  /// No description provided for @skipOrJoinAsGuest.
  ///
  /// In ar, this message translates to:
  /// **'تخط واستكمل كضيف'**
  String get skipOrJoinAsGuest;

  /// No description provided for @mom.
  ///
  /// In ar, this message translates to:
  /// **'الأم'**
  String get mom;

  /// No description provided for @dad.
  ///
  /// In ar, this message translates to:
  /// **'الأب'**
  String get dad;

  /// No description provided for @whoAreYou.
  ///
  /// In ar, this message translates to:
  /// **'من أنت؟'**
  String get whoAreYou;

  /// No description provided for @yourBirthDate.
  ///
  /// In ar, this message translates to:
  /// **'تاريخ ميلادك'**
  String get yourBirthDate;

  /// No description provided for @pleaseChooseRelation.
  ///
  /// In ar, this message translates to:
  /// **'من فضلك يرجي اختيار صلة القرابة'**
  String get pleaseChooseRelation;

  /// No description provided for @completeYourProfile.
  ///
  /// In ar, this message translates to:
  /// **'أكمل إنشاء حسابك'**
  String get completeYourProfile;

  /// No description provided for @searchAboutCountry.
  ///
  /// In ar, this message translates to:
  /// **'ابحث عن الدولة'**
  String get searchAboutCountry;

  /// No description provided for @selectCountry.
  ///
  /// In ar, this message translates to:
  /// **'حدد الدولة'**
  String get selectCountry;

  /// No description provided for @verifyYourAccount.
  ///
  /// In ar, this message translates to:
  /// **'التحقق من حسابك'**
  String get verifyYourAccount;

  /// No description provided for @receiveCode.
  ///
  /// In ar, this message translates to:
  /// **'استلام الرمز الخاص بالتحقق من حسابك عن طريق:'**
  String get receiveCode;

  /// No description provided for @virficationCompleteDes.
  ///
  /// In ar, this message translates to:
  /// **'تم إنشاء حسابك بنجاح، يمكنك  الآن الاستمتاع بعالم أمان'**
  String get virficationCompleteDes;

  /// No description provided for @amaan.
  ///
  /// In ar, this message translates to:
  /// **'أمان'**
  String get amaan;

  /// No description provided for @okay.
  ///
  /// In ar, this message translates to:
  /// **'حسنًا'**
  String get okay;

  /// No description provided for @virfaction.
  ///
  /// In ar, this message translates to:
  /// **'تحقق'**
  String get virfaction;

  /// No description provided for @subscribeNow.
  ///
  /// In ar, this message translates to:
  /// **'اشترك الآن'**
  String get subscribeNow;

  /// No description provided for @subscribtions.
  ///
  /// In ar, this message translates to:
  /// **'الاشتراكات'**
  String get subscribtions;

  /// No description provided for @chooseYourPackage.
  ///
  /// In ar, this message translates to:
  /// **'اختر الباقة التي تناسبك'**
  String get chooseYourPackage;

  /// No description provided for @enjoyWithAmaan.
  ///
  /// In ar, this message translates to:
  /// **'استمتع مع أمان بدون حدود'**
  String get enjoyWithAmaan;

  /// No description provided for @youHavereachedMax.
  ///
  /// In ar, this message translates to:
  /// **'لقد  وصلت إلى الحد الأقصى!'**
  String get youHavereachedMax;

  /// No description provided for @subscribeNowAndAddMoreChilds.
  ///
  /// In ar, this message translates to:
  /// **'اشترك الآن وأضف المزيد من الأطفال.'**
  String get subscribeNowAndAddMoreChilds;

  /// No description provided for @subscribe.
  ///
  /// In ar, this message translates to:
  /// **'اشترك الان'**
  String get subscribe;

  /// No description provided for @termsOfService.
  ///
  /// In ar, this message translates to:
  /// **'الشروط والأحكام'**
  String get termsOfService;

  /// No description provided for @agree.
  ///
  /// In ar, this message translates to:
  /// **'أوافق'**
  String get agree;

  /// No description provided for @pinKey.
  ///
  /// In ar, this message translates to:
  /// **'مفتاح الرقابة الأبوية'**
  String get pinKey;

  /// No description provided for @pinKeyDes.
  ///
  /// In ar, this message translates to:
  /// **'هذا الرمز يُستخدم للتحكم في التنقل بين حسابك وحساب أطفالك.\nيمكنك تغيير هذا الرمز لاحقًا من الإعدادات'**
  String get pinKeyDes;

  /// No description provided for @pinKeyHelp.
  ///
  /// In ar, this message translates to:
  /// **'يتيح لك مفتاح الرقابة الأبوية التحكم في الحسابات ومنع الطفل من التبديل بين الحسابات. يتيح لك استخدام رقم التعريف الشخصي لمفتاح الرقابة الأبوية التحكم في خيارات العرض المختلفة. لذلك يجب إعداد مفتاح الرقابة الأبوية للخطوة التالية. '**
  String get pinKeyHelp;

  /// No description provided for @setPinKey.
  ///
  /// In ar, this message translates to:
  /// **'تعيين الرمز'**
  String get setPinKey;

  /// No description provided for @watchNow.
  ///
  /// In ar, this message translates to:
  /// **'شاهد الآن'**
  String get watchNow;

  /// No description provided for @more.
  ///
  /// In ar, this message translates to:
  /// **'المزيد'**
  String get more;

  /// No description provided for @hide.
  ///
  /// In ar, this message translates to:
  /// **'إخفاء'**
  String get hide;

  /// No description provided for @enterValidEmail.
  ///
  /// In ar, this message translates to:
  /// **'ادخل بريد صحيح'**
  String get enterValidEmail;

  /// No description provided for @age.
  ///
  /// In ar, this message translates to:
  /// **'العمر'**
  String get age;

  /// No description provided for @rate.
  ///
  /// In ar, this message translates to:
  /// **'التقييم'**
  String get rate;

  /// No description provided for @share.
  ///
  /// In ar, this message translates to:
  /// **'مشاركة'**
  String get share;

  /// No description provided for @suggest.
  ///
  /// In ar, this message translates to:
  /// **'أقترح'**
  String get suggest;

  /// No description provided for @pleaseChooseGenderOfChild.
  ///
  /// In ar, this message translates to:
  /// **'من فضلك أختر جنس الطفل'**
  String get pleaseChooseGenderOfChild;

  /// No description provided for @pleaseCheckTerms.
  ///
  /// In ar, this message translates to:
  /// **'من فضلك أختر الشروط والأحكام'**
  String get pleaseCheckTerms;

  /// No description provided for @fullNameLength5To50.
  ///
  /// In ar, this message translates to:
  /// **'طول الاسم الكامل يجب ان يكون بين 5 و 50 حرف'**
  String get fullNameLength5To50;

  /// No description provided for @enterValidPassword.
  ///
  /// In ar, this message translates to:
  /// **'أدخل كلمة مرور صالحة'**
  String get enterValidPassword;

  /// No description provided for @enterValidNumber.
  ///
  /// In ar, this message translates to:
  /// **'ادخل رقم صالح'**
  String get enterValidNumber;

  /// No description provided for @childInfo.
  ///
  /// In ar, this message translates to:
  /// **'معلومات طفلك'**
  String get childInfo;

  /// No description provided for @timeMangment.
  ///
  /// In ar, this message translates to:
  /// **'إدارة الوقت'**
  String get timeMangment;

  /// No description provided for @contentMangment.
  ///
  /// In ar, this message translates to:
  /// **'إدارة المحتوى'**
  String get contentMangment;

  /// No description provided for @accountAnalysis.
  ///
  /// In ar, this message translates to:
  /// **'تحليلات الحساب'**
  String get accountAnalysis;

  /// No description provided for @favorites.
  ///
  /// In ar, this message translates to:
  /// **'المفضلات'**
  String get favorites;

  /// No description provided for @characters.
  ///
  /// In ar, this message translates to:
  /// **'الشخصيات'**
  String get characters;

  /// No description provided for @new_.
  ///
  /// In ar, this message translates to:
  /// **'جديد'**
  String get new_;

  /// No description provided for @old.
  ///
  /// In ar, this message translates to:
  /// **'قديم'**
  String get old;

  /// No description provided for @notifications.
  ///
  /// In ar, this message translates to:
  /// **'الإشعارات'**
  String get notifications;

  /// No description provided for @editData.
  ///
  /// In ar, this message translates to:
  /// **'تعديل البيانات'**
  String get editData;

  /// No description provided for @durationTime.
  ///
  /// In ar, this message translates to:
  /// **'المدة الزمنية'**
  String get durationTime;

  /// No description provided for @durationTimeDes.
  ///
  /// In ar, this message translates to:
  /// **'المدة الزمنية هي الوقت المسموح به لطفلك لاستخدام التطبيق'**
  String get durationTimeDes;

  /// No description provided for @end.
  ///
  /// In ar, this message translates to:
  /// **'النهاية'**
  String get end;

  /// No description provided for @numberViewHours.
  ///
  /// In ar, this message translates to:
  /// **'عدد ساعات المشاهدة'**
  String get numberViewHours;

  /// No description provided for @numberContinueHours.
  ///
  /// In ar, this message translates to:
  /// **'عدد الساعات المتواصلة'**
  String get numberContinueHours;

  /// No description provided for @prayerTimes.
  ///
  /// In ar, this message translates to:
  /// **'وقت الصلاة'**
  String get prayerTimes;

  /// No description provided for @prayerTimesDes.
  ///
  /// In ar, this message translates to:
  /// **'رسالة تذكيرية بمواعيد الصلاة'**
  String get prayerTimesDes;

  /// No description provided for @chooseContent.
  ///
  /// In ar, this message translates to:
  /// **'أختر المحتوى المسموح به لطفلك'**
  String get chooseContent;

  /// No description provided for @accountSetting.
  ///
  /// In ar, this message translates to:
  /// **'إعدادات الحساب'**
  String get accountSetting;

  /// No description provided for @childName.
  ///
  /// In ar, this message translates to:
  /// **'اسم الطفل'**
  String get childName;

  /// No description provided for @deleteAccount.
  ///
  /// In ar, this message translates to:
  /// **'مسح الحساب'**
  String get deleteAccount;

  /// No description provided for @accData.
  ///
  /// In ar, this message translates to:
  /// **'بيانات الحساب'**
  String get accData;

  /// No description provided for @myAccounts.
  ///
  /// In ar, this message translates to:
  /// **'حساباتي'**
  String get myAccounts;

  /// No description provided for @childOrders.
  ///
  /// In ar, this message translates to:
  /// **'طلبات أطفالك'**
  String get childOrders;

  /// No description provided for @appInterface.
  ///
  /// In ar, this message translates to:
  /// **'واجهة التطبيق'**
  String get appInterface;

  /// No description provided for @changeLanguage.
  ///
  /// In ar, this message translates to:
  /// **'تغيير اللغة'**
  String get changeLanguage;

  /// No description provided for @next.
  ///
  /// In ar, this message translates to:
  /// **'التالي'**
  String get next;

  /// No description provided for @right.
  ///
  /// In ar, this message translates to:
  /// **'صواب!'**
  String get right;

  /// No description provided for @wrong.
  ///
  /// In ar, this message translates to:
  /// **'خطأ!'**
  String get wrong;

  /// No description provided for @almostDidIt.
  ///
  /// In ar, this message translates to:
  /// **'كدت تفعلها'**
  String get almostDidIt;

  /// No description provided for @continueWatching.
  ///
  /// In ar, this message translates to:
  /// **'استكمال المشاهدة'**
  String get continueWatching;

  /// No description provided for @topTen.
  ///
  /// In ar, this message translates to:
  /// **'أفضل عشرة'**
  String get topTen;

  /// No description provided for @suggestionsForYou.
  ///
  /// In ar, this message translates to:
  /// **'اقتراحات'**
  String get suggestionsForYou;

  /// No description provided for @related.
  ///
  /// In ar, this message translates to:
  /// **'ذات صلة'**
  String get related;

  /// No description provided for @episodes.
  ///
  /// In ar, this message translates to:
  /// **'الحلقات'**
  String get episodes;

  /// No description provided for @youSucceeded.
  ///
  /// In ar, this message translates to:
  /// **'لقد نجحت!'**
  String get youSucceeded;

  /// No description provided for @youHaveGot.
  ///
  /// In ar, this message translates to:
  /// **'لقد أحرزت'**
  String get youHaveGot;

  /// No description provided for @point.
  ///
  /// In ar, this message translates to:
  /// **'نقطة'**
  String get point;

  /// No description provided for @statistics.
  ///
  /// In ar, this message translates to:
  /// **'الاحصائيات'**
  String get statistics;

  /// No description provided for @totalQuestions.
  ///
  /// In ar, this message translates to:
  /// **'مجموع الأسئلة'**
  String get totalQuestions;

  /// No description provided for @rightAnswers.
  ///
  /// In ar, this message translates to:
  /// **'إجابات صحيحة'**
  String get rightAnswers;

  /// No description provided for @wrongAnswers.
  ///
  /// In ar, this message translates to:
  /// **'إجابات خاطئة'**
  String get wrongAnswers;

  /// No description provided for @tryAgain.
  ///
  /// In ar, this message translates to:
  /// **'حاول مجددًا'**
  String get tryAgain;

  /// No description provided for @changePinKey.
  ///
  /// In ar, this message translates to:
  /// **'تغيير مفتاح الرقابة الأبوية'**
  String get changePinKey;

  /// No description provided for @pleaseEnterOldPin.
  ///
  /// In ar, this message translates to:
  /// **'من فضلك ادخل رمزك القديم'**
  String get pleaseEnterOldPin;

  /// No description provided for @pleaseEnterNewPin.
  ///
  /// In ar, this message translates to:
  /// **'الرجاء تعيين رمز خاص للرقابة الأبوية'**
  String get pleaseEnterNewPin;

  /// No description provided for @verify.
  ///
  /// In ar, this message translates to:
  /// **'تحقق'**
  String get verify;

  /// No description provided for @childBehavior.
  ///
  /// In ar, this message translates to:
  /// **'سلوك الطفل'**
  String get childBehavior;

  /// No description provided for @searchHistory.
  ///
  /// In ar, this message translates to:
  /// **'سجل البحث'**
  String get searchHistory;

  /// No description provided for @clearHistory.
  ///
  /// In ar, this message translates to:
  /// **'مسح سجل البحث'**
  String get clearHistory;

  /// No description provided for @search.
  ///
  /// In ar, this message translates to:
  /// **'البحث'**
  String get search;

  /// No description provided for @noResultsFor.
  ///
  /// In ar, this message translates to:
  /// **'لم يتم العثور على نتائج لـ: '**
  String get noResultsFor;

  /// No description provided for @dontBeSadWeCanFindIt.
  ///
  /// In ar, this message translates to:
  /// **'لا تحزن! يمكننا العثور عليه!'**
  String get dontBeSadWeCanFindIt;

  /// No description provided for @loginToChildren.
  ///
  /// In ar, this message translates to:
  /// **'تسجيل الدخول لطفلك'**
  String get loginToChildren;

  /// No description provided for @leaderBoard.
  ///
  /// In ar, this message translates to:
  /// **'لوحة المتصدرين'**
  String get leaderBoard;

  /// No description provided for @postponedQuizzes.
  ///
  /// In ar, this message translates to:
  /// **'اختبارات مؤجلة'**
  String get postponedQuizzes;

  /// No description provided for @currentQuizzes.
  ///
  /// In ar, this message translates to:
  /// **'الاختبارات الحالية'**
  String get currentQuizzes;

  /// No description provided for @completedQuizzes.
  ///
  /// In ar, this message translates to:
  /// **'الاختبارات المكتملة'**
  String get completedQuizzes;

  /// No description provided for @notCompletedQuizzes.
  ///
  /// In ar, this message translates to:
  /// **'الاختبارات التي لم يكملها بعد.'**
  String get notCompletedQuizzes;

  /// No description provided for @thePostponedQuizzes.
  ///
  /// In ar, this message translates to:
  /// **'الاختبارات المؤجلة'**
  String get thePostponedQuizzes;

  /// No description provided for @postponedQuizzesForLater.
  ///
  /// In ar, this message translates to:
  /// **'اختبارات قمت بتأجيلها  لوقت لاحق.'**
  String get postponedQuizzesForLater;

  /// No description provided for @completedQuizzesDescription.
  ///
  /// In ar, this message translates to:
  /// **'تم الانتهاء من هذا الاختبار'**
  String get completedQuizzesDescription;

  /// No description provided for @quiz.
  ///
  /// In ar, this message translates to:
  /// **'اختبار'**
  String get quiz;

  /// No description provided for @start.
  ///
  /// In ar, this message translates to:
  /// **'ابدأ'**
  String get start;

  /// No description provided for @noPostponedQuizzes.
  ///
  /// In ar, this message translates to:
  /// **'لا يوجد لديك اختبارت بعد'**
  String get noPostponedQuizzes;

  /// No description provided for @accountInformation.
  ///
  /// In ar, this message translates to:
  /// **'معلومات الحساب'**
  String get accountInformation;

  /// No description provided for @country.
  ///
  /// In ar, this message translates to:
  /// **'الدولة'**
  String get country;

  /// No description provided for @sureLogout.
  ///
  /// In ar, this message translates to:
  /// **'هل أنت متأكد أنك تريد تسجيل الخروج من أمان؟'**
  String get sureLogout;

  /// No description provided for @logout.
  ///
  /// In ar, this message translates to:
  /// **'تسجيل الخروج'**
  String get logout;

  /// No description provided for @cancel.
  ///
  /// In ar, this message translates to:
  /// **'إلغاء'**
  String get cancel;

  /// No description provided for @durationIsTheTimeYourChildIsAllowedToUseTheApp.
  ///
  /// In ar, this message translates to:
  /// **'المدة الزمنية هي الوقت المسموح به لطفلك لاستخدام التطبيق'**
  String get durationIsTheTimeYourChildIsAllowedToUseTheApp;

  /// No description provided for @availableHours.
  ///
  /// In ar, this message translates to:
  /// **'الساعات المتاحة'**
  String get availableHours;

  /// No description provided for @theHoursRemainingForYourChildToUseTheApplication.
  ///
  /// In ar, this message translates to:
  /// **'الساعات المتبقية لطفلك لاستخدام التطبيق'**
  String get theHoursRemainingForYourChildToUseTheApplication;

  /// No description provided for @hoursPerDay.
  ///
  /// In ar, this message translates to:
  /// **'ساعات في اليوم'**
  String get hoursPerDay;

  /// No description provided for @refuse.
  ///
  /// In ar, this message translates to:
  /// **'رفض'**
  String get refuse;

  /// No description provided for @minute.
  ///
  /// In ar, this message translates to:
  /// **'دقيقة'**
  String get minute;

  /// No description provided for @remainingTime.
  ///
  /// In ar, this message translates to:
  /// **'الوقت المتبقي'**
  String get remainingTime;

  /// No description provided for @heroesQuiz.
  ///
  /// In ar, this message translates to:
  /// **'نقاط وعملات الأبطال'**
  String get heroesQuiz;

  /// No description provided for @noQuestions.
  ///
  /// In ar, this message translates to:
  /// **'لا يوجد اى اسئلة فى هذا الاختبار'**
  String get noQuestions;

  /// No description provided for @show.
  ///
  /// In ar, this message translates to:
  /// **'عروض'**
  String get show;

  /// No description provided for @series.
  ///
  /// In ar, this message translates to:
  /// **'مسلسل'**
  String get series;

  /// No description provided for @theTimeAllowedForViewingHasExpired.
  ///
  /// In ar, this message translates to:
  /// **'المدة الزمنية المسموحة للمشاهدة قد انتهت'**
  String get theTimeAllowedForViewingHasExpired;

  /// No description provided for @requestToContinueViewing.
  ///
  /// In ar, this message translates to:
  /// **'طلب استكمال المشاهدة'**
  String get requestToContinueViewing;

  /// No description provided for @yourChildrenRequests.
  ///
  /// In ar, this message translates to:
  /// **'طلبات أطفالك'**
  String get yourChildrenRequests;

  /// No description provided for @order.
  ///
  /// In ar, this message translates to:
  /// **'طلب'**
  String get order;

  /// No description provided for @durationBetweenSessions.
  ///
  /// In ar, this message translates to:
  /// **'المدة بين الجلسات'**
  String get durationBetweenSessions;

  /// No description provided for @startQuiz.
  ///
  /// In ar, this message translates to:
  /// **'هيا بنا إلى اختبار الأبطال'**
  String get startQuiz;

  /// No description provided for @ok.
  ///
  /// In ar, this message translates to:
  /// **'حسنًا'**
  String get ok;

  /// No description provided for @later.
  ///
  /// In ar, this message translates to:
  /// **'لاحقا'**
  String get later;

  /// No description provided for @rateVideo.
  ///
  /// In ar, this message translates to:
  /// **'هل أعجبك {name}؟\nقم بتقييمه ليصلك المزيد'**
  String rateVideo(String name);

  /// No description provided for @review.
  ///
  /// In ar, this message translates to:
  /// **'تقييم'**
  String get review;

  /// No description provided for @noThanks.
  ///
  /// In ar, this message translates to:
  /// **'لا، شكرًا!'**
  String get noThanks;

  /// No description provided for @questionRequired.
  ///
  /// In ar, this message translates to:
  /// **'لم يتم ادخال أي بيانات صحيحة'**
  String get questionRequired;

  /// No description provided for @seriesAndMovies.
  ///
  /// In ar, this message translates to:
  /// **'مسلسلات وأفلام'**
  String get seriesAndMovies;

  /// No description provided for @profileEditDone.
  ///
  /// In ar, this message translates to:
  /// **'تم تعديل الملف الشخصي بنجاح'**
  String get profileEditDone;

  /// No description provided for @yourCountry.
  ///
  /// In ar, this message translates to:
  /// **'بلدك'**
  String get yourCountry;

  /// No description provided for @selectBirthDate.
  ///
  /// In ar, this message translates to:
  /// **'اختر تاريخ ميلادك'**
  String get selectBirthDate;

  /// No description provided for @comments.
  ///
  /// In ar, this message translates to:
  /// **'التعليقات'**
  String get comments;

  /// No description provided for @addYourComment.
  ///
  /// In ar, this message translates to:
  /// **'أضف تعليقك...'**
  String get addYourComment;

  /// No description provided for @seasons.
  ///
  /// In ar, this message translates to:
  /// **'المواسم'**
  String get seasons;

  /// No description provided for @darkMode.
  ///
  /// In ar, this message translates to:
  /// **'الوضع المظلم'**
  String get darkMode;

  /// No description provided for @lightMode.
  ///
  /// In ar, this message translates to:
  /// **'الوضع المضيء'**
  String get lightMode;

  /// No description provided for @volumeLevel.
  ///
  /// In ar, this message translates to:
  /// **'مستوى الصوت'**
  String get volumeLevel;

  /// No description provided for @notificationsAndAlerts.
  ///
  /// In ar, this message translates to:
  /// **'التنبيهات والتذكيرات'**
  String get notificationsAndAlerts;

  /// No description provided for @prayed.
  ///
  /// In ar, this message translates to:
  /// **'لقد صليت'**
  String get prayed;

  /// No description provided for @prayingMsg.
  ///
  /// In ar, this message translates to:
  /// **'حان الآن موعد صلاة '**
  String get prayingMsg;

  /// No description provided for @noNotifications.
  ///
  /// In ar, this message translates to:
  /// **'لا يوجد إشعارات!'**
  String get noNotifications;

  /// No description provided for @noNotificationsDes.
  ///
  /// In ar, this message translates to:
  /// **'لم تتلق أي إشعارات حتى الآن.'**
  String get noNotificationsDes;

  /// No description provided for @arbicLanguage.
  ///
  /// In ar, this message translates to:
  /// **'اللغة العربية'**
  String get arbicLanguage;

  /// No description provided for @englishLanguage.
  ///
  /// In ar, this message translates to:
  /// **'اللغة الانجليزية'**
  String get englishLanguage;

  /// No description provided for @pinCodeVerificationDone.
  ///
  /// In ar, this message translates to:
  /// **'تم التحقق من الرمز بنجاح'**
  String get pinCodeVerificationDone;

  /// No description provided for @setPinCodeDone.
  ///
  /// In ar, this message translates to:
  /// **'تم تعيين الرمز بنجاح'**
  String get setPinCodeDone;

  /// No description provided for @loginToParent.
  ///
  /// In ar, this message translates to:
  /// **'تسجيل الدخول للوالدين'**
  String get loginToParent;

  /// No description provided for @pleaseEnterPinCode.
  ///
  /// In ar, this message translates to:
  /// **'الرجاء ادخال الرمز'**
  String get pleaseEnterPinCode;

  /// No description provided for @sendWatchRequest.
  ///
  /// In ar, this message translates to:
  /// **'أرسل طلب مشاهدة'**
  String get sendWatchRequest;

  /// No description provided for @timeFinished.
  ///
  /// In ar, this message translates to:
  /// **'قد وصلت إلى الحد الأقصى للوقت المسموح لك به خلال اليوم. يمكنك إرسال طلب إلى والديك لإكمال المشاهدة'**
  String get timeFinished;

  /// No description provided for @season.
  ///
  /// In ar, this message translates to:
  /// **'الموسم'**
  String get season;

  /// No description provided for @shareWithYourFriends.
  ///
  /// In ar, this message translates to:
  /// **'شارك مع أصدقائك'**
  String get shareWithYourFriends;

  /// No description provided for @accountAnalaytics.
  ///
  /// In ar, this message translates to:
  /// **'تحليلات الحساب'**
  String get accountAnalaytics;

  /// No description provided for @activities.
  ///
  /// In ar, this message translates to:
  /// **'الأنشطة'**
  String get activities;

  /// No description provided for @usage.
  ///
  /// In ar, this message translates to:
  /// **'الاستخدام'**
  String get usage;

  /// No description provided for @quizes.
  ///
  /// In ar, this message translates to:
  /// **'الاختبارات'**
  String get quizes;

  /// No description provided for @reports.
  ///
  /// In ar, this message translates to:
  /// **'التقارير'**
  String get reports;

  /// No description provided for @reportsDes.
  ///
  /// In ar, this message translates to:
  /// **'التقارير الخاصة بطفلك خلال هذه المدة المحددة'**
  String get reportsDes;

  /// No description provided for @from.
  ///
  /// In ar, this message translates to:
  /// **'من'**
  String get from;

  /// No description provided for @to.
  ///
  /// In ar, this message translates to:
  /// **'إلى'**
  String get to;

  /// No description provided for @viewTime.
  ///
  /// In ar, this message translates to:
  /// **'وقت المشاهدة'**
  String get viewTime;

  /// No description provided for @dailyUsage.
  ///
  /// In ar, this message translates to:
  /// **'الاستخدام اليومي'**
  String get dailyUsage;

  /// No description provided for @weeklyUsage.
  ///
  /// In ar, this message translates to:
  /// **'الاستخدام الأسبوعي'**
  String get weeklyUsage;

  /// No description provided for @quizesNotCompleted.
  ///
  /// In ar, this message translates to:
  /// **'الاختبارات التي لم ينهيها طفلك بعد.'**
  String get quizesNotCompleted;

  /// No description provided for @answers.
  ///
  /// In ar, this message translates to:
  /// **'الإجابات'**
  String get answers;

  /// No description provided for @qustionsNumber.
  ///
  /// In ar, this message translates to:
  /// **'عدد الاسئلة'**
  String get qustionsNumber;

  /// No description provided for @quizResult.
  ///
  /// In ar, this message translates to:
  /// **'نتيجة الاختبار'**
  String get quizResult;

  /// No description provided for @retakeQuizNumber.
  ///
  /// In ar, this message translates to:
  /// **'تم إعادة الاختبار عدد '**
  String get retakeQuizNumber;

  /// No description provided for @times.
  ///
  /// In ar, this message translates to:
  /// **'من المرات'**
  String get times;

  /// No description provided for @whatIsNew.
  ///
  /// In ar, this message translates to:
  /// **'ما الجديد'**
  String get whatIsNew;

  /// No description provided for @noSearchResult.
  ///
  /// In ar, this message translates to:
  /// **'لا يوجد نتائج لهذا البحث'**
  String get noSearchResult;

  /// No description provided for @hoursInDay.
  ///
  /// In ar, this message translates to:
  /// **'ساعات في اليوم'**
  String get hoursInDay;

  /// No description provided for @upgradePlz.
  ///
  /// In ar, this message translates to:
  /// **'يجب ترقية الباقة لمشاهدة العرض'**
  String get upgradePlz;

  /// No description provided for @watchingNotAllowed.
  ///
  /// In ar, this message translates to:
  /// **'المشاهدة غير متاحة في هذا الوقت'**
  String get watchingNotAllowed;

  /// No description provided for @loginPlz.
  ///
  /// In ar, this message translates to:
  /// **'يجب تسجيل الدخول لمشاهدة هذا العرض'**
  String get loginPlz;

  /// No description provided for @codeMustBe6Digits.
  ///
  /// In ar, this message translates to:
  /// **'يجب ان يحتوي الكود على 6 ارقام'**
  String get codeMustBe6Digits;

  /// No description provided for @programes.
  ///
  /// In ar, this message translates to:
  /// **'برامج'**
  String get programes;

  /// No description provided for @games.
  ///
  /// In ar, this message translates to:
  /// **'ألعاب'**
  String get games;

  /// No description provided for @day.
  ///
  /// In ar, this message translates to:
  /// **'يوم'**
  String get day;

  /// No description provided for @days.
  ///
  /// In ar, this message translates to:
  /// **'ايام'**
  String get days;

  /// No description provided for @hours.
  ///
  /// In ar, this message translates to:
  /// **'ساعات'**
  String get hours;

  /// No description provided for @requestSent.
  ///
  /// In ar, this message translates to:
  /// **'تم إرسال طلبك بنجاح'**
  String get requestSent;

  /// No description provided for @minutes.
  ///
  /// In ar, this message translates to:
  /// **'دقائق'**
  String get minutes;

  /// No description provided for @pleaseSelectParentAccount.
  ///
  /// In ar, this message translates to:
  /// **'الرجاء تحديد حساب الوالدين'**
  String get pleaseSelectParentAccount;

  /// No description provided for @pleaseAddPasswordAccount.
  ///
  /// In ar, this message translates to:
  /// **'يرجى إدخال كلمة المرور الخاصة بحسابك لتأكيد هذه الخطوة'**
  String get pleaseAddPasswordAccount;

  /// No description provided for @notFoundFavorites.
  ///
  /// In ar, this message translates to:
  /// **'لا يوجد مفضلات بعد!'**
  String get notFoundFavorites;

  /// No description provided for @addYourFavorite.
  ///
  /// In ar, this message translates to:
  /// **'أضف المحتوى الذي تفضله إلى المفضلات حتى تحتفظ به دائمًا'**
  String get addYourFavorite;

  /// No description provided for @hour.
  ///
  /// In ar, this message translates to:
  /// **'ساعة'**
  String get hour;

  /// No description provided for @sunrise.
  ///
  /// In ar, this message translates to:
  /// **'الشروق'**
  String get sunrise;

  /// No description provided for @fajr.
  ///
  /// In ar, this message translates to:
  /// **'الفجر'**
  String get fajr;

  /// No description provided for @dhuhr.
  ///
  /// In ar, this message translates to:
  /// **'الظهر'**
  String get dhuhr;

  /// No description provided for @asr.
  ///
  /// In ar, this message translates to:
  /// **'العصر'**
  String get asr;

  /// No description provided for @maghrib.
  ///
  /// In ar, this message translates to:
  /// **'المغرب'**
  String get maghrib;

  /// No description provided for @isha.
  ///
  /// In ar, this message translates to:
  /// **'العشاء'**
  String get isha;

  /// No description provided for @radio.
  ///
  /// In ar, this message translates to:
  /// **'إذاعة'**
  String get radio;

  /// No description provided for @radioCategories.
  ///
  /// In ar, this message translates to:
  /// **'فئات الإذاعة'**
  String get radioCategories;

  /// No description provided for @radioLive.
  ///
  /// In ar, this message translates to:
  /// **'إذاعة البث المباشر'**
  String get radioLive;

  /// No description provided for @liveBroadcast.
  ///
  /// In ar, this message translates to:
  /// **'البث المباشر'**
  String get liveBroadcast;

  /// No description provided for @live.
  ///
  /// In ar, this message translates to:
  /// **'مباشر'**
  String get live;

  /// No description provided for @radioTimeTable.
  ///
  /// In ar, this message translates to:
  /// **'جدول الإذاعة'**
  String get radioTimeTable;

  /// No description provided for @liveBroadcastingTable.
  ///
  /// In ar, this message translates to:
  /// **'جدول البث المباشر'**
  String get liveBroadcastingTable;

  /// No description provided for @theSuggestions.
  ///
  /// In ar, this message translates to:
  /// **'المقترحات'**
  String get theSuggestions;

  /// No description provided for @playLists.
  ///
  /// In ar, this message translates to:
  /// **'قوائم التشغيل'**
  String get playLists;

  /// No description provided for @showNotReleasedYet.
  ///
  /// In ar, this message translates to:
  /// **'لم يتم نشر هذا العرض بعد'**
  String get showNotReleasedYet;

  /// No description provided for @releaseIn.
  ///
  /// In ar, this message translates to:
  /// **'سيتم النشر خلال'**
  String get releaseIn;

  /// No description provided for @inMoments.
  ///
  /// In ar, this message translates to:
  /// **'لحظات'**
  String get inMoments;

  /// No description provided for @soon.
  ///
  /// In ar, this message translates to:
  /// **'قريبًاً'**
  String get soon;

  /// No description provided for @secs.
  ///
  /// In ar, this message translates to:
  /// **'ثواني'**
  String get secs;

  /// No description provided for @releaseDate.
  ///
  /// In ar, this message translates to:
  /// **'موعد الإصدار'**
  String get releaseDate;

  /// No description provided for @episode.
  ///
  /// In ar, this message translates to:
  /// **'الحلقة'**
  String get episode;

  /// No description provided for @startListening.
  ///
  /// In ar, this message translates to:
  /// **'بدء الاستماع'**
  String get startListening;

  /// No description provided for @seasonsShow.
  ///
  /// In ar, this message translates to:
  /// **'مواسم'**
  String get seasonsShow;

  /// No description provided for @addPlaylistDes.
  ///
  /// In ar, this message translates to:
  /// **'امنح قائمتك اسمًا تفضله يعبر عنها'**
  String get addPlaylistDes;

  /// No description provided for @create.
  ///
  /// In ar, this message translates to:
  /// **'إنشاء'**
  String get create;

  /// No description provided for @closing.
  ///
  /// In ar, this message translates to:
  /// **'اغلاق'**
  String get closing;

  /// No description provided for @addedSuccessfully.
  ///
  /// In ar, this message translates to:
  /// **'تمت الإضافة بنجاح'**
  String get addedSuccessfully;

  /// No description provided for @addToPlaylist.
  ///
  /// In ar, this message translates to:
  /// **'أضف إلى قائمة'**
  String get addToPlaylist;

  /// No description provided for @addToFavorite.
  ///
  /// In ar, this message translates to:
  /// **'أضف إلى المفضلة'**
  String get addToFavorite;

  /// No description provided for @addToAnotherPlaylist.
  ///
  /// In ar, this message translates to:
  /// **'اضاف الى قائمة اخرى'**
  String get addToAnotherPlaylist;

  /// No description provided for @deleteFromPlaylist.
  ///
  /// In ar, this message translates to:
  /// **'احذف من هذه القائمة'**
  String get deleteFromPlaylist;

  /// No description provided for @addPlaylist.
  ///
  /// In ar, this message translates to:
  /// **'إضافة قائمة'**
  String get addPlaylist;

  /// No description provided for @addToList.
  ///
  /// In ar, this message translates to:
  /// **'أضف إلى القائمة'**
  String get addToList;

  /// No description provided for @notFoundAnyAudios.
  ///
  /// In ar, this message translates to:
  /// **'لم يتم إضافة أي مشغل إلى القائمة'**
  String get notFoundAnyAudios;

  /// No description provided for @deletedSuccessfully.
  ///
  /// In ar, this message translates to:
  /// **'تم الحذف بنجاح'**
  String get deletedSuccessfully;

  /// No description provided for @newPlaylist.
  ///
  /// In ar, this message translates to:
  /// **'قائمة جديدة'**
  String get newPlaylist;

  /// No description provided for @savedIn.
  ///
  /// In ar, this message translates to:
  /// **'محفوظ في'**
  String get savedIn;

  /// No description provided for @playlists.
  ///
  /// In ar, this message translates to:
  /// **'قوائم التشغيل'**
  String get playlists;

  /// No description provided for @radioCount.
  ///
  /// In ar, this message translates to:
  /// **'عدد الإذاعات'**
  String get radioCount;

  /// No description provided for @liveBroadcastSchedule.
  ///
  /// In ar, this message translates to:
  /// **'جدول البث المباشر'**
  String get liveBroadcastSchedule;

  /// No description provided for @saturday.
  ///
  /// In ar, this message translates to:
  /// **'سبت'**
  String get saturday;

  /// No description provided for @sunday.
  ///
  /// In ar, this message translates to:
  /// **'أحد'**
  String get sunday;

  /// No description provided for @monday.
  ///
  /// In ar, this message translates to:
  /// **'إثنين'**
  String get monday;

  /// No description provided for @tuesday.
  ///
  /// In ar, this message translates to:
  /// **'ثلاثاء'**
  String get tuesday;

  /// No description provided for @wednesday.
  ///
  /// In ar, this message translates to:
  /// **'أربعاء'**
  String get wednesday;

  /// No description provided for @thursday.
  ///
  /// In ar, this message translates to:
  /// **'خميس'**
  String get thursday;

  /// No description provided for @friday.
  ///
  /// In ar, this message translates to:
  /// **'جمعة'**
  String get friday;

  /// No description provided for @pm.
  ///
  /// In ar, this message translates to:
  /// **'م'**
  String get pm;

  /// No description provided for @am.
  ///
  /// In ar, this message translates to:
  /// **'ص'**
  String get am;

  /// No description provided for @bestMoments.
  ///
  /// In ar, this message translates to:
  /// **'أفضل اللحظات'**
  String get bestMoments;

  /// No description provided for @ads.
  ///
  /// In ar, this message translates to:
  /// **'الإعلانات'**
  String get ads;

  /// No description provided for @close.
  ///
  /// In ar, this message translates to:
  /// **'إغلاق'**
  String get close;

  /// No description provided for @translation.
  ///
  /// In ar, this message translates to:
  /// **'الترجمة'**
  String get translation;

  /// No description provided for @texts.
  ///
  /// In ar, this message translates to:
  /// **'النصوص'**
  String get texts;

  /// No description provided for @quality.
  ///
  /// In ar, this message translates to:
  /// **'الجودة'**
  String get quality;

  /// No description provided for @nextEpisode.
  ///
  /// In ar, this message translates to:
  /// **'الحلقة التالية'**
  String get nextEpisode;

  /// No description provided for @screenLocked.
  ///
  /// In ar, this message translates to:
  /// **'الشاشة مقفلة'**
  String get screenLocked;

  /// No description provided for @screenUnlocked.
  ///
  /// In ar, this message translates to:
  /// **'تم فتح القفل'**
  String get screenUnlocked;

  /// No description provided for @resolution.
  ///
  /// In ar, this message translates to:
  /// **'الدقة'**
  String get resolution;

  /// No description provided for @noUasageTime.
  ///
  /// In ar, this message translates to:
  /// **'لا يوجد وقت مستخدم محدد لهذا الطفل'**
  String get noUasageTime;

  /// No description provided for @removeFromList.
  ///
  /// In ar, this message translates to:
  /// **'إزالة من القائمة'**
  String get removeFromList;

  /// No description provided for @thisVideoNotAvaliableForWatchingNow.
  ///
  /// In ar, this message translates to:
  /// **'هذا الفيديو غير متاح للمشاهدة الآن'**
  String get thisVideoNotAvaliableForWatchingNow;

  /// No description provided for @changeColorSubtitle.
  ///
  /// In ar, this message translates to:
  /// **'التغيير بين الألوان يتيح لك التمتع بتصميمات وألوان مختلفة'**
  String get changeColorSubtitle;

  /// No description provided for @aboutSeries.
  ///
  /// In ar, this message translates to:
  /// **'عن المسلسل'**
  String get aboutSeries;

  /// No description provided for @aboutFilm.
  ///
  /// In ar, this message translates to:
  /// **'عن الفيلم'**
  String get aboutFilm;

  /// No description provided for @yearProduction.
  ///
  /// In ar, this message translates to:
  /// **'سنة  الإنتاج'**
  String get yearProduction;

  /// No description provided for @oneEpisode.
  ///
  /// In ar, this message translates to:
  /// **'حلقة'**
  String get oneEpisode;

  /// No description provided for @episodess.
  ///
  /// In ar, this message translates to:
  /// **'حلقات'**
  String get episodess;

  /// No description provided for @twoEpisodes.
  ///
  /// In ar, this message translates to:
  /// **'حلقتان'**
  String get twoEpisodes;

  /// No description provided for @oneSeason.
  ///
  /// In ar, this message translates to:
  /// **'موسم'**
  String get oneSeason;

  /// No description provided for @twoSeasons.
  ///
  /// In ar, this message translates to:
  /// **'موسمان'**
  String get twoSeasons;

  /// No description provided for @tasks.
  ///
  /// In ar, this message translates to:
  /// **'المهام'**
  String get tasks;

  /// No description provided for @myTasks.
  ///
  /// In ar, this message translates to:
  /// **'مهامي'**
  String get myTasks;

  /// No description provided for @beginIn.
  ///
  /// In ar, this message translates to:
  /// **'ستبدأ بعد'**
  String get beginIn;

  /// No description provided for @playNow.
  ///
  /// In ar, this message translates to:
  /// **'تشغيل'**
  String get playNow;

  /// No description provided for @rememberMe.
  ///
  /// In ar, this message translates to:
  /// **'تذكرني'**
  String get rememberMe;

  /// No description provided for @accept.
  ///
  /// In ar, this message translates to:
  /// **'موافق'**
  String get accept;

  /// No description provided for @passwordValidation.
  ///
  /// In ar, this message translates to:
  /// **'نرجو التحقق من أن كلمة المرور تتكون من 8 أحرف علي الأقل وتحتوي علي رقم ورمز (@#\$%&) وحرف كبير (A-Z) وحرف صغير (a-z)'**
  String get passwordValidation;

  /// No description provided for @confirmIdentity.
  ///
  /// In ar, this message translates to:
  /// **'تأكيد الهوية'**
  String get confirmIdentity;

  /// No description provided for @checkInternetConnection.
  ///
  /// In ar, this message translates to:
  /// **'برجاء التحقق من الاتصال بالانترنت'**
  String get checkInternetConnection;

  /// No description provided for @min.
  ///
  /// In ar, this message translates to:
  /// **'د'**
  String get min;

  /// No description provided for @sureDeleteAccount.
  ///
  /// In ar, this message translates to:
  /// **'هل أنت متأكد أنك تريد حذف حسابك؟'**
  String get sureDeleteAccount;

  /// No description provided for @chooseAppLanguage.
  ///
  /// In ar, this message translates to:
  /// **'اختر لغة التطبيق'**
  String get chooseAppLanguage;

  /// No description provided for @welcomeEn.
  ///
  /// In ar, this message translates to:
  /// **'Welcome'**
  String get welcomeEn;

  /// No description provided for @welcomeArabic.
  ///
  /// In ar, this message translates to:
  /// **'مرحباً'**
  String get welcomeArabic;

  /// No description provided for @arabicLanguageName.
  ///
  /// In ar, this message translates to:
  /// **'العربية'**
  String get arabicLanguageName;

  /// No description provided for @englishLanguageName.
  ///
  /// In ar, this message translates to:
  /// **'English'**
  String get englishLanguageName;

  /// No description provided for @saudiCode.
  ///
  /// In ar, this message translates to:
  /// **'SA'**
  String get saudiCode;

  /// No description provided for @usaCode.
  ///
  /// In ar, this message translates to:
  /// **'US'**
  String get usaCode;

  /// No description provided for @comingSoon.
  ///
  /// In ar, this message translates to:
  /// **'قريبًا'**
  String get comingSoon;

  /// No description provided for @featureComingSoon.
  ///
  /// In ar, this message translates to:
  /// **'سيتم الإضافة قريبًا. تابعنا!'**
  String get featureComingSoon;

  /// No description provided for @emptyStateMessage.
  ///
  /// In ar, this message translates to:
  /// **'لا يوجد عناصر حتى الآن'**
  String get emptyStateMessage;

  /// No description provided for @howManyTimesToRepeat.
  ///
  /// In ar, this message translates to:
  /// **'كم عدد مرات الإعادة ؟'**
  String get howManyTimesToRepeat;

  /// No description provided for @enterRepeatCount.
  ///
  /// In ar, this message translates to:
  /// **'ادخل عدد مرات الإعادة'**
  String get enterRepeatCount;

  /// No description provided for @repeat.
  ///
  /// In ar, this message translates to:
  /// **'إعادة'**
  String get repeat;

  /// No description provided for @max.
  ///
  /// In ar, this message translates to:
  /// **' 10 اقصى عدد'**
  String get max;

  /// No description provided for @miscellaneous.
  ///
  /// In ar, this message translates to:
  /// **'منوعات'**
  String get miscellaneous;

  /// No description provided for @edit.
  ///
  /// In ar, this message translates to:
  /// **'تعديل'**
  String get edit;

  /// No description provided for @delete.
  ///
  /// In ar, this message translates to:
  /// **'حذف'**
  String get delete;

  /// No description provided for @skipIntro.
  ///
  /// In ar, this message translates to:
  /// **'تخطي المقدمة'**
  String get skipIntro;

  /// No description provided for @deletePlaylist.
  ///
  /// In ar, this message translates to:
  /// **'مسح القائمة'**
  String get deletePlaylist;

  /// No description provided for @editPlaylist.
  ///
  /// In ar, this message translates to:
  /// **'تعديل القائمة'**
  String get editPlaylist;

  /// No description provided for @deletePlaylistConfirmation.
  ///
  /// In ar, this message translates to:
  /// **' هل أنت متأكد أنك تريد حذف القائمة؟'**
  String get deletePlaylistConfirmation;

  /// No description provided for @editPlaylistConfirmation.
  ///
  /// In ar, this message translates to:
  /// **'هل أنت متأكد أنك تريد تعديل القائمة؟'**
  String get editPlaylistConfirmation;

  /// No description provided for @playlistName.
  ///
  /// In ar, this message translates to:
  /// **'اسم القائمة'**
  String get playlistName;

  /// No description provided for @enterPlaylistName.
  ///
  /// In ar, this message translates to:
  /// **'أدخل اسم القائمة'**
  String get enterPlaylistName;

  /// No description provided for @createPlaylist.
  ///
  /// In ar, this message translates to:
  /// **'إنشاء قائمة'**
  String get createPlaylist;

  /// No description provided for @monthly.
  ///
  /// In ar, this message translates to:
  /// **'شهري'**
  String get monthly;

  /// No description provided for @yearly.
  ///
  /// In ar, this message translates to:
  /// **'سنوي'**
  String get yearly;

  /// No description provided for @mangeDevices.
  ///
  /// In ar, this message translates to:
  /// **'إدارة الاجهزة'**
  String get mangeDevices;

  /// No description provided for @connectedDevices.
  ///
  /// In ar, this message translates to:
  /// **'الأجهزة المتصلة'**
  String get connectedDevices;

  /// No description provided for @deviceName.
  ///
  /// In ar, this message translates to:
  /// **'اسم الجهاز'**
  String get deviceName;

  /// No description provided for @deviceType.
  ///
  /// In ar, this message translates to:
  /// **'نوع الجهاز'**
  String get deviceType;

  /// No description provided for @lastLogin.
  ///
  /// In ar, this message translates to:
  /// **'آخر تسجيل دخول'**
  String get lastLogin;

  /// No description provided for @removeDevice.
  ///
  /// In ar, this message translates to:
  /// **'إزالة الجهاز'**
  String get removeDevice;

  /// No description provided for @deviceRemoved.
  ///
  /// In ar, this message translates to:
  /// **'تمت إزالة الجهاز بنجاح'**
  String get deviceRemoved;

  /// No description provided for @noConnectedDevices.
  ///
  /// In ar, this message translates to:
  /// **'لم يتم العثور على أجهزة متصلة'**
  String get noConnectedDevices;

  /// No description provided for @confirmRemoveDevice.
  ///
  /// In ar, this message translates to:
  /// **'هل أنت متأكد أنك تريد إزالة هذا الجهاز؟'**
  String get confirmRemoveDevice;

  /// No description provided for @logoutAllDevices.
  ///
  /// In ar, this message translates to:
  /// **'الخروج من جميع الاجهزة'**
  String get logoutAllDevices;

  /// No description provided for @refresh.
  ///
  /// In ar, this message translates to:
  /// **'تحديث'**
  String get refresh;

  /// No description provided for @errorHappenedTryAgain.
  ///
  /// In ar, this message translates to:
  /// **'حدث خطأ، يرجى المحاولة مرة أخرى'**
  String get errorHappenedTryAgain;

  /// No description provided for @enterPromoCode.
  ///
  /// In ar, this message translates to:
  /// **'أدخل كود الخصم'**
  String get enterPromoCode;

  /// No description provided for @validate.
  ///
  /// In ar, this message translates to:
  /// **'تحقق'**
  String get validate;

  /// No description provided for @promoCodeInvalid.
  ///
  /// In ar, this message translates to:
  /// **'كود الخصم غير صحيح'**
  String get promoCodeInvalid;

  /// No description provided for @promoCodeValid.
  ///
  /// In ar, this message translates to:
  /// **'كود الخصم صحيح'**
  String get promoCodeValid;

  /// No description provided for @pleaseEnterPromoCode.
  ///
  /// In ar, this message translates to:
  /// **'الرجاء ادخال كود الخصم'**
  String get pleaseEnterPromoCode;

  /// No description provided for @changePromoCode.
  ///
  /// In ar, this message translates to:
  /// **'تغيير كود الخصم'**
  String get changePromoCode;

  /// No description provided for @youAreOnThisPlan.
  ///
  /// In ar, this message translates to:
  /// **'أنت الآن مشترك على هذه الباقة'**
  String get youAreOnThisPlan;

  /// No description provided for @yourSubscriptionEndAt.
  ///
  /// In ar, this message translates to:
  /// **'يتجدد اشتراكك في'**
  String get yourSubscriptionEndAt;

  /// No description provided for @subscriptionEndsAt.
  ///
  /// In ar, this message translates to:
  /// **'الاشتراك ينتهي في'**
  String get subscriptionEndsAt;

  /// No description provided for @cancelSubscription.
  ///
  /// In ar, this message translates to:
  /// **'إلغاء الاشتراك'**
  String get cancelSubscription;

  /// No description provided for @youSubscribe.
  ///
  /// In ar, this message translates to:
  /// **'أنت الآن على باقة'**
  String get youSubscribe;

  /// No description provided for @sureChangePlan.
  ///
  /// In ar, this message translates to:
  /// **'هل أنت متأكد من تغيير الباقة؟'**
  String get sureChangePlan;

  /// No description provided for @sureCancelSubscription.
  ///
  /// In ar, this message translates to:
  /// **'هل أنت متأكد من إلغاء الاشتراك؟ لا يمكن التراجع عن هذا الاجراء.'**
  String get sureCancelSubscription;

  /// No description provided for @subscriptionCancelled.
  ///
  /// In ar, this message translates to:
  /// **'تم إلغاء الباقة بنجاح'**
  String get subscriptionCancelled;

  /// No description provided for @subscriptionNotActive.
  ///
  /// In ar, this message translates to:
  /// **'الاشتراك غير مفعل'**
  String get subscriptionNotActive;

  /// No description provided for @subscribeDialogText1.
  ///
  /// In ar, this message translates to:
  /// **'هل تريد الاستمتاع بباقى الحلقات و الأنشطة؟'**
  String get subscribeDialogText1;

  /// No description provided for @subscribeDialogText2Son.
  ///
  /// In ar, this message translates to:
  /// **'اشترك مع “أمان” لتستمتع بعالم كامل من الحلقات الممتعة والتعلّم الشيّق!\nاطلب من ولي أمرك الاشتراك الآن'**
  String get subscribeDialogText2Son;

  /// No description provided for @subscribeDialogText2Parent.
  ///
  /// In ar, this message translates to:
  /// **'الاشتراك يوفّر لطفلك محتوى متنوّعًا وآمنًا يجمع بين الترفيه والتعلّم.'**
  String get subscribeDialogText2Parent;

  /// No description provided for @updateNow.
  ///
  /// In ar, this message translates to:
  /// **'تحديث التطبيق متوفر الآن'**
  String get updateNow;

  /// No description provided for @updateNowDes.
  ///
  /// In ar, this message translates to:
  /// **'حدث التطبيق لتستمتع بجميع المزايا الجديدة'**
  String get updateNowDes;

  /// No description provided for @updateNowButton.
  ///
  /// In ar, this message translates to:
  /// **'تحديث الآن'**
  String get updateNowButton;

  /// No description provided for @subscriptionFailed.
  ///
  /// In ar, this message translates to:
  /// **'فشل الاشتراك'**
  String get subscriptionFailed;

  /// No description provided for @subscriptionFailedDes.
  ///
  /// In ar, this message translates to:
  /// **'فشل الاشتراك في الباقة. الرجاء المحاولة مرة اخرى'**
  String get subscriptionFailedDes;

  /// No description provided for @welcomeFriend.
  ///
  /// In ar, this message translates to:
  /// **'مرحبا ياصديقي'**
  String get welcomeFriend;

  /// No description provided for @chooseRepeat.
  ///
  /// In ar, this message translates to:
  /// **'اختر عدد مرات التكرار'**
  String get chooseRepeat;

  /// No description provided for @howCanHelpYou.
  ///
  /// In ar, this message translates to:
  /// **'كيف يمكننا مساعدتك؟'**
  String get howCanHelpYou;

  /// No description provided for @youCanApplyRequest.
  ///
  /// In ar, this message translates to:
  /// **'يمكنك تقديم طلب بكل ما يخص تساؤلاتك, وسيقوم الفريق المختص بالرد عليك خلال 24 ساعة.'**
  String get youCanApplyRequest;

  /// No description provided for @contactUs.
  ///
  /// In ar, this message translates to:
  /// **'تواصل معنا'**
  String get contactUs;

  /// No description provided for @ticketType.
  ///
  /// In ar, this message translates to:
  /// **'نوع المشكلة'**
  String get ticketType;

  /// No description provided for @address.
  ///
  /// In ar, this message translates to:
  /// **'العنوان'**
  String get address;

  /// No description provided for @descriptionOfMsg.
  ///
  /// In ar, this message translates to:
  /// **'وصف رسالتك..'**
  String get descriptionOfMsg;

  /// No description provided for @addPicture.
  ///
  /// In ar, this message translates to:
  /// **'ارفاق صورة/ ملف  هنا (اختياري)'**
  String get addPicture;

  /// No description provided for @send.
  ///
  /// In ar, this message translates to:
  /// **'ارسال'**
  String get send;

  /// No description provided for @myTickets.
  ///
  /// In ar, this message translates to:
  /// **'تذاكري'**
  String get myTickets;

  /// No description provided for @createTicket.
  ///
  /// In ar, this message translates to:
  /// **'إنشاء تذكرة'**
  String get createTicket;

  /// No description provided for @ticket.
  ///
  /// In ar, this message translates to:
  /// **'التذكرة'**
  String get ticket;

  /// No description provided for @ticketNo.
  ///
  /// In ar, this message translates to:
  /// **'رقم التذكرة'**
  String get ticketNo;

  /// No description provided for @lastUpdate.
  ///
  /// In ar, this message translates to:
  /// **'آخر تحديث'**
  String get lastUpdate;

  /// No description provided for @yourMessageSentSuccessfully.
  ///
  /// In ar, this message translates to:
  /// **'تم ارسال رسالتك بنجاح'**
  String get yourMessageSentSuccessfully;

  /// No description provided for @technicalIssue.
  ///
  /// In ar, this message translates to:
  /// **'مشكلة تقنية'**
  String get technicalIssue;

  /// No description provided for @generalInquiry.
  ///
  /// In ar, this message translates to:
  /// **'استفسار عام'**
  String get generalInquiry;

  /// No description provided for @suggestion.
  ///
  /// In ar, this message translates to:
  /// **'اقتراح'**
  String get suggestion;

  /// No description provided for @complaint.
  ///
  /// In ar, this message translates to:
  /// **'شكوى'**
  String get complaint;

  /// No description provided for @other.
  ///
  /// In ar, this message translates to:
  /// **'أخرى'**
  String get other;

  /// No description provided for @statusOpened.
  ///
  /// In ar, this message translates to:
  /// **'مفتوحة'**
  String get statusOpened;

  /// No description provided for @statusProcessing.
  ///
  /// In ar, this message translates to:
  /// **'قيد المراجعة'**
  String get statusProcessing;

  /// No description provided for @statusSolved.
  ///
  /// In ar, this message translates to:
  /// **'تم الحل'**
  String get statusSolved;

  /// No description provided for @yourCurrentPlanProvides.
  ///
  /// In ar, this message translates to:
  /// **'خطتك الحالية توفر لك تسجيل {noOfAllowedDevices} أجهزة'**
  String yourCurrentPlanProvides(Object noOfAllowedDevices);

  /// No description provided for @deviceGroupDescription.
  ///
  /// In ar, this message translates to:
  /// **'مجموعة الاجهزة التي سجل الدخول عليها عبر هذا الحساب. يمكنك تسجيل خروج اي جهاز غير مألوف أو تغيير كلمة المرور لمزيد من الأمان'**
  String get deviceGroupDescription;

  /// No description provided for @currentDevice.
  ///
  /// In ar, this message translates to:
  /// **'الجهاز الحالي'**
  String get currentDevice;

  /// No description provided for @confirmLogout.
  ///
  /// In ar, this message translates to:
  /// **'هل أنت متأكد أنك تريد تسجيل الخروج من هذا الجهاز؟'**
  String get confirmLogout;

  /// No description provided for @retry.
  ///
  /// In ar, this message translates to:
  /// **'إعادة المحاولة'**
  String get retry;

  /// No description provided for @motivationalTaskMessage.
  ///
  /// In ar, this message translates to:
  /// **'هيا قم بإنجاز المزيد من المهام لتنال المزيد من النقاط لتحصل على المكافأة'**
  String get motivationalTaskMessage;

  /// No description provided for @noTasksToday.
  ///
  /// In ar, this message translates to:
  /// **'لا توجد مهام لهذا اليوم'**
  String get noTasksToday;

  /// No description provided for @todaysTasks.
  ///
  /// In ar, this message translates to:
  /// **'مهام اليوم'**
  String get todaysTasks;

  /// No description provided for @bravoCookie.
  ///
  /// In ar, this message translates to:
  /// **'برافوو كوكي!'**
  String get bravoCookie;

  /// No description provided for @completedAllTasksMessage.
  ///
  /// In ar, this message translates to:
  /// **'لقد أنجزت كل مهامك لنرى كم ربحت اليوم'**
  String get completedAllTasksMessage;

  /// No description provided for @continue_.
  ///
  /// In ar, this message translates to:
  /// **'المتابعة'**
  String get continue_;

  /// No description provided for @wellDone.
  ///
  /// In ar, this message translates to:
  /// **'أحسنت!'**
  String get wellDone;

  /// No description provided for @taskCompletedSuccessfully.
  ///
  /// In ar, this message translates to:
  /// **'لقد أكملت المهمة بنجاح'**
  String get taskCompletedSuccessfully;

  /// No description provided for @howWasYourExperience.
  ///
  /// In ar, this message translates to:
  /// **'كيف كانت تجربتك؟'**
  String get howWasYourExperience;

  /// No description provided for @confirm.
  ///
  /// In ar, this message translates to:
  /// **'تأكيد'**
  String get confirm;

  /// No description provided for @doYouWantToUndoTask.
  ///
  /// In ar, this message translates to:
  /// **'هل تود التراجع عن {taskTitle}؟'**
  String doYouWantToUndoTask(String taskTitle);

  /// No description provided for @didYouCompleteTask.
  ///
  /// In ar, this message translates to:
  /// **'هل أكملت {taskTitle} بنجاح؟'**
  String didYouCompleteTask(String taskTitle);

  /// No description provided for @completedAllTasksSuccessfully.
  ///
  /// In ar, this message translates to:
  /// **'لقد انجزت مهامك بنجاح 🎉'**
  String get completedAllTasksSuccessfully;

  /// No description provided for @haventStartedAnyTask.
  ///
  /// In ar, this message translates to:
  /// **'لم تبدأ بتنفيذ اى مهمه بعد!'**
  String get haventStartedAnyTask;

  /// No description provided for @completedTasksCount.
  ///
  /// In ar, this message translates to:
  /// **'لقد انجزت {count} مهمة بنجاح 🎉'**
  String completedTasksCount(int count);

  /// No description provided for @taskInstanceIdRequired.
  ///
  /// In ar, this message translates to:
  /// **'معرف المهمة مطلوب'**
  String get taskInstanceIdRequired;

  /// No description provided for @failedToFetchTasks.
  ///
  /// In ar, this message translates to:
  /// **'فشل في جلب المهام: {error}'**
  String failedToFetchTasks(String error);

  /// No description provided for @failedToMarkTaskAsDone.
  ///
  /// In ar, this message translates to:
  /// **'فشل في تحديد المهمة كمكتملة: {error}'**
  String failedToMarkTaskAsDone(String error);

  /// No description provided for @failedToMarkTaskAsUndone.
  ///
  /// In ar, this message translates to:
  /// **'فشل في تحديد المهمة كغير مكتملة: {error}'**
  String failedToMarkTaskAsUndone(String error);

  /// No description provided for @failedToFetchTodaysTasks.
  ///
  /// In ar, this message translates to:
  /// **'فشل في جلب مهام اليوم'**
  String get failedToFetchTodaysTasks;

  /// No description provided for @failedToFetchChildTasks.
  ///
  /// In ar, this message translates to:
  /// **'فشل في جلب مهام الطفل'**
  String get failedToFetchChildTasks;

  /// No description provided for @failedToFetchChildScore.
  ///
  /// In ar, this message translates to:
  /// **'فشل في جلب نقاط الطفل'**
  String get failedToFetchChildScore;

  /// No description provided for @failedToMarkTaskAsDoneService.
  ///
  /// In ar, this message translates to:
  /// **'فشل في تحديد المهمة كمكتملة'**
  String get failedToMarkTaskAsDoneService;

  /// No description provided for @failedToMarkTaskAsUndoneService.
  ///
  /// In ar, this message translates to:
  /// **'فشل في تحديد المهمة كغير مكتملة'**
  String get failedToMarkTaskAsUndoneService;

  /// No description provided for @welcomeMyFriend.
  ///
  /// In ar, this message translates to:
  /// **'مرحباً يا صديقي'**
  String get welcomeMyFriend;

  /// No description provided for @playAndRecite.
  ///
  /// In ar, this message translates to:
  /// **'ابدأ التلاوة من الحلقات مباشرة'**
  String get playAndRecite;

  /// No description provided for @subject.
  ///
  /// In ar, this message translates to:
  /// **'الموضوع'**
  String get subject;

  /// No description provided for @noTicketsFound.
  ///
  /// In ar, this message translates to:
  /// **'لم يتم العثور على تذاكر'**
  String get noTicketsFound;

  /// No description provided for @noMessagesFound.
  ///
  /// In ar, this message translates to:
  /// **'شكراً لتواصلكم معنا، سيقوم فريقنا بالرد عليكم قريبًاً'**
  String get noMessagesFound;

  /// No description provided for @category.
  ///
  /// In ar, this message translates to:
  /// **'الفئة'**
  String get category;

  /// No description provided for @description.
  ///
  /// In ar, this message translates to:
  /// **'الوصف'**
  String get description;

  /// No description provided for @openDate.
  ///
  /// In ar, this message translates to:
  /// **'تاريخ الفتح'**
  String get openDate;

  /// No description provided for @dailyTasks.
  ///
  /// In ar, this message translates to:
  /// **'المهام اليومية'**
  String get dailyTasks;

  /// No description provided for @chooseDailyTasksForYourChild.
  ///
  /// In ar, this message translates to:
  /// **'اختر المهام اليومية لطفلك'**
  String get chooseDailyTasksForYourChild;

  /// No description provided for @chooseOrModifyYourChildTasks.
  ///
  /// In ar, this message translates to:
  /// **'قم باختيار او تعديل مهام أطفالك'**
  String get chooseOrModifyYourChildTasks;

  /// No description provided for @customTasks.
  ///
  /// In ar, this message translates to:
  /// **'مهام مخصصة'**
  String get customTasks;

  /// No description provided for @createNewTask.
  ///
  /// In ar, this message translates to:
  /// **'إنشاء مهمة جديدة'**
  String get createNewTask;

  /// No description provided for @editTask.
  ///
  /// In ar, this message translates to:
  /// **'تعديل المهمة'**
  String get editTask;

  /// No description provided for @taskName.
  ///
  /// In ar, this message translates to:
  /// **'اسم المهمة'**
  String get taskName;

  /// No description provided for @writeDescription.
  ///
  /// In ar, this message translates to:
  /// **'اكتب الوصف'**
  String get writeDescription;

  /// No description provided for @chooseTaskImage.
  ///
  /// In ar, this message translates to:
  /// **'اختر صورة المهمة'**
  String get chooseTaskImage;

  /// No description provided for @deleteTask.
  ///
  /// In ar, this message translates to:
  /// **'حذف المهمة'**
  String get deleteTask;

  /// No description provided for @areYouSureDeleteTask.
  ///
  /// In ar, this message translates to:
  /// **'هل أنت متأكد من حذف هذه المهمة؟'**
  String get areYouSureDeleteTask;

  /// No description provided for @taskDeletedSuccessfully.
  ///
  /// In ar, this message translates to:
  /// **'تم حذف المهمة'**
  String get taskDeletedSuccessfully;

  /// No description provided for @addTaskToCustomTasks.
  ///
  /// In ar, this message translates to:
  /// **'إضافة مهمة {taskTitle} إلى المهام المخصصة'**
  String addTaskToCustomTasks(String taskTitle);

  /// No description provided for @daily.
  ///
  /// In ar, this message translates to:
  /// **'يومياً'**
  String get daily;

  /// No description provided for @selectPaymentMethod.
  ///
  /// In ar, this message translates to:
  /// **'اختر طريقة الدفع'**
  String get selectPaymentMethod;

  /// No description provided for @payWithVisa.
  ///
  /// In ar, this message translates to:
  /// **'الدفع بالفيزا/البطاقة'**
  String get payWithVisa;

  /// No description provided for @payWithCoupon.
  ///
  /// In ar, this message translates to:
  /// **'الدفع باستخدام كوبون'**
  String get payWithCoupon;

  /// No description provided for @enterCoupon.
  ///
  /// In ar, this message translates to:
  /// **'ادخل الكوبون'**
  String get enterCoupon;

  /// No description provided for @couponCode.
  ///
  /// In ar, this message translates to:
  /// **'كود الكوبون'**
  String get couponCode;

  /// No description provided for @enterCouponCode.
  ///
  /// In ar, this message translates to:
  /// **'ادخل كود الكوبون'**
  String get enterCouponCode;

  /// No description provided for @applyCoupon.
  ///
  /// In ar, this message translates to:
  /// **'تطبيق الكوبون'**
  String get applyCoupon;

  /// No description provided for @invalidCoupon.
  ///
  /// In ar, this message translates to:
  /// **'كود الكوبون غير صالح'**
  String get invalidCoupon;

  /// No description provided for @couponApplied.
  ///
  /// In ar, this message translates to:
  /// **'كود الكوبون صالح'**
  String get couponApplied;

  /// No description provided for @addPhoneNumber.
  ///
  /// In ar, this message translates to:
  /// **'يرجى إكمال معلومات حسابك بإضافة رقم الهاتف.'**
  String get addPhoneNumber;
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
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
