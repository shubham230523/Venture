import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:venture/features/product/presentation/screens/product_screen.dart';

void main() {
  testWidgets('ProductScreen displays health score and triggers refactor/develop', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: ProductScreen(),
      ),
    );

    expect(find.text('PRODUCT MANAGEMENT'), findsOneWidget);
    expect(find.textContaining('Quality: 50/100'), findsOneWidget);

    // Tap Refactor
    await tester.tap(find.text('Refactor (\$10k)'));
    await tester.pumpAndSettle();

    expect(find.text('0%'), findsOneWidget); // Debt reduced from 10% to 0%
  });
}
