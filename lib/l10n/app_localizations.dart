import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_id.dart';

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
    Locale('id')
  ];

  /// No description provided for @appName.
  ///
  /// In id, this message translates to:
  /// **'SIGAP'**
  String get appName;

  /// No description provided for @disclaimerTitle.
  ///
  /// In id, this message translates to:
  /// **'Pernyataan Keamanan'**
  String get disclaimerTitle;

  /// No description provided for @disclaimerBody.
  ///
  /// In id, this message translates to:
  /// **'Aplikasi ini memberikan panduan pertolongan pertama edukatif dan tidak menggantikan bantuan medis profesional.'**
  String get disclaimerBody;

  /// No description provided for @disclaimerAccept.
  ///
  /// In id, this message translates to:
  /// **'Saya Mengerti & Setuju'**
  String get disclaimerAccept;

  /// No description provided for @homeTitle.
  ///
  /// In id, this message translates to:
  /// **'Beranda'**
  String get homeTitle;

  /// No description provided for @emergencyTitle.
  ///
  /// In id, this message translates to:
  /// **'Panggilan Darurat'**
  String get emergencyTitle;

  /// No description provided for @cprTitle.
  ///
  /// In id, this message translates to:
  /// **'Asisten RJP'**
  String get cprTitle;

  /// No description provided for @learnTitle.
  ///
  /// In id, this message translates to:
  /// **'Edukasi'**
  String get learnTitle;

  /// No description provided for @profileTitle.
  ///
  /// In id, this message translates to:
  /// **'Profil'**
  String get profileTitle;

  /// No description provided for @searchHint.
  ///
  /// In id, this message translates to:
  /// **'Cari panduan darurat...'**
  String get searchHint;

  /// No description provided for @callAmbulance.
  ///
  /// In id, this message translates to:
  /// **'Ambulans'**
  String get callAmbulance;

  /// No description provided for @callPolice.
  ///
  /// In id, this message translates to:
  /// **'Polisi'**
  String get callPolice;

  /// No description provided for @callFireDept.
  ///
  /// In id, this message translates to:
  /// **'Pemadam Kebakaran'**
  String get callFireDept;

  /// No description provided for @callEMS.
  ///
  /// In id, this message translates to:
  /// **'Layanan Medis (EMS)'**
  String get callEMS;

  /// No description provided for @sosButton.
  ///
  /// In id, this message translates to:
  /// **'PANGGIL DARURAT 112'**
  String get sosButton;

  /// No description provided for @shareLocation.
  ///
  /// In id, this message translates to:
  /// **'Bagikan Lokasi Saya'**
  String get shareLocation;

  /// No description provided for @locationMocked.
  ///
  /// In id, this message translates to:
  /// **'Koordinat lokasi disalin ke papan klip untuk dibagikan.'**
  String get locationMocked;

  /// No description provided for @cprIntro.
  ///
  /// In id, this message translates to:
  /// **'Resusitasi Jantung Paru (RJP)'**
  String get cprIntro;

  /// No description provided for @cprRateGuidance.
  ///
  /// In id, this message translates to:
  /// **'Rasio target: 100 - 120 kompresi per menit'**
  String get cprRateGuidance;

  /// No description provided for @cprStart.
  ///
  /// In id, this message translates to:
  /// **'MULAI RJP'**
  String get cprStart;

  /// No description provided for @cprPause.
  ///
  /// In id, this message translates to:
  /// **'JEDA'**
  String get cprPause;

  /// No description provided for @cprReset.
  ///
  /// In id, this message translates to:
  /// **'RESET'**
  String get cprReset;

  /// No description provided for @cprAudioEnable.
  ///
  /// In id, this message translates to:
  /// **'Bunyi Metronom'**
  String get cprAudioEnable;

  /// No description provided for @cprActionCompress.
  ///
  /// In id, this message translates to:
  /// **'TEKAN DADA'**
  String get cprActionCompress;

  /// No description provided for @cprActionRelease.
  ///
  /// In id, this message translates to:
  /// **'LEPAS'**
  String get cprActionRelease;

  /// No description provided for @settings.
  ///
  /// In id, this message translates to:
  /// **'Pengaturan'**
  String get settings;

  /// No description provided for @darkMode.
  ///
  /// In id, this message translates to:
  /// **'Mode Gelap'**
  String get darkMode;

  /// No description provided for @appInfo.
  ///
  /// In id, this message translates to:
  /// **'Informasi Aplikasi'**
  String get appInfo;

  /// No description provided for @offlineStatus.
  ///
  /// In id, this message translates to:
  /// **'Status Data Offline'**
  String get offlineStatus;

  /// No description provided for @offlineReady.
  ///
  /// In id, this message translates to:
  /// **'Semua panduan tersedia luring (Offline)'**
  String get offlineReady;

  /// No description provided for @resetDisclaimer.
  ///
  /// In id, this message translates to:
  /// **'Reset Tampilan Disclaimer'**
  String get resetDisclaimer;

  /// No description provided for @resetSuccess.
  ///
  /// In id, this message translates to:
  /// **'Tampilan disclaimer berhasil direset.'**
  String get resetSuccess;

  /// No description provided for @back.
  ///
  /// In id, this message translates to:
  /// **'Kembali'**
  String get back;

  /// No description provided for @next.
  ///
  /// In id, this message translates to:
  /// **'Selanjutnya'**
  String get next;

  /// No description provided for @quickAccess.
  ///
  /// In id, this message translates to:
  /// **'Akses Cepat Darurat'**
  String get quickAccess;

  /// No description provided for @allCategories.
  ///
  /// In id, this message translates to:
  /// **'Kategori Pertolongan Pertama'**
  String get allCategories;

  /// No description provided for @currentLocation.
  ///
  /// In id, this message translates to:
  /// **'Lokasi Saat Ini (Estimasi)'**
  String get currentLocation;

  /// No description provided for @learningTitle.
  ///
  /// In id, this message translates to:
  /// **'Koleksi Pembelajaran'**
  String get learningTitle;

  /// No description provided for @noGuideFound.
  ///
  /// In id, this message translates to:
  /// **'Panduan tidak ditemukan'**
  String get noGuideFound;

  /// No description provided for @version.
  ///
  /// In id, this message translates to:
  /// **'Versi'**
  String get version;

  /// No description provided for @tapToCall.
  ///
  /// In id, this message translates to:
  /// **'Ketuk untuk melakukan panggilan langsung'**
  String get tapToCall;
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
      <String>['en', 'id'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'id':
      return AppLocalizationsId();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
