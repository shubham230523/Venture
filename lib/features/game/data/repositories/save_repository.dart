import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/entities/game_state.dart';

class SaveRepository {
  final SharedPreferences prefs;

  SaveRepository({required this.prefs});

  static String _slotKey(int slot) => 'venture_save_slot_$slot';

  Future<bool> saveGame({required int slot, required GameState state}) async {
    try {
      final jsonString = jsonEncode(state.toJson());
      return await prefs.setString(_slotKey(slot), jsonString);
    } catch (_) {
      return false;
    }
  }

  GameState? loadGame({required int slot}) {
    try {
      final jsonString = prefs.getString(_slotKey(slot));
      if (jsonString == null || jsonString.isEmpty) return null;
      final json = jsonDecode(jsonString) as Map<String, dynamic>;
      return GameState.fromJson(json);
    } catch (_) {
      return null;
    }
  }

  Future<bool> deleteSaveSlot({required int slot}) async {
    return await prefs.remove(_slotKey(slot));
  }
}
