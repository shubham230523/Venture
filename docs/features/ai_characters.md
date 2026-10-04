# AI Characters & Memory Subsystem

## Purpose
The AI Characters subsystem gives Venture its narrative depth and human tension. AI executives (CTO, CFO, CMO, CPO), investors, candidates, and competitors have distinct personality traits, risk tolerances, emotional states, and relationship trust scores.

---

## Key Features
1. **Character Trait Profiles**: Personality traits (e.g. Risk Tolerance, Greed, Innovation Focus) influence AI-generated recommendations.
2. **Relationship Trust Score (0 to 100)**: Accepting executive advice increases trust; repeatedly ignoring warnings lowers loyalty and may lead to resignations.
3. **Short & Long-Term Memory Store**: Remembers key founder decisions (e.g., promises made during funding rounds or tech debt choices).
4. **Structured Dialogue Screen**: Interactive dialogue view with character avatars, confidence badges, dialogue bubbles, and action choices.

---

## Primary Classes
- `CharacterEntity` (`lib/features/ai/domain/entities/character_entity.dart`)
- `CharacterMemoryStore` (`lib/features/ai/domain/services/character_memory.dart`)
- `ConversationScreen` (`lib/features/ai/presentation/screens/conversation_screen.dart`)

---

## Testing Strategy
- Unit tests in `test/unit/character_memory_test.dart` for relationship updates and memory context prompt formatting.
- Widget test in `test/widget/conversation_screen_test.dart`.
