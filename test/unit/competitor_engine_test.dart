import 'package:flutter_test/flutter_test.dart';
import 'package:venture/features/competitors/domain/services/competitor_engine.dart';
import 'package:venture/features/game/domain/entities/game_state.dart';

void main() {
  group('CompetitorEngine Unit Tests', () {
    test('initializes rival competitors with starting market share', () {
      final engine = CompetitorEngine();
      final competitors = engine.getInitialCompetitors();

      expect(competitors, hasLength(greaterThanOrEqualTo(2)));
      expect(competitors.first.companyName, isNotEmpty);
      expect(competitors.first.marketShare, greaterThan(0));
    });

    test('simulates competitive market share shift based on product quality', () {
      final engine = CompetitorEngine();
      const playerState = GameState(
        activeCustomers: 1000,
        monthlyRevenue: 20000.0,
      );

      final updatedRivals = engine.simulateCompetitorTurn(
        playerState: playerState,
        playerQualityRating: 80.0, // Superior product quality
      );

      // Higher player quality causes rival market share to shrink from 35.0 to 32.0
      expect(updatedRivals.first.marketShare, lessThan(35.0));
    });
  });
}
