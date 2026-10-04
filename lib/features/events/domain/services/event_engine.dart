import '../../../game/domain/entities/game_state.dart';

class EventChoice {
  final String text;
  final double cashImpact;
  final double moraleImpact;
  final double revenueImpact;

  const EventChoice({
    required this.text,
    this.cashImpact = 0.0,
    this.moraleImpact = 0.0,
    this.revenueImpact = 0.0,
  });
}

class GameEvent {
  final String id;
  final String title;
  final String description;
  final List<EventChoice> choices;

  const GameEvent({
    required this.id,
    required this.title,
    required this.description,
    required this.choices,
  });
}

class EventEngine {
  GameEvent? evaluateMonthlyEvents(GameState state) {
    // 1. High Burn / Low Runway Crisis
    double netLoss = state.monthlyExpenses - state.monthlyRevenue;
    if (netLoss > 20000 && state.cash < 150000) {
      return const GameEvent(
        id: 'burn_crisis',
        title: 'CRISIS: Cash Burn Accelerating',
        description:
            'Your monthly burn rate is high and cash runway is under 4 months. The board is requesting immediate capital discipline.',
        choices: [
          EventChoice(
            text: 'Cut marketing & halt hiring',
            cashImpact: 20000.0,
            moraleImpact: -0.10,
          ),
          EventChoice(
            text: 'Maintain aggressive growth stance',
            cashImpact: -10000.0,
            moraleImpact: 0.05,
          ),
        ],
      );
    }

    // 2. Default Random Opportunity
    return const GameEvent(
      id: 'viral_pr',
      title: 'OPPORTUNITY: Unexpected Viral Coverage',
      description:
          'A prominent tech analyst featured your startup in a viral newsletter.',
      choices: [
        EventChoice(
          text: 'Capitalize with targeted marketing boost (\$15k)',
          cashImpact: -15000.0,
          revenueImpact: 5000.0,
          moraleImpact: 0.05,
        ),
        EventChoice(
          text: 'Focus on core product stability',
          cashImpact: 0.0,
          revenueImpact: 1000.0,
        ),
      ],
    );
  }

  GameState applyChoiceEffect(GameState state, EventChoice choice) {
    double updatedCash = (state.cash + choice.cashImpact).clamp(0.0, double.infinity);
    double updatedMorale = (state.averageMorale + choice.moraleImpact).clamp(0.0, 1.0);
    double updatedRevenue = (state.monthlyRevenue + choice.revenueImpact).clamp(0.0, double.infinity);

    return state.copyWith(
      cash: updatedCash,
      averageMorale: updatedMorale,
      monthlyRevenue: updatedRevenue,
    );
  }
}
