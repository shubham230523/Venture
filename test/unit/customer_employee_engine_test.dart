import 'package:flutter_test/flutter_test.dart';
import 'package:venture/features/employees/domain/services/employee_engine.dart';
import 'package:venture/features/game/domain/entities/game_state.dart';
import 'package:venture/features/market/domain/services/customer_engine.dart';

void main() {
  group('Customer & Employee Simulation Engine Tests', () {
    test('CustomerEngine advances month calculating new acquisition and churn', () {
      const state = GameState(
        activeCustomers: 1000,
        customerAcquisitionCost: 50.0,
        churnRate: 0.05, // 5%
        monthlyRevenue: 10000.0, // $10/customer
      );

      final engine = CustomerEngine();
      // Monthly marketing spend $5,000 -> 100 new customers @ CAC $50
      final updatedState = engine.processMonthlyCustomerGrowth(
        state: state,
        marketingSpend: 5000.0,
        averageRevenuePerUser: 10.0,
      );

      // 1000 - 5% churn (50) + 100 new = 1050 active customers
      expect(updatedState.activeCustomers, 1050);
      expect(updatedState.monthlyRevenue, 10500.0);
    });

    test('EmployeeEngine calculates team productivity based on morale and compensation', () {
      final engine = EmployeeEngine();
      expect(engine.calculateProductivityFactor(averageMorale: 1.0), 1.25);
      expect(engine.calculateProductivityFactor(averageMorale: 0.5), 0.75);
      expect(engine.calculateProductivityFactor(averageMorale: 0.0), 0.25);
    });
  });
}
