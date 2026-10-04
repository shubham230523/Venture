class CharacterMemoryStore {
  final Map<String, List<String>> _memories = {};

  void addMemory({
    required String characterId,
    required String eventDescription,
  }) {
    if (!_memories.containsKey(characterId)) {
      _memories[characterId] = [];
    }
    _memories[characterId]!.add(eventDescription);
  }

  List<String> getMemoriesForCharacter(String characterId) {
    return _memories[characterId] ?? [];
  }

  String buildMemoryPromptContext(String characterId) {
    final list = getMemoriesForCharacter(characterId);
    if (list.isEmpty) return 'No prior interactions.';
    return 'Recent Interaction History:\n- ${list.take(5).join('\n- ')}';
  }

  void clearMemories() {
    _memories.clear();
  }
}
