import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:venture/features/game/domain/entities/game_state.dart';
import 'package:venture/features/game/presentation/screens/game_over_screen.dart';

void main() {
  testWidgets('GameOverScreen renders founder critique and triggers restart', (tester) async {
    bool restarted = false;
    const finalState = GameState(
      cash: 1000000.0,
      monthlyRevenue: 100000.0,
    );

    await tester.pumpWidget(
      MaterialApp(
        home: GameOverScreen(
          finalState: finalState,
          onRestartGame: () => restarted = true,
        ),
      ),
    );

    expect(find.text('Company Victory!'), findsOneWidget);
    expect(find.text('The Capital Disciplinarian'), findsOneWidget);

    await tester.tap(find.text('START NEW VENTURE'));
    await tester.pumpAndSettle();

    expect(restarted, isTrue);
  });
}
