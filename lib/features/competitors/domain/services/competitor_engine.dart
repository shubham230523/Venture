import 'package:equatable/equatable.dart';
import '../../../game/domain/entities/game_state.dart';

class CompetitorEntity extends Equatable {
  final String id;
  final String companyName;
  final double marketShare; // Percentage e.g. 25.0
  final String aggressiveStrategy;

  const CompetitorEntity({
    required this.id,
    required this.companyName,
    required this.marketShare,
    required this.aggressiveStrategy,
  });

  CompetitorEntity copyWith({
    String? id,
    String? companyName,
    double? marketShare,
    String? aggressiveStrategy,
  }) {
    return CompetitorEntity(
      id: id ?? this.id,
      companyName: companyName ?? this.companyName,
      marketShare: marketShare ?? this.marketShare,
      aggressiveStrategy: aggressiveStrategy ?? this.aggressiveStrategy,
    );
  }

  @override
  List<Object?> get props => [id, companyName, marketShare, aggressiveStrategy];
}

class CompetitorEngine {
  List<CompetitorEntity> getInitialCompetitors() {
    return const [
      CompetitorEntity(
        id: 'nexus_corp',
        companyName: 'Nexus Corp',
        marketShare: 35.0,
        aggressiveStrategy: 'Price Undercutting & Aggressive Sales',
      ),
      CompetitorEntity(
        id: 'hyperion_labs',
        companyName: 'Hyperion Labs',
        marketShare: 25.0,
        aggressiveStrategy: 'Feature Bloat & Heavy PR Blitz',
      ),
    ];
  }

  List<CompetitorEntity> simulateCompetitorTurn({
    required GameState playerState,
    required double playerQualityRating,
  }) {
    final initialRivals = getInitialCompetitors();
    
    // Superior player quality (>70.0) erodes rival market share
    double shiftFactor = playerQualityRating > 70.0 ? -3.0 : 2.0;

    return initialRivals.map((rival) {
      double newShare = (rival.marketShare + shiftFactor).clamp(5.0, 60.0);
      return rival.copyWith(marketShare: newShare);
    }).toList();
  }
}
