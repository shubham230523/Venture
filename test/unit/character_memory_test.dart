import 'package:flutter_test/flutter_test.dart';
import 'package:venture/features/ai/domain/entities/character_entity.dart';
import 'package:venture/features/ai/domain/services/character_memory.dart';

void main() {
  group('AI Character & Memory System Tests', () {
    test('CharacterEntity initializes with default traits and updates relationship', () {
      const cto = CharacterEntity(
        id: 'cto_elena',
        name: 'Dr. Elena Rostova',
        role: CharacterRole.cto,
        personality: 'Analytical & Quality-focused',
        relationshipScore: 50,
      );

      expect(cto.relationshipScore, 50);
      final updated = cto.updateRelationship(15);
      expect(updated.relationshipScore, 65);
    });

    test('CharacterMemoryStore records memories and formats context prompt', () {
      final store = CharacterMemoryStore();
      store.addMemory(
        characterId: 'cto_elena',
        eventDescription: 'Founder accepted CTO recommendation to refactor database tech debt.',
      );

      final memories = store.getMemoriesForCharacter('cto_elena');
      expect(memories, hasLength(1));
      expect(memories.first, contains('refactor database'));

      final summary = store.buildMemoryPromptContext('cto_elena');
      expect(summary, contains('refactor database'));
    });
  });
}
