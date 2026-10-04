import 'package:dio/dio.dart';
import '../../domain/services/ai_response_validator.dart';
import '../../domain/services/ai_service.dart';

class GeminiAdapter implements AiService {
  final Dio dio;
  final String apiKey;
  final String model;
  final AiResponseValidator validator = AiResponseValidator();
  final LocalFallbackAiAdapter fallbackAdapter = LocalFallbackAiAdapter();

  GeminiAdapter({
    required this.dio,
    required this.apiKey,
    this.model = 'gemini-1.5-flash',
  });

  @override
  Future<String> generateText({
    required String prompt,
    String? systemPrompt,
  }) async {
    try {
      final response = await dio.post(
        'https://generativelanguage.googleapis.com/v1beta/models/$model:generateContent?key=$apiKey',
        data: {
          'contents': [
            if (systemPrompt != null)
              {
                'parts': [
                  {'text': 'System: $systemPrompt'}
                ]
              },
            {
              'parts': [
                {'text': prompt}
              ]
            }
          ]
        },
      );

      final candidates = response.data['candidates'];
      if (candidates is List && candidates.isNotEmpty) {
        final text = candidates[0]?['content']?['parts']?[0]?['text'];
        if (text is String && text.isNotEmpty) return text;
      }
      return await fallbackAdapter.generateText(prompt: prompt, systemPrompt: systemPrompt);
    } catch (_) {
      return await fallbackAdapter.generateText(prompt: prompt, systemPrompt: systemPrompt);
    }
  }

  @override
  Future<Map<String, dynamic>?> generateStructuredOutput({
    required String prompt,
    required List<String> requiredKeys,
    String? systemPrompt,
  }) async {
    final rawText = await generateText(
      prompt: '$prompt\nReturn JSON ONLY with keys: ${requiredKeys.join(', ')}',
      systemPrompt: systemPrompt,
    );

    final parsed = validator.validateAndParseJson(rawText, requiredKeys: requiredKeys);
    if (parsed != null) return parsed;

    return await fallbackAdapter.generateStructuredOutput(
      prompt: prompt,
      requiredKeys: requiredKeys,
      systemPrompt: systemPrompt,
    );
  }
}
