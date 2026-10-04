import 'package:flutter_test/flutter_test.dart';
import 'package:venture/main.dart';

void main() {
  testWidgets('VentureApp loads title smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const VentureApp());
    expect(find.textContaining('VENTURE'), findsOneWidget);
  });
}
