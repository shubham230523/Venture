import 'package:flutter_test/flutter_test.dart';
import 'package:venture/features/game/domain/entities/game_state.dart';
import 'package:venture/features/investors/domain/services/investor_engine.dart';

void main() {
  group('InvestorEngine Unit Tests', () {
    test('calculates equity dilution and post-money valuation correctly', () {
      final engine = InvestorEngine();
      const proposal = TermSheetProposal(
        investorName: 'Apex Capital',
        investmentAmount: 1000000.0, // $1M
        preMoneyValuation: 4000000.0, // $4M
      );

      // Post-money = $5M. Equity = $1M / $5M = 20%
      expect(engine.calculatePostMoneyValuation(proposal), 5000000.0);
      expect(engine.calculateInvestorEquityPercentage(proposal), 20.0);
    });

    test('accepting term sheet injects cash and updates stage', () {
      final engine = InvestorEngine();
      const initialState = GameState(cash: 100000.0, stage: GameStage.seed);

      const proposal = TermSheetProposal(
        investorName: 'Apex Capital',
        investmentAmount: 1000000.0,
        preMoneyValuation: 4000000.0,
      );

      final updated = engine.acceptTermSheet(initialState, proposal);
      expect(updated.cash, 1100000.0);
    });
  });
}
