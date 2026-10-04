import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:venture/features/game/domain/entities/game_state.dart';
import 'package:venture/features/investors/presentation/screens/fundraising_screen.dart';

void main() {
  testWidgets('FundraisingScreen displays term sheets and accepts funding deal', (tester) async {
    const initialState = GameState(cash: 200000.0);
    GameState? updatedState;

    await tester.pumpWidget(
      MaterialApp(
        home: FundraisingScreen(
          initialState: initialState,
          onDealClosed: (s) => updatedState = s,
        ),
      ),
    );

    expect(find.text('SERIES A FUNDRAISING'), findsOneWidget);
    expect(find.text('Apex Ventures (Tier 1 VC)'), findsOneWidget);

    // Accept deal
    await tester.tap(find.text('ACCEPT TERM SHEET').first);
    await tester.pumpAndSettle();

    expect(updatedState, isNotNull);
    expect(updatedState!.cash, greaterThan(1000000.0));
  });
}
