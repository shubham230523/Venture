import 'package:flutter_test/flutter_test.dart';
import 'package:venture/features/game/domain/entities/game_state.dart';
import 'package:venture/features/marketing/domain/services/marketing_engine.dart';

void main() {
  group('MarketingEngine Unit Tests', () {
    test('calculates campaign acquired customers and updates CAC', () {
      final engine = MarketingEngine();
      const initialState = GameState(
        customerAcquisitionCost: 100.0,
        activeCustomers: 1000,
        monthlyRevenue: 20000.0,
      );

      final campaign = MarketingCampaign(
        id: 'perf_ads',
        name: 'Performance Ad Campaign',
        monthlyBudget: 10000.0,
        targetCac: 50.0,
        brandAwarenessGain: 5.0,
      );

      final result = engine.runCampaign(initialState, campaign);
      // $10,000 / $50 CAC = 200 new customers
      expect(result.activeCustomers, 1200);
      expect(result.customerAcquisitionCost, 50.0);
    });

    test('brand awareness boosts organic customer acquisition multiplier', () {
      final engine = MarketingEngine();
      expect(engine.calculateBrandMultiplier(brandAwarenessScore: 80.0), 1.40);
      expect(engine.calculateBrandMultiplier(brandAwarenessScore: 0.0), 1.00);
    });
  });
}
