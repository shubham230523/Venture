import 'package:equatable/equatable.dart';

class ProductFeature extends Equatable {
  final String id;
  final String name;
  final double developmentCost;
  final double qualityBoost;
  final double techDebtImpact;

  const ProductFeature({
    required this.id,
    required this.name,
    required this.developmentCost,
    required this.qualityBoost,
    required this.techDebtImpact,
  });

  @override
  List<Object?> get props => [id, name, developmentCost, qualityBoost, techDebtImpact];
}

class ProductState extends Equatable {
  final double qualityRating; // 0.0 to 100.0
  final double techDebt; // 0.0 to 100.0
  final List<ProductFeature> activeFeatures;

  const ProductState({
    required this.qualityRating,
    required this.techDebt,
    required this.activeFeatures,
  });

  ProductState copyWith({
    double? qualityRating,
    double? techDebt,
    List<ProductFeature>? activeFeatures,
  }) {
    return ProductState(
      qualityRating: qualityRating ?? this.qualityRating,
      techDebt: techDebt ?? this.techDebt,
      activeFeatures: activeFeatures ?? this.activeFeatures,
    );
  }

  @override
  List<Object?> get props => [qualityRating, techDebt, activeFeatures];
}

class ProductEngine {
  ProductState getInitialProductState() {
    return const ProductState(
      qualityRating: 50.0,
      techDebt: 10.0,
      activeFeatures: [
        ProductFeature(
          id: 'v1_core',
          name: 'V1 Core Platform',
          developmentCost: 0.0,
          qualityBoost: 50.0,
          techDebtImpact: 10.0,
        ),
      ],
    );
  }

  ProductState developFeature(ProductState current, ProductFeature feature) {
    double newQuality = (current.qualityRating + feature.qualityBoost).clamp(0.0, 100.0);
    double newDebt = (current.techDebt + feature.techDebtImpact).clamp(0.0, 100.0);
    List<ProductFeature> updatedFeatures = List.from(current.activeFeatures)..add(feature);

    return current.copyWith(
      qualityRating: newQuality,
      techDebt: newDebt,
      activeFeatures: updatedFeatures,
    );
  }

  ProductState refactorTechDebt(ProductState current, {required double spendAmount}) {
    // $1k spend reduces 1 point of tech debt
    double debtReduction = spendAmount / 1000.0;
    double newDebt = (current.techDebt - debtReduction).clamp(0.0, 100.0);

    return current.copyWith(techDebt: newDebt);
  }

  double calculateQualityMultiplier(ProductState state) {
    // Quality 100 -> 1.5x retention multiplier; Quality 0 -> 0.5x multiplier
    return 0.5 + (state.qualityRating / 100.0);
  }
}
