import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../shared/widgets/glass_card.dart';
import '../../../game/domain/entities/game_state.dart';
import '../../domain/services/investor_engine.dart';

class FundraisingScreen extends StatefulWidget {
  final GameState initialState;
  final Function(GameState updatedState)? onDealClosed;

  const FundraisingScreen({
    super.key,
    required this.initialState,
    this.onDealClosed,
  });

  @override
  State<FundraisingScreen> createState() => _FundraisingScreenState();
}

class _FundraisingScreenState extends State<FundraisingScreen> {
  final InvestorEngine _engine = InvestorEngine();
  late GameState _state;

  final List<TermSheetProposal> _proposals = const [
    TermSheetProposal(
      investorName: 'Apex Ventures (Tier 1 VC)',
      investmentAmount: 1500000.0,
      preMoneyValuation: 6000000.0,
    ),
    TermSheetProposal(
      investorName: 'Horizon Capital',
      investmentAmount: 800000.0,
      preMoneyValuation: 4000000.0,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _state = widget.initialState;
  }

  void _acceptDeal(TermSheetProposal proposal) {
    setState(() {
      _state = _engine.acceptTermSheet(_state, proposal);
    });
    if (widget.onDealClosed != null) {
      widget.onDealClosed!(_state);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        title: const Text('SERIES A FUNDRAISING'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GlassCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('CURRENT VALUATION BASELINE', style: AppTypography.bodySmall),
                    const SizedBox(height: 4),
                    Text(
                      '\$${(_state.monthlyRevenue * 12 * _state.industryMultiple / 1000000).toStringAsFixed(1)}M',
                      style: AppTypography.monoNumber.copyWith(fontSize: 26),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Text('INVESTOR TERM SHEETS', style: AppTypography.titleMedium),
              const SizedBox(height: 12),
              Expanded(
                child: ListView.builder(
                  itemCount: _proposals.length,
                  itemBuilder: (context, index) {
                    final prop = _proposals[index];
                    final postMoney = _engine.calculatePostMoneyValuation(prop);
                    final equity = _engine.calculateInvestorEquityPercentage(prop);

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12.0),
                      child: GlassCard(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(prop.investorName, style: AppTypography.titleMedium),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Investment: \$${(prop.investmentAmount / 1000000).toStringAsFixed(1)}M',
                                  style: AppTypography.bodySmall,
                                ),
                                Text(
                                  'Post-Money: \$${(postMoney / 1000000).toStringAsFixed(1)}M',
                                  style: AppTypography.bodySmall,
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Equity Offered: ${equity.toStringAsFixed(1)}%',
                              style: AppTypography.bodySmall.copyWith(
                                color: AppColors.warning,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 12),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () => _acceptDeal(prop),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.primary,
                                  foregroundColor: Colors.black,
                                ),
                                child: const Text('ACCEPT TERM SHEET'),
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
