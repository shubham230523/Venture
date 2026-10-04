# Product Management Subsystem

## Purpose
The Product Management subsystem allows the player to balance feature release velocity with code quality and tech debt management. Product Quality Rating directly impacts customer retention and acquisition.

---

## Business Rules & Equations
1. **Quality Boost**: Developing roadmap features increases Product Quality Rating (0 to 100) and adds Tech Debt.
2. **Tech Debt Refactoring**: Investing $10,000 in engineering refactoring reduces Tech Debt by 10 points.
3. **Quality Retention Multiplier**:
   $$\text{Quality Multiplier} = 0.5 + (\frac{\text{Quality Rating}}{100})$$

---

## Primary Classes
- `ProductEngine` & `ProductState` (`lib/features/product/domain/services/product_engine.dart`)
- `ProductScreen` (`lib/features/product/presentation/screens/product_screen.dart`)

---

## Testing Strategy
- Unit tests in `test/unit/product_engine_test.dart`.
- Widget test in `test/widget/product_screen_test.dart`.
