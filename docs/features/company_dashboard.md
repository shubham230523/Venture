# Company Dashboard Feature

## Purpose
The Company Dashboard is Venture's central gameplay hub. It translates dry corporate metrics into a vibrant, high-stakes game view with glowing stat gauges, animated counting tickers, interactive revenue vs expense charts, executive team quick bars, and time progression controls.

---

## Screen Flow & Player Experience
1. **Financial Gauges**: Live counters for Cash, Runway (with automated pulsing warning when runway < 3 months), Monthly Revenue, and Valuation.
2. **Financial Performance Chart**: Dual-line graph tracking revenue gains vs monthly burn rate over time.
3. **Executive Team**: Access co-founders (CTO, CFO, CMO) for strategic AI consultations and board meetings.
4. **Advance Month Action**: Advances time by 1 month, applies deterministic revenue/expense math, updates charts, and triggers events.

---

## Responsive Layout Behavior
- **Mobile**: Single-column vertical scroll view with compact 2x2 gauge grid.
- **Desktop/Tablet**: Multi-pane workspace with split-screen chart view and persistent executive team sidebar.

---

## Primary Classes
- `DashboardScreen` (`lib/features/company/presentation/screens/dashboard_screen.dart`)
- `MetricCard` (`lib/features/company/presentation/widgets/metric_card.dart`)
- `FinancialChartCard` (`lib/features/company/presentation/widgets/financial_chart_card.dart`)

---

## Testing Strategy
Widget test in `test/widget/dashboard_screen_test.dart` verifying state updates and turn advancement.
