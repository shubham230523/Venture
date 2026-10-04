# Audio, Voice & Visual Evolution Subsystem

## Purpose
The Audio, Voice & Visual Evolution subsystem provides atmospheric sound feedback and tracks the company's progression from a humble garage startup to a global unicorn empire.

---

## Key Components
1. **Audio Service (`AudioService`)**: Manages SFX playback, volume level adjustment, and instant mute controls. Audio is completely optional and fails silently if audio drivers are unavailable.
2. **Company Evolution Visualizer (`CompanyEvolutionWidget`)**: Renders visual stage badges (Garage Startup -> Seed Stage -> Series A Growth -> Global Scale-Up -> Unicorn Empire) and live progression bars.

---

## Primary Classes
- `AudioService` (`lib/features/audio/domain/services/audio_service.dart`)
- `CompanyEvolutionWidget` (`lib/features/company/presentation/widgets/company_evolution_widget.dart`)

---

## Testing Strategy
Unit tests in `test/unit/audio_evolution_test.dart` for volume controls and stage calculation equations.
