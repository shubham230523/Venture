import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:venture/features/company/presentation/screens/dashboard_screen.dart';
import 'package:venture/features/game/domain/entities/game_state.dart';

void main() {
  testWidgets('DashboardScreen renders company info and advances turn', (tester) async {
    const initialState = GameState(
      companyName: 'Quantum AI',
      founderName: 'Sarah',
      cash: 500000.0,
      monthlyRevenue: 10000.0,
      monthlyExpenses: 20000.0,
    );

    await tester.pumpWidget(
      const MaterialApp(
        home: DashboardScreen(initialState: initialState),
      ),
    );

    expect(find.text('Quantum AI'), findsOneWidget);
    expect(find.text('ADVANCE MONTH'), findsOneWidget);

    // Tap advance month button
    await tester.tap(find.text('ADVANCE MONTH'));
    await tester.pumpAndSettle();

    // Verify clock date advanced to Month 2
    expect(find.textContaining('Month 2'), findsOneWidget);
  });
}
