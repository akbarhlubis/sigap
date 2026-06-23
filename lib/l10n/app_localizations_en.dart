// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'SIGAP';

  @override
  String get disclaimerTitle => 'Safety Disclaimer';

  @override
  String get disclaimerBody =>
      'This application provides educational first aid guidance and does not replace professional medical assistance.';

  @override
  String get disclaimerAccept => 'I Understand & Agree';

  @override
  String get homeTitle => 'Home';

  @override
  String get emergencyTitle => 'Emergency Calls';

  @override
  String get cprTitle => 'CPR Assistant';

  @override
  String get learnTitle => 'Learn';

  @override
  String get profileTitle => 'Profile';

  @override
  String get searchHint => 'Search emergency guides...';

  @override
  String get callAmbulance => 'Ambulance';

  @override
  String get callPolice => 'Police';

  @override
  String get callFireDept => 'Fire Department';

  @override
  String get callEMS => 'Medical Services (EMS)';

  @override
  String get sosButton => 'CALL EMERGENCY 112';

  @override
  String get shareLocation => 'Share My Location';

  @override
  String get locationMocked =>
      'Location coordinates copied to clipboard for sharing.';

  @override
  String get cprIntro => 'Cardiopulmonary Resuscitation (CPR)';

  @override
  String get cprRateGuidance =>
      'Target rate: 100 - 120 compressions per minute';

  @override
  String get cprStart => 'START CPR';

  @override
  String get cprPause => 'PAUSE';

  @override
  String get cprReset => 'RESET';

  @override
  String get cprAudioEnable => 'Metronome Beep';

  @override
  String get cprActionCompress => 'COMPRESS DOWNSWARD';

  @override
  String get cprActionRelease => 'RELEASE UPWARD';

  @override
  String get settings => 'Settings';

  @override
  String get darkMode => 'Dark Mode';

  @override
  String get appInfo => 'App Information';

  @override
  String get offlineStatus => 'Offline Data Status';

  @override
  String get offlineReady => 'All guides available offline';

  @override
  String get resetDisclaimer => 'Reset Disclaimer Visibility';

  @override
  String get resetSuccess => 'Disclaimer visibility status reset successfully.';

  @override
  String get back => 'Back';

  @override
  String get next => 'Next';

  @override
  String get quickAccess => 'Quick Emergency Access';

  @override
  String get allCategories => 'First Aid Categories';

  @override
  String get currentLocation => 'Current Location (Estimated)';

  @override
  String get learningTitle => 'Learning Resource Collection';

  @override
  String get noGuideFound => 'Guide not found';

  @override
  String get version => 'Version';

  @override
  String get tapToCall => 'Tap to make a direct emergency call';
}
