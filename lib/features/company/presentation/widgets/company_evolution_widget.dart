import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../shared/widgets/glass_card.dart';
import '../../../game/domain/entities/game_state.dart';

class CompanyEvolutionWidget extends StatelessWidget {
  final GameState state;

  const CompanyEvolutionWidget({
    super.key,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    final double valuation = state.monthlyRevenue * 12 * state.industryMultiple;
    final String currentStage = _calculateStageName(valuation, state.employeeCount);

    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('COMPANY EVOLUTION', style: AppTypography.titleMedium),
              Chip(
                backgroundColor: AppColors.primaryGlow,
                side: const BorderSide(color: AppColors.primary),
                label: Text(
                  currentStage,
                  style: AppTypography.bodySmall.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          LinearProgressIndicator(
            value: _calculateProgress(valuation),
            backgroundColor: AppColors.surfaceLight,
            color: AppColors.primary,
            minHeight: 8,
            borderRadius: BorderRadius.circular(4),
          ),
          const SizedBox(height: 8),
          Text(
            'Employees: ${state.employeeCount} • Active Users: ${state.activeCustomers}',
            style: AppTypography.bodySmall,
          ),
        ],
      ),
    );
  }

  String _calculateStageName(double valuation, int employees) {
    if (valuation >= 1000000000) return '🦄 Unicorn Empire';
    if (valuation >= 100000000) return '🚀 Global Scale-Up';
    if (valuation >= 10000000) return '📈 Series A Growth';
    if (employees >= 5) return '🌱 Seed Stage Startup';
    return '🛠️ Garage Startup';
  }

  double _calculateProgress(double valuation) {
    if (valuation >= 1000000000) return 1.0;
    return (valuation / 1000000000).clamp(0.05, 1.0);
  }
}
