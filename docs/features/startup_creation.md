# Startup Creation & Onboarding Feature

## Purpose
The Startup Creation feature introduces the player to the Venture simulation world. The player chooses their founder identity, startup industry, and company name/tagline. An AI generator assistant helps brainstorm catchy company names and taglines with structured schema validation and offline fallbacks.

---

## Screen Flow & Player Experience
1. **Founder Profile Setup**: Enter founder name and pick target industry (AI & Software, Fintech, CleanTech, Biotech).
2. **AI Co-Pilot / Auto-Generator**: Tapping the AI button generates structured company names, taglines, and co-founder profiles.
3. **Initialization**: Creates the initial immutable `GameState` with $250,000 starting cash and 2 core team members.

---

## Primary Classes
- `StartupCreationScreen` (`lib/features/company/presentation/screens/startup_creation_screen.dart`)
- `StartupGenerator` (`lib/features/company/domain/services/startup_generator.dart`)
- `GameState` (`lib/features/game/domain/entities/game_state.dart`)

---

## Testing Strategy
- Unit tests in `test/unit/startup_generator_test.dart` for AI response parsing and fallback templates.
- Widget test verifying form inputs and chip selection in `test/widget/startup_creation_test.dart`.
