import '../../../game/domain/entities/game_state.dart';

class MarketingCampaign {
  final String id;
  final String name;
  final double monthlyBudget;
  final double targetCac;
  final double brandAwarenessGain;

  const MarketingCampaign({
    required this.id,
    required this.name,
    required this.monthlyBudget,
    required this.targetCac,
    required this.brandAwarenessGain,
  });
}

class MarketingEngine {
  GameState runCampaign(GameState current, MarketingCampaign campaign) {
    if (campaign.targetCac <= 0) return current;

    int newCustomers = (campaign.monthlyBudget / campaign.targetCac).floor();
    int totalActive = current.activeCustomers + newCustomers;
    double newRevenue = totalActive * (current.activeCustomers > 0 ? (current.monthlyRevenue / current.activeCustomers) : 20.0);
    double newExpenses = current.monthlyExpenses + campaign.monthlyBudget;

    return current.copyWith(
      activeCustomers: totalActive,
      monthlyRevenue: newRevenue,
      monthlyExpenses: newExpenses,
      customerAcquisitionCost: campaign.targetCac,
    );
  }

  double calculateBrandMultiplier({required double brandAwarenessScore}) {
    double clamped = brandAwarenessScore.clamp(0.0, 100.0);
    return 1.0 + (clamped * 0.005); // 80 -> 1.40x
  }
}
