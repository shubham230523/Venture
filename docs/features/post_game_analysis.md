# Save System & Post-Game AI Analysis

## Purpose
The Save System and Post-Game Analysis subsystem manages multi-slot game persistence and provides a deep strategic post-mortem when a game concludes in Unicorn victory or Bankruptcy failure.

---

## Key Features
1. **Multi-Slot Persistence (`SaveRepository`)**: Autosaves on month advancement across 3 save slots using `shared_preferences`.
2. **Post-Game AI Critique (`PostGameAnalysisService`)**: Evaluates founder decision archetypes ("The Capital Disciplinarian" vs "The Aggressive Growth Chaser"), risk ratings, strengths, and strategic weaknesses.

---

## Primary Classes
- `SaveRepository` (`lib/features/game/data/repositories/save_repository.dart`)
- `PostGameAnalysisService` (`lib/features/game/domain/services/post_game_analysis.dart`)

---

## Testing Strategy
Unit tests in `test/unit/save_repository_test.dart` and `test/unit/post_game_analysis_test.dart`.
