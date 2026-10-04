import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../shared/widgets/glass_card.dart';
import '../../domain/services/product_engine.dart';

class ProductScreen extends StatefulWidget {
  final Function(ProductState updatedProduct)? onProductUpdated;

  const ProductScreen({
    super.key,
    this.onProductUpdated,
  });

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  final ProductEngine _engine = ProductEngine();
  late ProductState _product;

  final List<ProductFeature> _availableFeatures = const [
    ProductFeature(
      id: 'ai_analytics',
      name: 'AI Real-Time Analytics',
      developmentCost: 25000.0,
      qualityBoost: 20.0,
      techDebtImpact: 15.0,
    ),
    ProductFeature(
      id: 'enterprise_sso',
      name: 'Enterprise Single Sign-On (SSO)',
      developmentCost: 15000.0,
      qualityBoost: 15.0,
      techDebtImpact: 5.0,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _product = _engine.getInitialProductState();
  }

  void _develop(ProductFeature feature) {
    setState(() {
      _product = _engine.developFeature(_product, feature);
    });
    if (widget.onProductUpdated != null) {
      widget.onProductUpdated!(_product);
    }
  }

  void _refactor() {
    setState(() {
      _product = _engine.refactorTechDebt(_product, spendAmount: 10000.0);
    });
    if (widget.onProductUpdated != null) {
      widget.onProductUpdated!(_product);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        title: const Text('PRODUCT MANAGEMENT'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GlassCard(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('PRODUCT HEALTH', style: AppTypography.titleMedium),
                        Text(
                          'Quality: ${_product.qualityRating.toInt()}/100',
                          style: AppTypography.monoNumberSmall.copyWith(color: AppColors.primary),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    LinearProgressIndicator(
                      value: _product.qualityRating / 100.0,
                      backgroundColor: AppColors.surfaceLight,
                      color: AppColors.primary,
                      minHeight: 8,
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Tech Debt', style: AppTypography.bodySmall),
                        Text(
                          '${_product.techDebt.toInt()}%',
                          style: AppTypography.bodySmall.copyWith(
                            color: _product.techDebt > 30 ? AppColors.danger : AppColors.success,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('ROADMAP FEATURES', style: AppTypography.titleMedium),
                  ElevatedButton.icon(
                    onPressed: _refactor,
                    icon: const Icon(Icons.build, size: 16),
                    label: const Text('Refactor (\$10k)'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.warning,
                      foregroundColor: Colors.black,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Expanded(
                child: ListView.builder(
                  itemCount: _availableFeatures.length,
                  itemBuilder: (context, index) {
                    final feat = _availableFeatures[index];
                    final isBuilt = _product.activeFeatures.contains(feat);
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12.0),
                      child: GlassCard(
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(feat.name, style: AppTypography.titleMedium),
                                  const SizedBox(height: 4),
                                  Text(
                                    'Cost: \$${(feat.developmentCost / 1000).toInt()}k • Quality +${feat.qualityBoost.toInt()}',
                                    style: AppTypography.bodySmall,
                                  ),
                                ],
                              ),
                            ),
                            ElevatedButton(
                              onPressed: isBuilt ? null : () => _develop(feat),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primary,
                                foregroundColor: Colors.black,
                              ),
                              child: Text(isBuilt ? 'LAUNCHED' : 'DEVELOP'),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
