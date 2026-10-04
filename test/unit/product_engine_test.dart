import 'package:flutter_test/flutter_test.dart';
import 'package:venture/features/product/domain/services/product_engine.dart';

void main() {
  group('ProductEngine Unit Tests', () {
    test('initializes with baseline quality rating and zero tech debt', () {
      final engine = ProductEngine();
      final product = engine.getInitialProductState();

      expect(product.qualityRating, 50.0);
      expect(product.techDebt, 10.0);
      expect(product.activeFeatures, hasLength(greaterThanOrEqualTo(1)));
    });

    test('developing new feature increases quality rating and adds tech debt', () {
      final engine = ProductEngine();
      final initialProduct = engine.getInitialProductState();

      const feature = ProductFeature(
        id: 'ai_copilot',
        name: 'AI Co-Pilot Integration',
        developmentCost: 20000.0,
        qualityBoost: 15.0,
        techDebtImpact: 10.0,
      );

      final updatedProduct = engine.developFeature(initialProduct, feature);
      expect(updatedProduct.qualityRating, 65.0);
      expect(updatedProduct.techDebt, 20.0);
      expect(updatedProduct.activeFeatures, contains(feature));
    });

    test('refactoring reduces tech debt and restores stability', () {
      final engine = ProductEngine();
      const highDebtProduct = ProductState(
        qualityRating: 60.0,
        techDebt: 40.0,
        activeFeatures: [],
      );

      final refactored = engine.refactorTechDebt(highDebtProduct, spendAmount: 15000.0);
      expect(refactored.techDebt, 25.0);
      expect(refactored.qualityRating, 60.0);
    });

    test('calculates product quality multiplier for customer retention', () {
      final engine = ProductEngine();
      const highQualityProduct = ProductState(qualityRating: 90.0, techDebt: 5.0, activeFeatures: []);
      const lowQualityProduct = ProductState(qualityRating: 20.0, techDebt: 60.0, activeFeatures: []);

      expect(engine.calculateQualityMultiplier(highQualityProduct), 1.40);
      expect(engine.calculateQualityMultiplier(lowQualityProduct), 0.70);
    });
  });
}
