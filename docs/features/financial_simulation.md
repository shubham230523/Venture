# Financial Simulation Engine

## Purpose
The Financial Simulation Engine is the deterministic mathematical heart of Venture. It controls cash balance, burn rate, runway, revenue growth, customer churn, valuation, and game victory/bankruptcy states without relying on nondeterministic AI responses.

---

## Business Rules & Equations

### 1. Burn Rate & Runway
$$\text{Burn Rate} = \max(0, \text{Monthly Expenses} - \text{Monthly Revenue})$$
$$\text{Runway (Months)} = \begin{cases} \infty & \text{if Burn Rate } \le 0 \\ \frac{\text{Cash}}{\text{Burn Rate}} & \text{if Burn Rate } > 0 \end{cases}$$

### 2. Customer Growth & Churn
$$\text{Acquired Customers} = \lfloor \frac{\text{Marketing Budget}}{\text{CAC}} \rfloor$$
$$\text{Churned Customers} = \text{Active Customers} \times \text{Churn Rate}$$
$$\text{New Active Customers} = \max(0, \text{Active Customers} - \text{Churned} + \text{Acquired})$$

### 3. Valuation Model
- **Post-Revenue Valuation**:
  $$\text{Valuation} = \text{Monthly Revenue} \times 12 \times \text{Industry Multiple}$$
- **Pre-Revenue Baseline Valuation**:
  $$\text{Valuation} = \text{Cash Balance} + (\text{Employee Count} \times \$250,000)$$

---

## Game Ending Triggers

- **Unicorn Victory**: Valuation $\ge \$1,000,000,000$.
- **Bankruptcy Failure**: Cash Balance $\le \$0$.

---

## Primary Classes
- `FinancialEngine` (`lib/features/finance/domain/services/financial_engine.dart`)
- `CustomerEngine` (`lib/features/market/domain/services/customer_engine.dart`)
- `EmployeeEngine` (`lib/features/employees/domain/services/employee_engine.dart`)
- `GameState` (`lib/features/game/domain/entities/game_state.dart`)
- `GameClock` (`lib/features/game/domain/entities/game_clock.dart`)

---

## Testing Strategy
100% domain coverage via unit tests in `test/unit/financial_engine_test.dart`, `test/unit/game_clock_test.dart`, and `test/unit/customer_employee_engine_test.dart`.
