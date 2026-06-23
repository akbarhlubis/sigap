import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/constants/colors.dart';
import '../../../main.dart';
import 'package:sigap/l10n/app_localizations.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String _databaseSize = "62 KB";

  Future<void> _resetDisclaimerStatus() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('disclaimer_accepted', false);
    
    if (mounted) {
      final l10n = AppLocalizations.of(context)!;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(l10n.resetSuccess),
          backgroundColor: AppColors.tealPrimary,
          behavior: SnackBarBehavior.floating,
        ),
      );
      // Restart application state by asking the user to restart, or forcing trigger.
      // For verification, clearing it is enough, next launch will show the disclaimer.
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final activeLocale = Localizations.localeOf(context);
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final sigapState = SigapApp.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          l10n.profileTitle,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20.0),
          children: [
            // User App branding header
            Center(
              child: Column(
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: AppColors.tealPrimary.withOpacity(0.15),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.shield_rounded,
                      size: 48,
                      color: AppColors.tealPrimary,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    l10n.appName,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1.0,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    l10n.version + " 1.0.0 (MVP)",
                    style: TextStyle(
                      fontSize: 14,
                      color: isDark ? AppColors.textDarkSecondary : AppColors.textLightSecondary,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // Settings Header
            Text(
              l10n.settings,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: AppColors.tealPrimary,
                letterSpacing: 0.5,
              ),
            ),
            const SizedBox(height: 8),

            // Language Selector Card
            Card(
              child: ListTile(
                leading: const Icon(Icons.language_rounded, color: AppColors.tealPrimary),
                title: const Text(
                  "Bahasa / Language",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  activeLocale.languageCode == 'en' ? "English" : "Bahasa Indonesia",
                ),
                trailing: DropdownButton<String>(
                  value: activeLocale.languageCode,
                  underline: const SizedBox(),
                  dropdownColor: isDark ? AppColors.cardDark : Colors.white,
                  icon: const Icon(Icons.keyboard_arrow_down_rounded),
                  onChanged: (String? newValue) {
                    if (newValue != null && sigapState != null) {
                      sigapState.changeLocale(Locale(newValue));
                    }
                  },
                  items: const [
                    DropdownMenuItem(value: 'id', child: Text('Bahasa Indonesia')),
                    DropdownMenuItem(value: 'en', child: Text('English')),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8),

            // Dark Mode Selector Card
            Card(
              child: SwitchListTile(
                secondary: Icon(
                  isDark ? Icons.dark_mode_rounded : Icons.light_mode_rounded,
                  color: AppColors.tealPrimary,
                ),
                title: Text(
                  l10n.darkMode,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                value: isDark,
                onChanged: (bool value) {
                  if (sigapState != null) {
                    sigapState.changeThemeMode(value ? ThemeMode.dark : ThemeMode.light);
                  }
                },
                activeColor: AppColors.tealPrimary,
              ),
            ),
            const SizedBox(height: 24),

            // Offline Status Section
            Text(
              l10n.offlineStatus,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: AppColors.tealPrimary,
                letterSpacing: 0.5,
              ),
            ),
            const SizedBox(height: 8),

            // Offline Database Card
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.check, color: Colors.white, size: 18),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            l10n.offlineReady,
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "Database: $_databaseSize (JSON Local Asset)",
                            style: TextStyle(
                              fontSize: 12,
                              color: isDark ? AppColors.textDarkSecondary : AppColors.textLightSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Developer / Debug Settings Header
            Text(
              "SISTEM & DIAGNOSTIK",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: isDark ? AppColors.textDarkSecondary : AppColors.textLightSecondary,
                letterSpacing: 0.5,
              ),
            ),
            const SizedBox(height: 8),

            // Reset Onboarding Button
            Card(
              child: ListTile(
                onTap: _resetDisclaimerStatus,
                leading: const Icon(Icons.restart_alt_rounded, color: AppColors.severityCritical),
                title: Text(
                  l10n.resetDisclaimer,
                  style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.severityCritical),
                ),
                subtitle: const Text("Tampilkan kembali dialog syarat & ketentuan darurat"),
                trailing: const Icon(Icons.chevron_right_rounded),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
