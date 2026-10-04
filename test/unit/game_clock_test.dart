import 'package:flutter_test/flutter_test.dart';
import 'package:venture/features/game/domain/entities/game_clock.dart';

void main() {
  group('GameClock Entity Tests', () {
    test('initializes at Year 1, Month 1, Quarter 1', () {
      const clock = GameClock();
      expect(clock.year, 1);
      expect(clock.month, 1);
      expect(clock.quarter, 1);
      expect(clock.formattedDate, 'Year 1, Month 1 (Q1)');
    });

    test('advances month correctly and calculates quarter', () {
      const clock = GameClock(year: 1, month: 2);
      final nextClock = clock.advanceMonth();

      expect(nextClock.month, 3);
      expect(nextClock.quarter, 1);

      final q2Clock = nextClock.advanceMonth();
      expect(q2Clock.month, 4);
      expect(q2Clock.quarter, 2);
    });

    test('rolls over year when month exceeds 12', () {
      const clock = GameClock(year: 1, month: 12);
      final nextYearClock = clock.advanceMonth();

      expect(nextYearClock.year, 2);
      expect(nextYearClock.month, 1);
      expect(nextYearClock.quarter, 1);
    });

    test('deserializes and serializes JSON correctly', () {
      const clock = GameClock(year: 2, month: 7);
      final json = clock.toJson();
      final deserialized = GameClock.fromJson(json);

      expect(deserialized, equals(clock));
    });
  });
}
