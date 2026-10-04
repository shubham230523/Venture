import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:venture/features/ai/domain/entities/character_entity.dart';
import 'package:venture/features/ai/domain/services/ai_service.dart';
import 'package:venture/features/ai/presentation/screens/conversation_screen.dart';

void main() {
  testWidgets('ConversationScreen loads initial message and responds to choices', (tester) async {
    const cto = CharacterEntity(
      id: 'cto_elena',
      name: 'Dr. Elena Rostova',
      role: CharacterRole.cto,
      personality: 'Tech-focused',
    );

    final aiService = LocalFallbackAiAdapter();
    String? chosenOption;

    await tester.pumpWidget(
      MaterialApp(
        home: ConversationScreen(
          character: cto,
          aiService: aiService,
          onDecisionMade: (choice) => chosenOption = choice,
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('Dr. Elena Rostova'), findsOneWidget);
    expect(find.text('Approve Strategy'), findsOneWidget);

    await tester.tap(find.text('Approve Strategy'));
    await tester.pumpAndSettle();

    expect(chosenOption, 'Approve proposed engineering strategy');
  });
}
