import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:venture/features/audio/domain/services/audio_service.dart';
import 'package:venture/features/company/presentation/widgets/company_evolution_widget.dart';
import 'package:venture/features/game/domain/entities/game_state.dart';

void main() {
  group('Audio & Visual Evolution Tests', () {
    test('AudioService handles volume setting and mute toggles', () {
      final audioService = AudioService(player: null);
      expect(audioService.isMuted, isFalse);

      audioService.toggleMute();
      expect(audioService.isMuted, isTrue);

      audioService.setVolume(0.5);
      expect(audioService.sfxVolume, 0.5);
      audioService.dispose();
    });

    testWidgets('CompanyEvolutionWidget renders startup stage badges', (tester) async {
      const state = GameState(
        monthlyRevenue: 100000.0, // $1.2M ARR * 10x = $12M Valuation
        industryMultiple: 10.0,
        employeeCount: 10,
      );

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: CompanyEvolutionWidget(state: state),
          ),
        ),
      );

      expect(find.text('COMPANY EVOLUTION'), findsOneWidget);
      expect(find.textContaining('Series A Growth'), findsOneWidget);
    });
  });
}
