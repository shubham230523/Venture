import 'package:flutter/material.dart';
import '../../../../core/animation/app_animations.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../shared/widgets/glass_card.dart';

class MetricCard extends StatelessWidget {
  final String label;
  final double value;
  final String Function(double) formatter;
  final IconData icon;
  final Color accentColor;
  final String? trendText;
  final bool isWarning;

  const MetricCard({
    super.key,
    required this.label,
    required this.value,
    required this.formatter,
    required this.icon,
    this.accentColor = AppColors.primary,
    this.trendText,
    this.isWarning = false,
  });

  @override
  Widget build(BuildContext context) {
    Widget content = GlassCard(
      borderColor: isWarning ? AppColors.danger : AppColors.cardBorder,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label.toUpperCase(),
                style: AppTypography.bodySmall.copyWith(
                  letterSpacing: 1.2,
                  fontWeight: FontWeight.bold,
                  color: isWarning ? AppColors.danger : AppColors.textSecondary,
                ),
              ),
              Icon(icon, color: accentColor, size: 20),
            ],
          ),
          const SizedBox(height: 12),
          AnimatedNumberTicker(
            value: value,
            formatter: formatter,
            style: AppTypography.monoNumber.copyWith(
              color: isWarning ? AppColors.danger : accentColor,
              fontSize: 22,
            ),
          ),
          if (trendText != null) ...[
            const SizedBox(height: 6),
            Text(
              trendText!,
              style: AppTypography.bodySmall.copyWith(
                color: accentColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ],
      ),
    );

    if (isWarning) {
      return PulseGlow(
        glowColor: AppColors.danger,
        child: content,
      );
    }

    return content;
  }
}
