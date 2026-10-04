import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../shared/widgets/glass_card.dart';
import '../../../game/domain/entities/game_state.dart';
import '../../domain/services/marketing_engine.dart';

class MarketingScreen extends StatefulWidget {
  final GameState initialState;
  final Function(GameState updatedState)? onCampaignLaunched;

  const MarketingScreen({
    super.key,
    required this.initialState,
    this.onCampaignLaunched,
  });

  @override
  State<MarketingScreen> createState() => _MarketingScreenState();
}

class _MarketingScreenState extends State<MarketingScreen> {
  final MarketingEngine _engine = MarketingEngine();
  late GameState _state;

  final List<MarketingCampaign> _campaigns = const [
    MarketingCampaign(
      id: 'perf_ads',
      name: 'Performance Ad Campaign',
      monthlyBudget: 10000.0,
      targetCac: 45.0,
      brandAwarenessGain: 5.0,
    ),
    MarketingCampaign(
      id: 'viral_pr',
      name: 'Viral Tech PR & Influencer Blitz',
      monthlyBudget: 25000.0,
      targetCac: 30.0,
      brandAwarenessGain: 15.0,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _state = widget.initialState;
  }

  void _launch(MarketingCampaign campaign) {
    setState(() {
      _state = _engine.runCampaign(_state, campaign);
    });
    if (widget.onCampaignLaunched != null) {
      widget.onCampaignLaunched!(_state);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        title: const Text('MARKETING & GROWTH'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GlassCard(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('ACTIVE CUSTOMERS', style: AppTypography.bodySmall),
                        const SizedBox(height: 4),
                        Text(
                          '${_state.activeCustomers}',
                          style: AppTypography.monoNumber.copyWith(fontSize: 24),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('ESTIMATED CAC', style: AppTypography.bodySmall),
                        const SizedBox(height: 4),
                        Text(
                          '\$${_state.customerAcquisitionCost.toInt()}',
                          style: AppTypography.monoNumber.copyWith(
                            color: AppColors.success,
                            fontSize: 24,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Text('GROWTH CAMPAIGNS', style: AppTypography.titleMedium),
              const SizedBox(height: 12),
              Expanded(
                child: ListView.builder(
                  itemCount: _campaigns.length,
                  itemBuilder: (context, index) {
                    final camp = _campaigns[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12.0),
                      child: GlassCard(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(camp.name, style: AppTypography.titleMedium),
                            const SizedBox(height: 6),
                            Text(
                              'Budget: \$${(camp.monthlyBudget / 1000).toInt()}k/mo • Target CAC: \$${camp.targetCac.toInt()}',
                              style: AppTypography.bodySmall,
                            ),
                            const SizedBox(height: 12),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () => _launch(camp),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.primary,
                                  foregroundColor: Colors.black,
                                ),
                                child: const Text('LAUNCH CAMPAIGN'),
                              ),
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
