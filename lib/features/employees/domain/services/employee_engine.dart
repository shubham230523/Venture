class EmployeeEngine {
  /// Calculates productivity multiplier based on team average morale (0.0 to 1.0).
  /// Morale 1.0 -> 1.25x productivity
  /// Morale 0.5 -> 0.75x productivity
  /// Morale 0.0 -> 0.25x productivity
  double calculateProductivityFactor({required double averageMorale}) {
    double clampedMorale = averageMorale.clamp(0.0, 1.0);
    return 0.25 + (clampedMorale * 1.0);
  }

  /// Calculates total monthly employee payroll expenses.
  double calculateMonthlyPayroll({
    required int employeeCount,
    required double averageMonthlySalary,
  }) {
    return employeeCount * averageMonthlySalary;
  }
}
