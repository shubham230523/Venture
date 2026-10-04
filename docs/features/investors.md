# Investors & Fundraising Subsystem

## Purpose
The Investors and Fundraising subsystem handles funding rounds (Pre-Seed, Seed, Series A), valuation negotiations, term sheet proposals, and equity dilution math.

---

## Business Rules & Equations
1. **Post-Money Valuation**:
   $$\text{Post-Money Valuation} = \text{Pre-Money Valuation} + \text{Investment Amount}$$
2. **Equity Dilution Percentage**:
   $$\text{Investor Equity \%} = (\frac{\text{Investment Amount}}{\text{Post-Money Valuation}}) \times 100$$

---

## Primary Classes
- `InvestorEngine` & `TermSheetProposal` (`lib/features/investors/domain/services/investor_engine.dart`)
- `FundraisingScreen` (`lib/features/investors/presentation/screens/fundraising_screen.dart`)

---

## Testing Strategy
- Unit tests in `test/unit/investor_engine_test.dart`.
- Widget test in `test/widget/fundraising_screen_test.dart`.
