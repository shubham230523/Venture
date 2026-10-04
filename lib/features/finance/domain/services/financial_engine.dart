import '../../game/domain/entities/game_state.dart';

class FinancialEngine {
  /// Calculates monthly burn rate (Expenses - Revenue).
  /// Returns 0 if company is profitable.
  double calculateBurnRate(GameState state) {
    double netLoss = state.monthlyExpenses - state.monthlyRevenue;
    return netLoss > 0 ? netLoss : 0.0;
  }

  /// Calculates net profit (Revenue - Expenses).
  double calculateNetProfit(GameState state) {
    return state.monthlyRevenue - state.monthlyExpenses;
  }

  /// Calculates remaining runway in months.
  /// Returns double.infinity if revenue >= expenses.
  /// Returns 0.0 if cash <= 0.
  double calculateRunwayMonths(GameState state) {
    if (state.cash <= 0) return 0.0;
    double burn = calculateBurnRate(state);
    if (burn <= 0) return double.infinity;
    return state.cash / burn;
  }

  /// Calculates Annual Recurring Revenue (ARR).
  double calculateARR(GameState state) {
    return state.monthlyRevenue * 12;
  }

  /// Calculates company valuation based on revenue multiples or pre-revenue team capital.
  double calculateValuation(GameState state) {
    double arr = calculateARR(state);
    if (arr > 0) {
      return arr * state.industryMultiple;
    }
    // Pre-revenue baseline valuation: Cash + (Team size * $250k)
    return state.cash + (state.employeeCount * 250000.0);
  }

  /// Checks if company has achieved Unicorn status ($1 Billion+ valuation).
  bool isUnicorn(GameState state) {
    return calculateValuation(state) >= 1000000000.0;
  }

  /// Checks if company has run out of money.
  bool isBankrupt(GameState state) {
    return state.cash <= 0;
  }
}
