import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/constants/colors.dart';
import 'package:sigap/l10n/app_localizations.dart';

class DisclaimerGate extends StatefulWidget {
  final Widget child;

  const DisclaimerGate({super.key, required this.child});

  @override
  State<DisclaimerGate> createState() => _DisclaimerGateState();
}

class _DisclaimerGateState extends State<DisclaimerGate> {
  bool _isLoading = true;
  bool _accepted = false;

  @override
  void initState() {
    super.initState();
    _checkDisclaimerStatus();
  }

  Future<void> _checkDisclaimerStatus() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _accepted = prefs.getBool('disclaimer_accepted') ?? false;
      _isLoading = false;
    });
  }

  Future<void> _acceptDisclaimer() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('disclaimer_accepted', true);
    setState(() {
      _accepted = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(color: AppColors.tealPrimary),
        ),
      );
    }

    if (_accepted) {
      return widget.child;
    }

    final l10n = AppLocalizations.of(context)!;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.bgDark : AppColors.bgLight,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(),
              // Emergency Icon / Logo
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: AppColors.severityCritical.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.warning_amber_rounded,
                  size: 56,
                  color: AppColors.severityCritical,
                ),
              ),
              const SizedBox(height: 32),
              
              // Disclaimer Title
              Text(
                l10n.disclaimerTitle,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontSize: 26,
                      fontWeight: FontWeight.w800,
                      color: isDark ? Colors.white : AppColors.textLightPrimary,
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              
              // Disclaimer Card
              Card(
                elevation: 0,
                color: isDark ? AppColors.cardDark : Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: BorderSide(
                    color: isDark ? AppColors.borderDark : AppColors.borderLight,
                    width: 1.5,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Text(
                    l10n.disclaimerBody,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontSize: 16,
                          height: 1.6,
                          fontWeight: FontWeight.w500,
                          color: isDark ? AppColors.textDarkSecondary : AppColors.textLightSecondary,
                        ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              
              // Emergency Warning Subtext
              Text(
                l10n.tapToCall,
                style: const TextStyle(
                  color: AppColors.severityCritical,
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              
              const Spacer(),
              
              // Accept Button
              ElevatedButton(
                onPressed: _acceptDisclaimer,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.severityCritical, // High contrast warning action
                  minimumSize: const Size(double.infinity, 60),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: Text(
                  l10n.disclaimerAccept,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
