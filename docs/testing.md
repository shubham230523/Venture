# Venture Testing Architecture & Suite Summary

## Overview
Venture uses Test-Driven Development (TDD) to guarantee mathematical precision, deterministic simulation state transitions, AI response parsing safety, and responsive UI behavior.

---

## Test Suites Breakdown (38 Tests Total)

### 1. Domain & Financial Engine Tests (`test/unit/`)
- `game_clock_test.dart`: Year/Month advancement, quarter calculations, JSON serialization.
- `financial_engine_test.dart`: Burn rate, net profit, runway months, ARR, valuation multiples, Unicorn & bankruptcy boundaries.
- `customer_employee_engine_test.dart`: CAC, churn, active customer acquisition, productivity multipliers based on morale.
- `event_engine_test.dart`: Market event trigger conditions and choice effect applications.

### 2. AI Subsystem & Persistence Tests (`test/unit/`)
- `ai_service_test.dart`: Offline local fallback adapter, JSON schema validation, markdown code fence stripping.
- `character_memory_test.dart`: Character relationship updates and memory context prompt generation.
- `save_repository_test.dart`: Multi-slot save/load persistence and corruption recovery.
- `post_game_analysis_test.dart`: Founder strategy archetypes and verdict analysis.

### 3. UI & Responsive Widget Tests (`test/widget/`)
- `design_system_test.dart`: Theme configuration, `GlassCard` taps, `AnimatedNumberTicker`, `ResponsiveLayout` across mobile (400px), tablet (800px), and desktop (1400px).
- `startup_creation_test.dart`: Onboarding wizard form inputs and state creation.
- `dashboard_screen_test.dart`: Metric gauges, turn advancement, and clock date updates.
- `conversation_screen_test.dart`: Dialogue bubbles, emotion badges, and decision options.
- `board_room_screen.dart`: Agenda statement cards and tie-breaking board vote submission.

---

## Execution Instructions

Run all static analysis checks:
```bash
flutter analyze
```

Run complete test suite:
```bash
flutter test
```
