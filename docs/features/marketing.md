# Marketing & Growth Subsystem

## Purpose
The Marketing subsystem allows players to allocate capital to growth channels (Performance Ads, PR Blitzes, Content Marketing) to drive customer acquisition and optimize Customer Acquisition Cost (CAC).

---

## Business Rules & Equations
1. **Acquired Customers**:
   $$\text{Acquired Customers} = \lfloor \frac{\text{Campaign Budget}}{\text{Target CAC}} \rfloor$$
2. **Brand Awareness Multiplier**:
   $$\text{Brand Multiplier} = 1.0 + (\text{Awareness Score} \times 0.005)$$

---

## Primary Classes
- `MarketingEngine` (`lib/features/marketing/domain/services/marketing_engine.dart`)
- `MarketingScreen` (`lib/features/marketing/presentation/screens/marketing_screen.dart`)

---

## Testing Strategy
- Unit tests in `test/unit/marketing_engine_test.dart`.
- Widget test in `test/widget/marketing_screen_test.dart`.
