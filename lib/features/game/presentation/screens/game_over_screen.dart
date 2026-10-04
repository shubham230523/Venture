import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../shared/widgets/glass_card.dart';
import '../../domain/entities/game_state.dart';
import '../../domain/services/post_game_analysis.dart';

class GameOverScreen extends StatelessWidget {
  final GameState finalState;
  final VoidCallback onRestartGame;

  const GameOverScreen({
    super.key,
    required this.finalState,
    required this.onRestartGame,
  });

  @override
  Widget build(BuildContext context) {
    final analysisService = PostGameAnalysisService();
    final analysis = analysisService.analyzeGameOutcome(finalState);
    final bool isWon = finalState.cash > 0 && finalState.monthlyRevenue > 50000;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                isWon ? 'UNICORN SCALE-UP' : 'BANKRUPTCY OUTCOME',
                style: AppTypography.bodySmall.copyWith(
                  color: isWon ? AppColors.success : AppColors.danger,
                  letterSpacing: 2,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                isWon ? 'Company Victory!' : 'Game Over',
                style: AppTypography.displayLarge,
              ),
              const SizedBox(height: 20),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      GlassCard(
                        borderColor: isWon ? AppColors.success : AppColors.danger,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('FOUNDER ARCHETYPE', style: AppTypography.bodySmall),
                            const SizedBox(height: 4),
                            Text(analysis.founderArchetype,
                                style: AppTypography.titleMedium.copyWith(color: AppColors.primary)),
                            const SizedBox(height: 12),
                            Text('AI VERDICT', style: AppTypography.bodySmall),
                            const SizedBox(height: 4),
                            Text(analysis.aiVerdict, style: AppTypography.bodyLarge),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      GlassCard(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('KEY STRENGTHS', style: AppTypography.titleMedium.copyWith(color: AppColors.success)),
                            const SizedBox(height: 8),
                            ...analysis.keyStrengths.map(
                              (s) => Padding(
                                padding: const EdgeInsets.only(bottom: 4.0),
                                child: Text('• $s', style: AppTypography.bodyLarge),
                              ),
                            ),
                            const SizedBox(height: 16),
                            Text('STRATEGIC WEAKNESSES', style: AppTypography.titleMedium.copyWith(color: AppColors.danger)),
                            const SizedBox(height: 8),
                            ...analysis.strategicWeaknesses.map(
                              (w) => Padding(
                                padding: const EdgeInsets.only(bottom: 4.0),
                                child: Text('• $w', style: AppTypography.bodyLarge),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton.icon(
                  onPressed: onRestartGame,
                  icon: const Icon(Icons.refresh, color: Colors.black),
                  label: Text('START NEW VENTURE',
                      style: AppTypography.titleMedium.copyWith(color: Colors.black)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
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
