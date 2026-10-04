abstract class AiService {
  Future<String> generateText({
    required String prompt,
    String? systemPrompt,
  });

  Future<Map<String, dynamic>?> generateStructuredOutput({
    required String prompt,
    required List<String> requiredKeys,
    String? systemPrompt,
  });
}

/// Standalone local fallback implementation for when internet is unavailable or API fails.
class LocalFallbackAiAdapter implements AiService {
  @override
  Future<String> generateText({
    required String prompt,
    String? systemPrompt,
  }) async {
    if (prompt.contains('CTO')) {
      return 'As your CTO, I recommend allocating 20% of engineering bandwidth to tech debt refactoring.';
    } else if (prompt.contains('CFO')) {
      return 'As your CFO, preserving 12+ months of runway is crucial before expanding payroll.';
    }
    return 'Venture AI Assistant: Analyzing market dynamics and startup trajectory.';
  }

  @override
  Future<Map<String, dynamic>?> generateStructuredOutput({
    required String prompt,
    required List<String> requiredKeys,
    String? systemPrompt,
  }) async {
    return {
      'speaker': 'AI Co-Founder',
      'message': 'Focus on product-market fit and capital discipline.',
      'confidence': 0.95,
      'recommendedAction': 'Maintain current burn rate',
    };
  }
}
