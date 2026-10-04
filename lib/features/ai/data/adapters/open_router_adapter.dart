import 'package:dio/dio.dart';
import '../../domain/services/ai_response_validator.dart';
import '../../domain/services/ai_service.dart';

class OpenRouterAdapter implements AiService {
  final Dio dio;
  final String apiKey;
  final String model;
  final AiResponseValidator validator = AiResponseValidator();
  final LocalFallbackAiAdapter fallbackAdapter = LocalFallbackAiAdapter();

  OpenRouterAdapter({
    required this.dio,
    required this.apiKey,
    this.model = 'anthropic/claude-3.5-sonnet',
  });

  @override
  Future<String> generateText({
    required String prompt,
    String? systemPrompt,
  }) async {
    try {
      final response = await dio.post(
        'https://openrouter.ai/api/v1/chat/completions',
        options: Options(headers: {
          'Authorization': 'Bearer $apiKey',
          'Content-Type': 'application/json',
        }),
        data: {
          'model': model,
          'messages': [
            if (systemPrompt != null) {'role': 'system', 'content': systemPrompt},
            {'role': 'user', 'content': prompt},
          ],
        },
      );

      final content = response.data['choices']?[0]?['message']?['content'];
      if (content is String && content.isNotEmpty) {
        return content;
      }
      return fallbackAdapter.generateText(prompt: prompt, systemPrompt: systemPrompt);
    } catch (_) {
      return fallbackAdapter.generateText(prompt: prompt, systemPrompt: systemPrompt);
    }
  }

  @override
  Future<Map<String, dynamic>?> generateStructuredOutput({
    required String prompt,
    required List<String> requiredKeys,
    String? systemPrompt,
  }) async {
    final String rawResponse = await generateText(
      prompt: '$prompt\nRespond ONLY with valid JSON containing keys: ${requiredKeys.join(', ')}.',
      systemPrompt: systemPrompt,
    );

    final parsed = validator.validateAndParseJson(rawResponse, requiredKeys: requiredKeys);
    if (parsed != null) return parsed;

    return fallbackAdapter.generateStructuredOutput(
      prompt: prompt,
      requiredKeys: requiredKeys,
      systemPrompt: systemPrompt,
    );
  }
}
