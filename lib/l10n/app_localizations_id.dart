// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Indonesian (`id`).
class AppLocalizationsId extends AppLocalizations {
  AppLocalizationsId([String locale = 'id']) : super(locale);

  @override
  String get appName => 'SIGAP';

  @override
  String get disclaimerTitle => 'Pernyataan Keamanan';

  @override
  String get disclaimerBody =>
      'Aplikasi ini memberikan panduan pertolongan pertama edukatif dan tidak menggantikan bantuan medis profesional.';

  @override
  String get disclaimerAccept => 'Saya Mengerti & Setuju';

  @override
  String get homeTitle => 'Beranda';

  @override
  String get emergencyTitle => 'Panggilan Darurat';

  @override
  String get cprTitle => 'Asisten RJP';

  @override
  String get learnTitle => 'Edukasi';

  @override
  String get profileTitle => 'Profil';

  @override
  String get searchHint => 'Cari panduan darurat...';

  @override
  String get callAmbulance => 'Ambulans';

  @override
  String get callPolice => 'Polisi';

  @override
  String get callFireDept => 'Pemadam Kebakaran';

  @override
  String get callEMS => 'Layanan Medis (EMS)';

  @override
  String get sosButton => 'PANGGIL DARURAT 112';

  @override
  String get shareLocation => 'Bagikan Lokasi Saya';

  @override
  String get locationMocked =>
      'Koordinat lokasi disalin ke papan klip untuk dibagikan.';

  @override
  String get cprIntro => 'Resusitasi Jantung Paru (RJP)';

  @override
  String get cprRateGuidance => 'Rasio target: 100 - 120 kompresi per menit';

  @override
  String get cprStart => 'MULAI RJP';

  @override
  String get cprPause => 'JEDA';

  @override
  String get cprReset => 'RESET';

  @override
  String get cprAudioEnable => 'Bunyi Metronom';

  @override
  String get cprActionCompress => 'TEKAN DADA';

  @override
  String get cprActionRelease => 'LEPAS';

  @override
  String get settings => 'Pengaturan';

  @override
  String get darkMode => 'Mode Gelap';

  @override
  String get appInfo => 'Informasi Aplikasi';

  @override
  String get offlineStatus => 'Status Data Offline';

  @override
  String get offlineReady => 'Semua panduan tersedia luring (Offline)';

  @override
  String get resetDisclaimer => 'Reset Tampilan Disclaimer';

  @override
  String get resetSuccess => 'Tampilan disclaimer berhasil direset.';

  @override
  String get back => 'Kembali';

  @override
  String get next => 'Selanjutnya';

  @override
  String get quickAccess => 'Akses Cepat Darurat';

  @override
  String get allCategories => 'Kategori Pertolongan Pertama';

  @override
  String get currentLocation => 'Lokasi Saat Ini (Estimasi)';

  @override
  String get learningTitle => 'Koleksi Pembelajaran';

  @override
  String get noGuideFound => 'Panduan tidak ditemukan';

  @override
  String get version => 'Versi';

  @override
  String get tapToCall => 'Ketuk untuk melakukan panggilan langsung';

  @override
  String get medicalReferences => 'Referensi Medis';

  @override
  String get medicalReferencesSubtitle =>
      'Sumber pedoman pertolongan pertama resmi';

  @override
  String get ahaReference =>
      'AHA (American Heart Association) - Pedoman RJP & Kegawatdaruratan Jantung.';

  @override
  String get kemenkesReference => 'Kemenkes RI - Pedoman P3K Nasional.';

  @override
  String get pmiReference => 'PMI & IFRC - Panduan Luka & Fraktur.';
}
