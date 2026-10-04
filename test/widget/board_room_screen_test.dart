import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:venture/features/game/presentation/screens/board_room_screen.dart';

void main() {
  testWidgets('BoardRoomScreen renders agenda and submits founder vote', (tester) async {
    String? submittedVote;

    await tester.pumpWidget(
      MaterialApp(
        home: BoardRoomScreen(
          onVoteSubmitted: (vote) => submittedVote = vote,
        ),
      ),
    );

    expect(find.text('Q3 BOARD MEETING'), findsOneWidget);
    expect(find.text('Dr. Elena Rostova (CTO)'), findsOneWidget);

    // Select CTO plan radio option
    await tester.tap(find.text('Approve CTO Tech Debt Investment (\$50k)'));
    await tester.pumpAndSettle();

    // Submit vote
    await tester.tap(find.text('SUBMIT BOARD VOTE'));
    await tester.pumpAndSettle();

    expect(submittedVote, 'cto_plan');
  });
}
