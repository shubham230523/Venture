import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:venture/features/game/domain/entities/game_state.dart';
import 'package:venture/features/marketing/presentation/screens/marketing_screen.dart';

void main() {
  testWidgets('MarketingScreen displays active customer stats and launches campaign', (tester) async {
    const initialState = GameState(
      activeCustomers: 500,
      customerAcquisitionCost: 80.0,
    );

    GameState? updatedState;

    await tester.pumpWidget(
      MaterialApp(
        home: MarketingScreen(
          initialState: initialState,
          onCampaignLaunched: (s) => updatedState = s,
        ),
      ),
    );

    expect(find.text('MARKETING & GROWTH'), findsOneWidget);
    expect(find.text('500'), findsOneWidget);

    // Launch campaign
    await tester.tap(find.text('LAUNCH CAMPAIGN').first);
    await tester.pumpAndSettle();

    expect(updatedState, isNotNull);
    expect(updatedState!.activeCustomers, greaterThan(500));
  });
}
