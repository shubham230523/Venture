import 'dart:convert';

class AiResponseValidator {
  /// Extract JSON from raw response text and validates presence of required keys.
  Map<String, dynamic>? validateAndParseJson(
    String rawText, {
    required List<String> requiredKeys,
  }) {
    try {
      final jsonString = _extractJsonSubstring(rawText);
      final jsonMap = jsonDecode(jsonString);

      if (jsonMap is! Map<String, dynamic>) {
        return null;
      }

      // Verify all required keys exist
      for (final key in requiredKeys) {
        if (!jsonMap.containsKey(key) || jsonMap[key] == null) {
          return null;
        }
      }

      return jsonMap;
    } catch (_) {
      return null;
    }
  }

  String _extractJsonSubstring(String text) {
    // 1. Remove markdown code fence ```json ... ``` if present
    String cleaned = text;
    final codeBlockRegex = RegExp(r'```(?:json)?\s*([\s\S]*?)\s*```');
    final match = codeBlockRegex.firstMatch(text);
    if (match != null && match.groupCount >= 1) {
      cleaned = match.group(1)!;
    }

    // 2. Extract substring between first '{' and last '}'
    int start = cleaned.indexOf('{');
    int end = cleaned.lastIndexOf('}');
    if (start != -1 && end != -1 && end > start) {
      return cleaned.substring(start, end + 1);
    }

    return cleaned;
  }
}
