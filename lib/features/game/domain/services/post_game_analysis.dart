import '../entities/game_state.dart';

class FounderProfileAnalysis {
  final String founderArchetype;
  final String riskRating;
  final List<String> keyStrengths;
  final List<String> strategicWeaknesses;
  final String aiVerdict;

  const FounderProfileAnalysis({
    required this.founderArchetype,
    required this.riskRating,
    required this.keyStrengths,
    required this.strategicWeaknesses,
    required this.aiVerdict,
  });
}

class PostGameAnalysisService {
  FounderProfileAnalysis analyzeGameOutcome(GameState finalState) {
    bool isVictorious = finalState.cash > 0 && finalState.monthlyRevenue > 50000;
    
    if (isVictorious) {
      return const FounderProfileAnalysis(
        founderArchetype: 'The Capital Disciplinarian',
        riskRating: 'Moderate / Calculated',
        keyStrengths: [
          'High capital efficiency',
          'Disciplined burn rate management',
          'Focus on sustainable MRR growth',
        ],
        strategicWeaknesses: [
          'Slightly conservative product iteration speed',
        ],
        aiVerdict:
            'Outstanding execution! You balanced employee morale with runway preservation to reach a high-valuation scale-up.',
      );
    } else {
      return const FounderProfileAnalysis(
        founderArchetype: 'The Aggressive Growth Chaser',
        riskRating: 'High / High Velocity',
        keyStrengths: [
          'Bold market expansion moves',
          'High team morale focus',
        ],
        strategicWeaknesses: [
          'Premature scaling ahead of product-market fit',
          'High monthly burn rate relative to cash balance',
        ],
        aiVerdict:
            'A valuable learning experience. Expanding payroll and marketing too early exhausted runway before recurring revenue caught up.',
      );
    }
  }
}
