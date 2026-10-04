# Venture Architecture Specification

## Overview

Venture is architected around two strict foundational principles:

1. **Deterministic Core Engine**: All game mechanics, financial calculations, probability engines, employee state, market changes, and win/loss rules are 100% deterministic, pure Dart code with zero AI dependencies.
2. **AI Observation & Narrative Layer**: AI providers (OpenRouter, Gemini, Ollama, etc.) observe deterministic state mutations and produce dynamic narrative, dialogue, strategy recommendations, and character reactions through structured, schema-validated JSON.

---

## Architectural Pattern: Feature-First Clean Architecture

The codebase is organized by **feature** with a clear 3-layer architecture inside each feature:

```text
lib/
  core/                         # App-wide infrastructure
    animation/                  # Reusable cinematic animations
    network/                    # HTTP client, interceptors
    theme/                      # Material 3 custom theme & typography
    utils/                      # Core helpers, math extensions
  features/
    game/                       # Game clock, save/load, turn manager
      data/                     # Local storage repositories, DTOs
      domain/                   # Pure entities (GameState, GameClock), use cases
      presentation/             # BLoCs, screens, widgets
    finance/                    # Financial calculations & simulation engine
      domain/                   # Formulas, valuation, runway, burn rate engines
    company/                    # Startup creation, branding, metrics
    employees/                  # Hiring, morale, salaries, skills
    investors/                  # Funding rounds, term sheets, dilution
    market/                     # Customers, competitors, growth, churn
    ai/                         # AI provider interfaces, adapters, memory, prompts
    events/                     # Random events & AI Game Master
    audio/                      # SFX, BGM, and Voice TTS abstraction
    settings/                   # Game settings & key management
  shared/                       # Shared widgets (responsive grids, cards, buttons)
```

---

## Layer Definitions & Rules

### 1. Domain Layer (`domain/`)
- Contains **pure Dart** business logic, immutable entities, value objects, domain service formulas, and interface contracts (repositories/services).
- **Zero dependencies** on Flutter UI (`package:flutter`) or external AI SDKs/HTTP frameworks.
- **100% testable** in isolation with standard `flutter test`.

### 2. Data Layer (`data/`)
- Implements repository and service interfaces defined in the domain layer.
- Handles data sources: local database (`Hive`/`SharedPreferences`), AI API HTTP adapters, audio players.
- Converts raw JSON / DTO models into immutable domain entities.

### 3. Presentation Layer (`presentation/`)
- Handles UI widgets, screen layouts, animations, and state management using `flutter_bloc`.
- Responsive layout widgets (`ResponsiveLayout`) adapt seamlessly between single-column mobile, dual-panel tablet, and multi-pane desktop/web viewports.

---

## AI Abstraction Layer Architecture

To prevent vendor lock-in and handle network/AI failures gracefully:

```text
               +----------------------------------+
               |        Domain Layer              |
               |  (AiService / AiConversation)    |
               +----------------------------------+
                                ^
                                | Implements
               +----------------------------------+
               |        Data Layer                |
               |  (AiProviderAdapter Manager)     |
               +----------------------------------+
                   /            |             \
      +-----------------+ +-----------+ +--------------+
      | OpenRouter      | | Gemini    | | Ollama       |
      | Adapter         | | Adapter   | | Local        |
      +-----------------+ +-----------+ +--------------+
```

### Safety & Fallback Protocols
1. **Schema Validation**: Every AI response must pass JSON Schema validation via domain models.
2. **Timeout & Retries**: Exponential backoff for API calls.
3. **Local Fallback Engine**: If AI API fails or times out, pre-baked fallback dialogues and event templates are selected deterministically so the game never crashes or blocks.

---

## State Management & Dependency Injection

- **State Management**: `flutter_bloc` for event-driven, predictable state transitions.
- **Dependency Injection**: `get_it` for service locator pattern, decoupling domain contracts from data implementations.

---

## Testing Strategy

- **Domain Logic**: Target >90% code coverage for financial math, clock advancement, employee morale calculations, and game state transitions.
- **AI Adapters**: Unit test mock JSON responses, malformed JSON recovery, and network error fallbacks.
- **UI Widgets**: Widget tests for responsive layouts, animated metric cards, and dashboard interactions.
