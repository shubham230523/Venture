import 'package:equatable/equatable.dart';

enum CharacterRole { cto, cfo, cmo, cpo, investor, candidate, competitor }
enum CharacterEmotion { neutral, excited, concerned, confident, skeptical }

class CharacterEntity extends Equatable {
  final String id;
  final String name;
  final CharacterRole role;
  final String personality;
  final int relationshipScore; // 0 (Hostile) to 100 (Devoted)
  final double riskTolerance; // 0.0 (Conservative) to 1.0 (Aggressive)
  final CharacterEmotion currentEmotion;

  const CharacterEntity({
    required this.id,
    required this.name,
    required this.role,
    required this.personality,
    this.relationshipScore = 50,
    this.riskTolerance = 0.5,
    this.currentEmotion = CharacterEmotion.neutral,
  });

  CharacterEntity updateRelationship(int delta) {
    int updated = (relationshipScore + delta).clamp(0, 100);
    return copyWith(relationshipScore: updated);
  }

  CharacterEntity copyWith({
    String? id,
    String? name,
    CharacterRole? role,
    String? personality,
    int? relationshipScore,
    double? riskTolerance,
    CharacterEmotion? currentEmotion,
  }) {
    return CharacterEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      role: role ?? this.role,
      personality: personality ?? this.personality,
      relationshipScore: relationshipScore ?? this.relationshipScore,
      riskTolerance: riskTolerance ?? this.riskTolerance,
      currentEmotion: currentEmotion ?? this.currentEmotion,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        role,
        personality,
        relationshipScore,
        riskTolerance,
        currentEmotion,
      ];
}
