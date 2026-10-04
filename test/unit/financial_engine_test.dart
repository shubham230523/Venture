import 'package:flutter_test/flutter_test.dart';
import 'package:venture/features/finance/domain/services/financial_engine.dart';
import 'package:venture/features/game/domain/entities/game_state.dart';

void main() {
  group('FinancialEngine Boundary & Formula Tests', () {
    test('calculates burn rate and net profit correctly', () {
      const state = GameState(
        cash: 500000,
        monthlyRevenue: 20000,
        monthlyExpenses: 50000,
      );

      final engine = FinancialEngine();
      expect(engine.calculateBurnRate(state), 30000);
      expect(engine.calculateNetProfit(state), -30000);
    });

    test('calculates runway months accurately', () {
      const state = GameState(
        cash: 120000,
        monthlyRevenue: 10000,
        monthlyExpenses: 30000,
      );

      final engine = FinancialEngine();
      // Burn = 20,000/mo. Runway = 120,000 / 20,000 = 6 months
      expect(engine.calculateRunwayMonths(state), 6.0);
    });

    test('handles profitable cash flow with infinite runway', () {
      const state = GameState(
        cash: 500000,
        monthlyRevenue: 60000,
        monthlyExpenses: 40000,
      );

      final engine = FinancialEngine();
      expect(engine.calculateBurnRate(state), 0); // No burn
      expect(engine.calculateRunwayMonths(state), double.infinity);
    });

    test('handles zero cash / negative runway boundary conditions', () {
      const state = GameState(
        cash: 0,
        monthlyRevenue: 0,
        monthlyExpenses: 10000,
      );

      final engine = FinancialEngine();
      expect(engine.calculateRunwayMonths(state), 0.0);
      expect(engine.isBankrupt(state), isTrue);
    });

    test('calculates ARR and valuation multiples correctly', () {
      const postRevenueState = GameState(
        cash: 1000000,
        monthlyRevenue: 100000, // $1.2M ARR
        monthlyExpenses: 80000,
        industryMultiple: 10.0,
      );

      final engine = FinancialEngine();
      expect(engine.calculateARR(postRevenueState), 1200000);
      expect(engine.calculateValuation(postRevenueState), 12000000); // $12M
    });

    test('detects Unicorn valuation and bankruptcy game over triggers', () {
      const unicornState = GameState(
        cash: 50000000,
        monthlyRevenue: 10000000, // $120M ARR * 10x = $1.2B
        industryMultiple: 10.0,
      );

      final engine = FinancialEngine();
      expect(engine.isUnicorn(unicornState), isTrue);
    });
  });
}
