# Competitor AI Simulation Engine

## Purpose
The Competitor AI Simulation Engine manages rival startup entities in the marketplace (Nexus Corp, Hyperion Labs) that adjust strategies, engage in price wars, and compete for market share against the player.

---

## Business Rules & Equations
1. **Market Share Erosion/Gain**:
   When player Product Quality Rating exceeds 70/100, rival market share shrinks by 3% per turn as customers switch to the player's superior platform.

---

## Primary Classes
- `CompetitorEngine` & `CompetitorEntity` (`lib/features/competitors/domain/services/competitor_engine.dart`)

---

## Testing Strategy
- Unit tests in `test/unit/competitor_engine_test.dart`.
