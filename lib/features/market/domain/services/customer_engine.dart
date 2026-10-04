import '../../../game/domain/entities/game_state.dart';

class CustomerEngine {
  /// Simulates monthly customer acquisition and churn.
  GameState processMonthlyCustomerGrowth({
    required GameState state,
    required double marketingSpend,
    required double averageRevenuePerUser,
  }) {
    // 1. Calculate churned customers
    int churned = (state.activeCustomers * state.churnRate).round();

    // 2. Calculate new acquired customers
    int acquired = 0;
    if (state.customerAcquisitionCost > 0) {
      acquired = (marketingSpend / state.customerAcquisitionCost).floor();
    }

    // 3. New active customer count (never negative)
    int newActiveCount = state.activeCustomers - churned + acquired;
    if (newActiveCount < 0) newActiveCount = 0;

    // 4. Calculate updated monthly revenue
    double newMonthlyRevenue = newActiveCount * averageRevenuePerUser;

    return state.copyWith(
      activeCustomers: newActiveCount,
      monthlyRevenue: newMonthlyRevenue,
    );
  }
}
