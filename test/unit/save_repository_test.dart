import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:venture/features/game/data/repositories/save_repository.dart';
import 'package:venture/features/game/domain/entities/game_state.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('SaveRepository Tests', () {
    test('saves and loads GameState across multiple save slots', () async {
      SharedPreferences.setMockInitialValues({});
      final prefs = await SharedPreferences.getInstance();
      final repo = SaveRepository(prefs: prefs);

      const state1 = GameState(companyName: 'Slot 1 Startup', cash: 100000);
      const state2 = GameState(companyName: 'Slot 2 Startup', cash: 500000);

      await repo.saveGame(slot: 1, state: state1);
      await repo.saveGame(slot: 2, state: state2);

      final loaded1 = repo.loadGame(slot: 1);
      final loaded2 = repo.loadGame(slot: 2);

      expect(loaded1, isNotNull);
      expect(loaded1!.companyName, 'Slot 1 Startup');
      expect(loaded2, isNotNull);
      expect(loaded2!.companyName, 'Slot 2 Startup');
    });

    test('returns null when save slot is empty or corrupt', () async {
      SharedPreferences.setMockInitialValues({});
      final prefs = await SharedPreferences.getInstance();
      final repo = SaveRepository(prefs: prefs);

      expect(repo.loadGame(slot: 3), isNull);
    });
  });
}
