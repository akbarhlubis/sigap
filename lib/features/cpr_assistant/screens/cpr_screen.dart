import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_beep/flutter_beep.dart';
import '../../../core/constants/colors.dart';
import 'package:sigap/l10n/app_localizations.dart';

class CprScreen extends StatefulWidget {
  const CprScreen({super.key});

  @override
  State<CprScreen> createState() => _CprScreenState();
}

class _CprScreenState extends State<CprScreen> with SingleTickerProviderStateMixin {
  bool _isRunning = false;
  bool _audioEnabled = true;
  int _compressionCount = 0;

  // Session timer variables
  int _elapsedSeconds = 0;
  Timer? _sessionTimer;

  // Rhythm metronome variables (110 BPM -> 545.45 ms interval)
  Timer? _metronomeTimer;
  late AnimationController _pulseController;
  late Animation<double> _pulseScale;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 272), // Half of 545ms for rise-fall sync
    );
    _pulseScale = Tween<double>(begin: 1.0, end: 1.25).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _stopCpr();
    _pulseController.dispose();
    super.dispose();
  }

  void _toggleCpr() {
    if (_isRunning) {
      _pauseCpr();
    } else {
      _startCpr();
    }
  }

  void _startCpr() {
    setState(() {
      _isRunning = true;
    });

    // 1. Start Session Timer (updates every 1 second)
    _sessionTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _elapsedSeconds++;
      });
    });

    // 2. Start metronome tick (every 545 milliseconds)
    const tickDuration = Duration(milliseconds: 545);
    _metronomeTimer = Timer.periodic(tickDuration, (timer) {
      _triggerTick();
    });

    // Trigger immediate first tick
    _triggerTick();
  }

  void _triggerTick() {
    // Increment count
    setState(() {
      _compressionCount++;
    });

    // Run animation: pulse out, then return back
    _pulseController.forward().then((_) => _pulseController.reverse());

    // Play Beep if audio enabled
    if (_audioEnabled) {
      try {
        FlutterBeep.beep();
      } catch (_) {
        // Fallback or ignore in environment where beep isn't available
      }
    }
  }

  void _pauseCpr() {
    _metronomeTimer?.cancel();
    _sessionTimer?.cancel();
    setState(() {
      _isRunning = false;
    });
    _pulseController.reverse();
  }

  void _stopCpr() {
    _metronomeTimer?.cancel();
    _sessionTimer?.cancel();
  }

  void _resetCpr() {
    _pauseCpr();
    setState(() {
      _compressionCount = 0;
      _elapsedSeconds = 0;
    });
  }

  String _formatTime(int totalSeconds) {
    final minutes = (totalSeconds ~/ 60).toString().padLeft(2, '0');
    final seconds = (totalSeconds % 60).toString().padLeft(2, '0');
    return "$minutes:$seconds";
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // Check if the current animation is running to show release vs compress
    final isCompressing = _pulseController.status == AnimationStatus.forward;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          l10n.cprTitle,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Info Card
              Card(
                elevation: 0,
                color: isDark ? AppColors.cardDark : AppColors.tealLight.withValues(alpha: 0.4),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                  side: BorderSide(
                    color: isDark ? AppColors.borderDark : AppColors.borderLight,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      const Icon(Icons.info_outline_rounded, color: AppColors.tealPrimary),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          l10n.cprRateGuidance,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: isDark ? Colors.white : AppColors.textLightPrimary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Spacer(),

              // Rhythmic Visual Pacing Indicator
              Center(
                child: ScaleTransition(
                  scale: _pulseScale,
                  child: Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _isRunning
                          ? (isCompressing ? AppColors.severityCritical : AppColors.tealPrimary)
                          : (isDark ? AppColors.cardDark : Colors.white),
                      border: Border.all(
                        color: _isRunning
                            ? Colors.white.withValues(alpha: 0.8)
                            : AppColors.tealPrimary,
                        width: 8,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: (_isRunning
                                  ? (isCompressing ? AppColors.severityCritical : AppColors.tealPrimary)
                                  : AppColors.tealPrimary)
                              .withValues(alpha: _isRunning ? 0.4 : 0.1),
                          blurRadius: 20,
                          spreadRadius: _isRunning ? 10 : 2,
                        ),
                      ],
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.favorite_rounded,
                            color: _isRunning ? Colors.white : AppColors.severityCritical,
                            size: 40,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            _isRunning
                                ? (isCompressing ? l10n.cprActionCompress : l10n.cprActionRelease)
                                : "READY",
                            style: TextStyle(
                              color: _isRunning ? Colors.white : AppColors.tealPrimary,
                              fontSize: 18,
                              fontWeight: FontWeight.w900,
                              letterSpacing: 0.5,
                            ),
                          ),
                          if (_isRunning) ...[
                            const SizedBox(height: 4),
                            const Text(
                              "110 BPM",
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              
              const Spacer(),

              // Stats Row (Timer & Counter)
              Row(
                children: [
                  Expanded(
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: Column(
                          children: [
                            const Text(
                              "DURASI",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: AppColors.tealPrimary,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              _formatTime(_elapsedSeconds),
                              style: const TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.w900,
                                fontFamily: 'monospace',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: Column(
                          children: [
                            const Text(
                              "KOMPRESI",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: AppColors.tealPrimary,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              "$_compressionCount",
                              style: const TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.w900,
                                fontFamily: 'monospace',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Audio Toggle Switch Card
              Card(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                  side: BorderSide(color: isDark ? AppColors.borderDark : AppColors.borderLight),
                ),
                child: SwitchListTile(
                  title: Text(
                    l10n.cprAudioEnable,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  value: _audioEnabled,
                  onChanged: (bool value) {
                    setState(() {
                      _audioEnabled = value;
                    });
                  },
                  activeThumbColor: AppColors.tealPrimary,
                  secondary: Icon(
                    _audioEnabled ? Icons.volume_up_rounded : Icons.volume_off_rounded,
                    color: AppColors.tealPrimary,
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Action Buttons (Giant controls)
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: ElevatedButton.icon(
                      onPressed: _toggleCpr,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _isRunning ? AppColors.severityModerate : AppColors.tealPrimary,
                        minimumSize: const Size(double.infinity, 64),
                      ),
                      icon: Icon(_isRunning ? Icons.pause_rounded : Icons.play_arrow_rounded, size: 28),
                      label: Text(
                        _isRunning ? l10n.cprPause : l10n.cprStart,
                        style: const TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    flex: 1,
                    child: OutlinedButton.icon(
                      onPressed: _resetCpr,
                      style: OutlinedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 64),
                        side: BorderSide(
                          color: isDark ? AppColors.borderDark : AppColors.borderLight,
                          width: 2,
                        ),
                      ),
                      icon: const Icon(Icons.refresh_rounded),
                      label: Text(l10n.cprReset),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
