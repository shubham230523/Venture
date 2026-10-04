import 'package:flutter_test/flutter_test.dart';
import 'package:venture/features/events/domain/services/event_engine.dart';
import 'package:venture/features/game/domain/entities/game_state.dart';

void main() {
  group('EventEngine & AI Game Master Tests', () {
    test('triggers market events based on current game state conditions', () {
      final engine = EventEngine();
      const stateWithHighBurn = GameState(
        cash: 100000,
        monthlyRevenue: 5000,
        monthlyExpenses: 45000, // High burn rate ($40k/mo)
      );

      final event = engine.evaluateMonthlyEvents(stateWithHighBurn);
      expect(event, isNotNull);
      expect(event!.title, isNotEmpty);
      expect(event.choices, hasLength(greaterThanOrEqualTo(2)));
    });

    test('applies choice effects deterministically to GameState', () {
      final engine = EventEngine();
      const initialState = GameState(cash: 100000);

      final choice = EventChoice(
        text: 'Secure emergency credit line',
        cashImpact: 50000.0,
        moraleImpact: -0.05,
      );

      final updatedState = engine.applyChoiceEffect(initialState, choice);
      expect(updatedState.cash, 150000.0);
      expect(updatedState.averageMorale, closeTo(0.80, 0.01));
    });
  });
}
