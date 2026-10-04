import 'package:flutter_test/flutter_test.dart';
import 'package:venture/features/game/domain/entities/game_state.dart';
import 'package:venture/features/game/domain/services/post_game_analysis.dart';

void main() {
  group('PostGameAnalysisService Tests', () {
    test('analyzes victorious state correctly', () {
      final service = PostGameAnalysisService();
      const state = GameState(
        cash: 1000000.0,
        monthlyRevenue: 100000.0,
      );

      final analysis = service.analyzeGameOutcome(state);
      expect(analysis.founderArchetype, 'The Capital Disciplinarian');
      expect(analysis.keyStrengths, isNotEmpty);
      expect(analysis.aiVerdict, contains('execution'));
    });

    test('analyzes failed bankrupt state correctly', () {
      final service = PostGameAnalysisService();
      const state = GameState(
        cash: 0.0,
        monthlyRevenue: 0.0,
      );

      final analysis = service.analyzeGameOutcome(state);
      expect(analysis.founderArchetype, 'The Aggressive Growth Chaser');
      expect(analysis.strategicWeaknesses, isNotEmpty);
      expect(analysis.aiVerdict, contains('learning experience'));
    });
  });
}
