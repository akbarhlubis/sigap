import 'package:flutter/material.dart';
import '../../core/constants/colors.dart';
import '../../features/emergency_flows/screens/home_screen.dart';
import '../../features/emergency_calls/screens/calls_screen.dart';
import '../../features/learning/screens/learning_screen.dart';
import '../../features/profile/screens/profile_screen.dart';
import 'package:sigap/l10n/app_localizations.dart';

class NavigationShell extends StatefulWidget {
  const NavigationShell({super.key});

  @override
  State<NavigationShell> createState() => _NavigationShellState();
}

class _NavigationShellState extends State<NavigationShell> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const CallsScreen(),
    const LearningScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: isDark ? AppColors.borderDark : AppColors.borderLight,
              width: 1.0,
            ),
          ),
        ),
        child: NavigationBar(
          selectedIndex: _currentIndex,
          onDestinationSelected: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          backgroundColor: isDark ? AppColors.bgDark : Colors.white,
          indicatorColor: AppColors.tealPrimary.withOpacity(0.15),
          destinations: [
            NavigationDestination(
              icon: const Icon(Icons.home_outlined),
              selectedIcon: const Icon(Icons.home, color: AppColors.tealPrimary),
              label: l10n.homeTitle,
            ),
            NavigationDestination(
              icon: const Icon(Icons.phone_in_talk_outlined),
              selectedIcon: const Icon(Icons.phone_in_talk, color: AppColors.tealPrimary),
              label: l10n.emergencyTitle,
            ),
            NavigationDestination(
              icon: const Icon(Icons.local_library_outlined),
              selectedIcon: const Icon(Icons.local_library, color: AppColors.tealPrimary),
              label: l10n.learnTitle,
            ),
            NavigationDestination(
              icon: const Icon(Icons.person_outline),
              selectedIcon: const Icon(Icons.person, color: AppColors.tealPrimary),
              label: l10n.profileTitle,
            ),
          ],
        ),
      ),
    );
  }
}
