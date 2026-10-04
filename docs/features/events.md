# Market Events & AI Game Master Subsystem

## Purpose
The Market Events subsystem introduces dynamic opportunities, PR crises, tech outages, regulatory changes, and competitive threats. The AI Game Master orchestrates story framing, while the `EventEngine` deterministically bounds all choice impacts (Cash, Revenue, Morale).

---

## Business Rules
- **High Burn Rate Trigger**: When burn rate is high and runway drops under 4 months, triggers "CRISIS: Cash Burn Accelerating".
- **Choice Effects**: Player options deterministically alter cash balances, monthly revenue, or employee morale without unconstrained AI overrides.

---

## Primary Classes
- `EventEngine` (`lib/features/events/domain/services/event_engine.dart`)
- `GameEvent` & `EventChoice` (`lib/features/events/domain/services/event_engine.dart`)

---

## Testing Strategy
100% domain coverage via unit tests in `test/unit/event_engine_test.dart`.
