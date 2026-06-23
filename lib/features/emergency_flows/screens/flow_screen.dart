import 'package:flutter/material.dart';
import '../../../core/constants/colors.dart';
import '../../../models/emergency_models.dart';
import 'package:sigap/l10n/app_localizations.dart';

class FlowScreen extends StatefulWidget {
  final EmergencyCategory category;

  const FlowScreen({super.key, required this.category});

  @override
  State<FlowScreen> createState() => _FlowScreenState();
}

class _FlowScreenState extends State<FlowScreen> with SingleTickerProviderStateMixin {
  late String _currentNodeId;
  final List<String> _history = [];
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _currentNodeId = widget.category.startNodeId;
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onOptionSelected(String? nextNodeId) {
    if (nextNodeId == null) return;
    setState(() {
      _history.add(_currentNodeId);
      _currentNodeId = nextNodeId;
    });
  }

  void _onBack() {
    if (_history.isEmpty) {
      Navigator.pop(context);
    } else {
      setState(() {
        _currentNodeId = _history.removeLast();
      });
    }
  }

  Color _getSeverityColor() {
    switch (widget.category.severity.toLowerCase()) {
      case 'critical':
        return AppColors.severityCritical;
      case 'moderate':
        return AppColors.severityModerate;
      default:
        return AppColors.severityLow;
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final locale = Localizations.localeOf(context).languageCode;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final node = widget.category.nodes[_currentNodeId];
    if (node == null) {
      return Scaffold(
        appBar: AppBar(title: Text(widget.category.title.value(locale))),
        body: Center(child: Text(l10n.noGuideFound)),
      );
    }

    final sevColor = _getSeverityColor();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: _onBack,
        ),
        title: Column(
          children: [
            Text(
              widget.category.title.value(locale),
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 2),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: sevColor.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                widget.category.severity.toUpperCase(),
                style: TextStyle(
                  color: sevColor,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.close_rounded),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Column(
              children: [
                // Top Progress indicator
                LinearProgressIndicator(
                  value: _history.isEmpty ? 0.1 : (_history.length / (_history.length + 2)),
                  backgroundColor: isDark ? AppColors.borderDark : AppColors.borderLight,
                  color: sevColor,
                  minHeight: 4,
                ),
                
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // 1. Oversized Question/Title
                          Text(
                            node.question.value(locale),
                            style: Theme.of(context).textTheme.displayMedium?.copyWith(
                                  fontSize: 26,
                                  fontWeight: FontWeight.w900,
                                  height: 1.3,
                                  color: isDark ? Colors.white : AppColors.textLightPrimary,
                                ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 24),
                          
                          // 2. Procedural Animation Box
                          Container(
                            height: 200,
                            decoration: BoxDecoration(
                              color: isDark ? AppColors.cardDark : AppColors.tealLight.withValues(alpha: 0.3),
                              borderRadius: BorderRadius.circular(24),
                              border: Border.all(
                                color: isDark ? AppColors.borderDark : AppColors.borderLight,
                                width: 1.5,
                              ),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(24),
                              child: AnimatedBuilder(
                                animation: _animationController,
                                builder: (context, child) {
                                  return CustomPaint(
                                    painter: FlowIllustrationPainter(
                                      illustrationId: node.illustration,
                                      animationValue: _animationController.value,
                                      primaryColor: sevColor,
                                      isDark: isDark,
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                          const SizedBox(height: 24),
                          
                          // 3. Simple Action/Explanation Text
                          Container(
                            padding: const EdgeInsets.all(18),
                            decoration: BoxDecoration(
                              color: isDark ? AppColors.cardDark : Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: isDark ? AppColors.borderDark : AppColors.borderLight,
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.info_outline_rounded, color: sevColor, size: 20),
                                    const SizedBox(width: 8),
                                    Text(
                                      l10n.appName.toUpperCase(),
                                      style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w900,
                                        color: sevColor,
                                        letterSpacing: 1.0,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  node.explanation.value(locale),
                                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                        fontSize: 15,
                                        height: 1.5,
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
                ),
                
                // 4. Large Action Buttons
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    children: [
                      if (node.isLeaf)
                        ElevatedButton.icon(
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(Icons.check_circle_outline_rounded),
                          label: Text(l10n.back.toUpperCase()),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.tealPrimary,
                            minimumSize: const Size(double.infinity, 64),
                          ),
                        )
                      else
                        ...node.options.map((option) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 12.0),
                            child: ElevatedButton(
                              onPressed: () => _onOptionSelected(option.nextNodeId),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: isDark ? AppColors.cardDark : Colors.white,
                                foregroundColor: isDark ? Colors.white : AppColors.textLightPrimary,
                                side: BorderSide(
                                  color: isDark ? AppColors.borderDark : AppColors.borderLight,
                                  width: 2,
                                ),
                                minimumSize: const Size(double.infinity, 64),
                                elevation: 0,
                              ),
                              child: Text(
                                option.text.value(locale),
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w900,
                                  color: isDark ? Colors.white : AppColors.textLightPrimary,
                                ),
                              ),
                            ),
                          );
                        }),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

// Procedural vector drawer for first aid actions
class FlowIllustrationPainter extends CustomPainter {
  final String illustrationId;
  final double animationValue;
  final Color primaryColor;
  final bool isDark;

  FlowIllustrationPainter({
    required this.illustrationId,
    required this.animationValue,
    required this.primaryColor,
    required this.isDark,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0
      ..strokeCap = StrokeCap.round;

    final fillPaint = Paint()
      ..style = PaintingStyle.fill;

    final accentColor = isDark ? Colors.white : AppColors.textLightPrimary;
    final gridPaint = Paint()
      ..color = (isDark ? AppColors.borderDark : AppColors.borderLight).withValues(alpha: 0.3)
      ..strokeWidth = 1.0;

    // Draw reference grids for background visual aesthetics
    for (double i = 0; i < size.width; i += 20) {
      canvas.drawLine(Offset(i, 0), Offset(i, size.height), gridPaint);
    }
    for (double i = 0; i < size.height; i += 20) {
      canvas.drawLine(Offset(0, i), Offset(size.width, i), gridPaint);
    }

    final cx = size.width / 2;
    final cy = size.height / 2;

    switch (illustrationId) {
      case 'choking_conscious':
      case 'check_responsiveness':
        // Shoulder Tap Action
        paint.color = accentColor;
        // Draw head
        canvas.drawCircle(Offset(cx - 30, cy - 20), 20, paint);
        // Draw torso
        canvas.drawLine(Offset(cx - 30, cy), Offset(cx - 30, cy + 50), paint);
        canvas.drawLine(Offset(cx - 30, cy + 10), Offset(cx + 10, cy + 15), paint); // arm

        // Hands tapping shoulder
        paint.color = primaryColor;
        final tapOffset = animationValue * 8.0;
        canvas.drawCircle(Offset(cx + 10 - tapOffset, cy + 15), 6, fillPaint..color = primaryColor);
        // Tap waves
        canvas.drawArc(
          Rect.fromCircle(center: Offset(cx + 25 - tapOffset, cy + 15), radius: 8),
          -1.0, 2.0, false, paint..strokeWidth = 2,
        );
        break;

      case 'heimlich_maneuver':
        // Abdominal thrust vectors (arrows pushing inward & upward)
        paint.color = accentColor;
        // Torso outline
        canvas.drawCircle(Offset(cx, cy - 30), 25, paint);
        canvas.drawLine(Offset(cx, cy - 5), Offset(cx, cy + 60), paint);

        // Arrows showing Heimlich motion
        paint.color = primaryColor;
        paint.strokeWidth = 4.0;
        final arrowOffset = animationValue * 15.0;

        // Inward-upward path
        final path = Path()
          ..moveTo(cx - 50 + arrowOffset, cy + 20)
          ..quadraticBezierTo(cx - 20 + arrowOffset, cy + 20, cx - 15, cy + 5);
        canvas.drawPath(path, paint);

        // Arrowhead
        final arrowhead = Path()
          ..moveTo(cx - 25, cy + 5)
          ..lineTo(cx - 15, cy + 5)
          ..lineTo(cx - 15, cy + 15);
        canvas.drawPath(arrowhead, paint);
        break;

      case 'cpr_instruction':
        // Chest compression area with arrows
        paint.color = accentColor;
        // Draw chest oval
        canvas.drawOval(Rect.fromCenter(center: Offset(cx, cy + 10), width: 140, height: 70), paint);

        // Target spot (Heart/Sternum)
        fillPaint.color = primaryColor.withValues(alpha: 0.3);
        canvas.drawCircle(Offset(cx, cy + 10), 20 + (animationValue * 10), fillPaint);
        paint.color = primaryColor;
        paint.strokeWidth = 4;
        canvas.drawCircle(Offset(cx, cy + 10), 10, paint);

        // Downward arrows
        final pulseY = cy - 40 + (animationValue * 15);
        canvas.drawLine(Offset(cx, pulseY), Offset(cx, cy - 10), paint);
        canvas.drawLine(Offset(cx - 8, cy - 18), Offset(cx, cy - 10), paint);
        canvas.drawLine(Offset(cx + 8, cy - 18), Offset(cx, cy - 10), paint);
        break;

      case 'fainting_elevate_legs':
        // Legs elevated on a block
        paint.color = accentColor;
        // Torso horizontal
        canvas.drawLine(Offset(cx - 60, cy + 20), Offset(cx + 30, cy + 20), paint);
        // Head
        canvas.drawCircle(Offset(cx - 75, cy + 20), 12, paint);
        
        // Pillow/Support block
        canvas.drawRect(Rect.fromLTWH(cx + 25, cy + 10, 40, 20), paint);

        // Elevated legs
        paint.color = primaryColor;
        paint.strokeWidth = 4.0;
        canvas.drawLine(Offset(cx + 10, cy + 20), Offset(cx + 45, cy - 5), paint);
        canvas.drawLine(Offset(cx + 45, cy - 5), Offset(cx + 65, cy - 5), paint);
        break;

      case 'direct_pressure':
        // Hand pressing down on wound
        paint.color = accentColor;
        // Limb outline
        canvas.drawRect(Rect.fromCenter(center: Offset(cx, cy + 25), width: 160, height: 40), paint);
        
        // Red wound
        fillPaint.color = AppColors.severityCritical;
        canvas.drawOval(Rect.fromCenter(center: Offset(cx, cy + 25), width: 25, height: 12), fillPaint);

        // Hand graphic pressing down
        paint.color = primaryColor;
        paint.strokeWidth = 3.0;
        final pressY = cy - 25 + (animationValue * 10);
        canvas.drawLine(Offset(cx, pressY), Offset(cx, cy + 15), paint);
        canvas.drawLine(Offset(cx - 15, cy + 5), Offset(cx + 15, cy + 5), paint);
        break;

      case 'recovery_position':
        // Stylized person on their side
        paint.color = primaryColor;
        // Curving spine
        final bodyPath = Path()
          ..moveTo(cx - 60, cy + 10)
          ..quadraticBezierTo(cx, cy - 10, cx + 60, cy + 15);
        canvas.drawPath(bodyPath, paint);
        // Head tilted slightly forward
        canvas.drawCircle(Offset(cx - 75, cy), 12, paint);
        
        // Arm bent under head supporting it
        paint.color = accentColor;
        canvas.drawLine(Offset(cx - 60, cy + 10), Offset(cx - 65, cy - 5), paint);
        canvas.drawLine(Offset(cx - 65, cy - 5), Offset(cx - 75, cy + 5), paint);
        break;

      default:
        // Default animated medical cross pulsing
        paint.color = primaryColor;
        paint.strokeWidth = 8.0;
        final pulseScale = 1.0 + (animationValue * 0.15);
        
        canvas.save();
        canvas.translate(cx, cy);
        canvas.scale(pulseScale);
        
        // Vertical line
        canvas.drawLine(const Offset(0, -35), const Offset(0, 35), paint);
        // Horizontal line
        canvas.drawLine(const Offset(-35, 0), const Offset(35, 0), paint);
        
        canvas.restore();
        break;
    }
  }

  @override
  bool shouldRepaint(covariant FlowIllustrationPainter oldDelegate) {
    return oldDelegate.animationValue != animationValue ||
        oldDelegate.illustrationId != illustrationId ||
        oldDelegate.isDark != isDark;
  }
}
