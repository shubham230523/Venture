import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../shared/widgets/glass_card.dart';
import '../../../../shared/widgets/responsive_layout.dart';
import '../../../finance/domain/services/financial_engine.dart';
import '../../../game/domain/entities/game_state.dart';
import '../widgets/financial_chart_card.dart';
import '../widgets/metric_card.dart';

class DashboardScreen extends StatefulWidget {
  final GameState initialState;
  final VoidCallback? onOpenExecutiveChat;

  const DashboardScreen({
    super.key,
    required this.initialState,
    this.onOpenExecutiveChat,
  });

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late GameState _state;
  final FinancialEngine _financialEngine = FinancialEngine();

  final List<double> _revenueHistory = [0, 2000, 5000, 12000, 25000];
  final List<double> _expenseHistory = [8000, 9000, 10000, 12000, 15000];

  @override
  void initState() {
    super.initState();
    _state = widget.initialState;
  }

  void _advanceTurn() {
    setState(() {
      final updatedClock = _state.clock.advanceMonth();
      final updatedCash = _state.cash + _financialEngine.calculateNetProfit(_state);
      _state = _state.copyWith(
        clock: updatedClock,
        cash: updatedCash < 0 ? 0 : updatedCash,
      );
      _revenueHistory.add(_state.monthlyRevenue);
      _expenseHistory.add(_state.monthlyExpenses);
    });
  }

  @override
  Widget build(BuildContext context) {
    final double runway = _financialEngine.calculateRunwayMonths(_state);
    final double valuation = _financialEngine.calculateValuation(_state);
    final bool isLowRunway = runway < 3.0 && runway != double.infinity;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(_state.companyName, style: AppTypography.titleMedium),
            Text('Founder: ${_state.founderName} • ${_state.industry}',
                style: AppTypography.bodySmall),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Chip(
              backgroundColor: AppColors.primaryGlow,
              side: const BorderSide(color: AppColors.primary),
              label: Text(
                _state.clock.formattedDate,
                style: AppTypography.bodySmall
                    .copyWith(color: AppColors.primary, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ResponsiveLayout(
            mobile: _buildMobileLayout(runway, valuation, isLowRunway),
            desktop: _buildDesktopLayout(runway, valuation, isLowRunway),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        color: AppColors.surface,
        padding: const EdgeInsets.all(16.0),
        child: SizedBox(
          height: 52,
          child: ElevatedButton.icon(
            onPressed: _advanceTurn,
            icon: const Icon(Icons.fast_forward, color: Colors.black),
            label: Text('ADVANCE MONTH',
                style: AppTypography.titleMedium.copyWith(color: Colors.black)),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMobileLayout(
      double runway, double valuation, bool isLowRunway) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildMetricGauges(runway, valuation, isLowRunway),
          const SizedBox(height: 16),
          FinancialChartCard(
            revenueHistory: _revenueHistory,
            expenseHistory: _expenseHistory,
          ),
          const SizedBox(height: 16),
          _buildExecutiveQuickBar(),
        ],
      ),
    );
  }

  Widget _buildDesktopLayout(
      double runway, double valuation, bool isLowRunway) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: SingleChildScrollView(
            child: Column(
              children: [
                _buildMetricGauges(runway, valuation, isLowRunway),
                const SizedBox(height: 16),
                FinancialChartCard(
                  revenueHistory: _revenueHistory,
                  expenseHistory: _expenseHistory,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          flex: 1,
          child: _buildExecutiveQuickBar(),
        ),
      ],
    );
  }

  Widget _buildMetricGauges(
      double runway, double valuation, bool isLowRunway) {
    return GridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      childAspectRatio: 1.4,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        MetricCard(
          label: 'Cash Balance',
          value: _state.cash,
          formatter: (val) => '\$${(val / 1000).toStringAsFixed(1)}k',
          icon: Icons.account_balance_wallet,
          accentColor: AppColors.primary,
        ),
        MetricCard(
          label: 'Runway',
          value: runway == double.infinity ? 99.0 : runway,
          formatter: (val) =>
              runway == double.infinity ? 'Profitable' : '${val.toStringAsFixed(1)} mos',
          icon: Icons.hourglass_bottom,
          accentColor: isLowRunway ? AppColors.danger : AppColors.warning,
          isWarning: isLowRunway,
        ),
        MetricCard(
          label: 'Monthly Revenue',
          value: _state.monthlyRevenue,
          formatter: (val) => '\$${(val / 1000).toStringAsFixed(1)}k',
          icon: Icons.trending_up,
          accentColor: AppColors.success,
        ),
        MetricCard(
          label: 'Valuation',
          value: valuation,
          formatter: (val) => '\$${(val / 1000000).toStringAsFixed(2)}M',
          icon: Icons.workspace_premium,
          accentColor: AppColors.secondary,
        ),
      ],
    );
  }

  Widget _buildExecutiveQuickBar() {
    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('EXECUTIVE TEAM', style: AppTypography.titleMedium),
          const SizedBox(height: 12),
          ListTile(
            leading: const CircleAvatar(
              backgroundColor: AppColors.primary,
              child: Text('CTO', style: TextStyle(color: Colors.black)),
            ),
            title: const Text('Dr. Elena Rostova'),
            subtitle: const Text('Focus: Tech Debt & Architecture'),
            trailing: IconButton(
              icon: const Icon(Icons.chat_bubble_outline),
              onPressed: widget.onOpenExecutiveChat,
            ),
          ),
          const Divider(color: AppColors.cardBorder),
          ListTile(
            leading: const CircleAvatar(
              backgroundColor: AppColors.secondary,
              child: Text('CFO', style: TextStyle(color: Colors.white)),
            ),
            title: const Text('Sarah Chen'),
            subtitle: const Text('Focus: Runway & Capital Efficiency'),
            trailing: IconButton(
              icon: const Icon(Icons.chat_bubble_outline),
              onPressed: widget.onOpenExecutiveChat,
            ),
          ),
        ],
      ),
    );
  }
}
