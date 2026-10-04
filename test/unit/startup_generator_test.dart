import 'package:flutter_test/flutter_test.dart';
import 'package:venture/features/company/domain/services/startup_generator.dart';

void main() {
  group('StartupGenerator Service Tests', () {
    test('generates valid fallback startup when AI is offline or unavailable', () {
      final generator = StartupGenerator();
      final startup = generator.generateFallbackStartup(
        industry: 'Fintech & Payments',
      );

      expect(startup.companyName, isNotEmpty);
      expect(startup.tagline, isNotEmpty);
      expect(startup.industry, equals('Fintech & Payments'));
      expect(startup.startingCash, greaterThan(0));
    });

    test('parses structured JSON AI output safely', () {
      final generator = StartupGenerator();
      const rawJson = '''
      {
        "companyName": "OmniAI Labs",
        "tagline": "Autonomous enterprise intelligence",
        "industry": "AI & Software",
        "startingCash": 250000.0,
        "coFounderName": "Alex Vance (CTO)"
      }
      ''';

      final startup = generator.parseAiResponse(rawJson, defaultIndustry: 'AI & Software');
      expect(startup.companyName, 'OmniAI Labs');
      expect(startup.tagline, 'Autonomous enterprise intelligence');
      expect(startup.startingCash, 250000.0);
    });

    test('falls back gracefully when AI returns malformed JSON', () {
      final generator = StartupGenerator();
      const malformedJson = 'This is not valid json response';

      final startup = generator.parseAiResponse(malformedJson, defaultIndustry: 'HealthTech');
      expect(startup.industry, 'HealthTech');
      expect(startup.companyName, isNotEmpty);
    });
  });
}
