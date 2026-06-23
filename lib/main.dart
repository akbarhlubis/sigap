import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sigap/l10n/app_localizations.dart';

import 'core/theme.dart';
import 'services/emergency_service.dart';
import 'shared/widgets/disclaimer_gate.dart';
import 'shared/widgets/navigation_shell.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Pre-load local emergency guides asset
  final emergencyService = EmergencyService();
  await emergencyService.loadGuides();

  runApp(const SigapApp());
}

class SigapApp extends StatefulWidget {
  const SigapApp({super.key});

  // ignore: library_private_types_in_public_api
  static _SigapAppState? of(BuildContext context) =>
      context.findAncestorStateOfType<_SigapAppState>();

  @override
  State<SigapApp> createState() => _SigapAppState();
}

class _SigapAppState extends State<SigapApp> {
  ThemeMode _themeMode = ThemeMode.system;
  Locale _locale = const Locale('id'); // Default is Bahasa Indonesia

  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  Future<void> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final themeStr = prefs.getString('theme_mode') ?? 'system';
    final langStr = prefs.getString('language_code') ?? 'id';

    setState(() {
      _locale = Locale(langStr);
      if (themeStr == 'light') {
        _themeMode = ThemeMode.light;
      } else if (themeStr == 'dark') {
        _themeMode = ThemeMode.dark;
      } else {
        _themeMode = ThemeMode.system;
      }
    });
  }

  Future<void> changeThemeMode(ThemeMode newMode) async {
    if (_themeMode == newMode) return;
    final prefs = await SharedPreferences.getInstance();
    String themeStr = 'system';
    if (newMode == ThemeMode.light) themeStr = 'light';
    if (newMode == ThemeMode.dark) themeStr = 'dark';
    
    await prefs.setString('theme_mode', themeStr);
    setState(() {
      _themeMode = newMode;
    });
  }

  Future<void> changeLocale(Locale newLocale) async {
    if (_locale == newLocale) return;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('language_code', newLocale.languageCode);
    setState(() {
      _locale = newLocale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SIGAP',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: _themeMode,
      locale: _locale,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('id'), // Bahasa Indonesia
        Locale('en'), // English
      ],
      home: const DisclaimerGate(
        child: NavigationShell(),
      ),
    );
  }
}
