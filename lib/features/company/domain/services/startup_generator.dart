import 'dart:convert';
import 'dart:math';

class GeneratedStartup {
  final String companyName;
  final String tagline;
  final String industry;
  final double startingCash;
  final String coFounderName;

  const GeneratedStartup({
    required this.companyName,
    required this.tagline,
    required this.industry,
    required this.startingCash,
    required this.coFounderName,
  });
}

class StartupGenerator {
  static final List<Map<String, String>> _templates = [
    {
      'name': 'Aetherium AI',
      'tagline': 'Next-gen cognitive workflow automation',
      'coFounder': 'Dr. Elena Rostova (CTO)',
    },
    {
      'name': 'NovaCharge',
      'tagline': 'Decentralized clean energy management',
      'coFounder': 'Marcus Vance (COO)',
    },
    {
      'name': 'QuantPay',
      'tagline': 'Zero-friction cross-border settlements',
      'coFounder': 'Sarah Chen (CFO)',
    },
    {
      'name': 'BioPulse Tech',
      'tagline': 'Predictive health monitoring algorithms',
      'coFounder': 'Dr. Aris Thorne (Chief Scientist)',
    },
  ];

  GeneratedStartup generateFallbackStartup({required String industry}) {
    final random = Random();
    final template = _templates[random.nextInt(_templates.length)];

    return GeneratedStartup(
      companyName: template['name']!,
      tagline: template['tagline']!,
      industry: industry,
      startingCash: 200000.0,
      coFounderName: template['coFounder']!,
    );
  }

  GeneratedStartup parseAiResponse(String rawResponse, {required String defaultIndustry}) {
    try {
      final cleanJsonString = _extractJson(rawResponse);
      final json = jsonDecode(cleanJsonString) as Map<String, dynamic>;

      return GeneratedStartup(
        companyName: json['companyName'] as String? ?? 'Venture Labs',
        tagline: json['tagline'] as String? ?? 'Pioneering tomorrow\'s market',
        industry: json['industry'] as String? ?? defaultIndustry,
        startingCash: (json['startingCash'] as num?)?.toDouble() ?? 200000.0,
        coFounderName: json['coFounderName'] as String? ?? 'Co-Founder',
      );
    } catch (_) {
      return generateFallbackStartup(industry: defaultIndustry);
    }
  }

  String _extractJson(String input) {
    int start = input.indexOf('{');
    int end = input.lastIndexOf('}');
    if (start != -1 && end != -1 && end > start) {
      return input.substring(start, end + 1);
    }
    return input;
  }
}
