import 'package:flutter_test/flutter_test.dart';
import 'package:venture/features/ai/domain/services/ai_response_validator.dart';
import 'package:venture/features/ai/domain/services/ai_service.dart';

void main() {
  group('AI Architecture & Provider Abstraction Tests', () {
    test('LocalFallbackAiAdapter produces structured output offline', () async {
      final AiService aiService = LocalFallbackAiAdapter();
      final response = await aiService.generateText(
        prompt: 'Give advice on hiring a CTO',
        systemPrompt: 'You are an AI executive coach.',
      );

      expect(response, isNotEmpty);
      expect(response, contains('CTO'));
    });

    test('AiResponseValidator validates valid JSON structure', () {
      final validator = AiResponseValidator();
      const validJson = '{"speaker": "CTO", "message": "Refactor database", "confidence": 0.95}';

      final result = validator.validateAndParseJson(
        validJson,
        requiredKeys: ['speaker', 'message', 'confidence'],
      );

      expect(result, isNotNull);
      expect(result!['speaker'], 'CTO');
      expect(result['confidence'], 0.95);
    });

    test('AiResponseValidator recovers gracefully from malformed text with embedded JSON', () {
      final validator = AiResponseValidator();
      const noisyResponse = '''
      Here is my analysis:
      ```json
      {
        "speaker": "CFO",
        "message": "Preserve 12 months runway before hiring",
        "confidence": 0.90
      }
      ```
      Hope this helps!
      ''';

      final result = validator.validateAndParseJson(
        noisyResponse,
        requiredKeys: ['speaker', 'message'],
      );

      expect(result, isNotNull);
      expect(result!['speaker'], 'CFO');
      expect(result['message'], contains('Preserve 12 months runway'));
    });

    test('AiResponseValidator returns null when required keys are missing', () {
      final validator = AiResponseValidator();
      const missingKeyJson = '{"speaker": "CMO"}';

      final result = validator.validateAndParseJson(
        missingKeyJson,
        requiredKeys: ['speaker', 'message'],
      );

      expect(result, isNull);
    });
  });
}
