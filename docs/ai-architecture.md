# Venture AI Provider Architecture

## Overview
Venture implements a **Provider-Independent AI Abstraction Layer**. The core game domain never depends directly on vendor SDKs or specific AI APIs. All AI interactions pass through the `AiService` interface contracts.

---

## Supported Provider Adapters
1. **OpenRouter Adapter** (`OpenRouterAdapter`): Unified API gateway to Claude, GPT-4, Llama 3, and Mistral models.
2. **Gemini Adapter** (`GeminiAdapter`): Direct Google Gemini API integration.
3. **Local Offline Fallback Adapter** (`LocalFallbackAiAdapter`): Deterministic local fallback generator for offline play or API outage recovery.

---

## Response Validation & Safety Protocol
```text
           User Prompt / Event Context
                      ↓
           Active AiService Provider
                      ↓
           Raw Response String
                      ↓
         AiResponseValidator (JSON Extraction)
                      ↓
         Validates Required JSON Schema Keys
               /                     \
      [Success: Return JSON]     [Failure/Timeout: Trigger Local Fallback]
```

---

## Primary Classes
- `AiService` (`lib/features/ai/domain/services/ai_service.dart`)
- `AiResponseValidator` (`lib/features/ai/domain/services/ai_response_validator.dart`)
- `OpenRouterAdapter` (`lib/features/ai/data/adapters/open_router_adapter.dart`)
- `GeminiAdapter` (`lib/features/ai/data/adapters/gemini_adapter.dart`)
- `LocalFallbackAiAdapter` (`lib/features/ai/domain/services/ai_service.dart`)

---

## Testing Strategy
Unit tests in `test/unit/ai_service_test.dart` cover schema validation, markdown code block stripping, missing key rejection, and local fallback execution.
