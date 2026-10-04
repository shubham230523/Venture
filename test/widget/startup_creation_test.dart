import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:venture/features/company/presentation/screens/startup_creation_screen.dart';
import 'package:venture/features/game/domain/entities/game_state.dart';

void main() {
  testWidgets('StartupCreationScreen allows input and submits new GameState', (tester) async {
    GameState? createdState;

    await tester.pumpWidget(
      MaterialApp(
        home: StartupCreationScreen(
          onStartupCreated: (state) => createdState = state,
        ),
      ),
    );

    expect(find.text('Launch Your Startup'), findsOneWidget);
    expect(find.text('START SIMULATION'), findsOneWidget);

    // Tap start simulation button
    await tester.tap(find.text('START SIMULATION'));
    await tester.pumpAndSettle();

    expect(createdState, isNotNull);
    expect(createdState!.companyName, 'Aetherium AI');
    expect(createdState!.cash, 250000.0);
  });
}
