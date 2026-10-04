import '../../../game/domain/entities/game_state.dart';

class TermSheetProposal {
  final String investorName;
  final double investmentAmount;
  final double preMoneyValuation;

  const TermSheetProposal({
    required this.investorName,
    required this.investmentAmount,
    required this.preMoneyValuation,
  });
}

class InvestorEngine {
  double calculatePostMoneyValuation(TermSheetProposal proposal) {
    return proposal.preMoneyValuation + proposal.investmentAmount;
  }

  double calculateInvestorEquityPercentage(TermSheetProposal proposal) {
    double postMoney = calculatePostMoneyValuation(proposal);
    if (postMoney <= 0) return 0.0;
    return (proposal.investmentAmount / postMoney) * 100.0;
  }

  GameState acceptTermSheet(GameState current, TermSheetProposal proposal) {
    double updatedCash = current.cash + proposal.investmentAmount;
    return current.copyWith(
      cash: updatedCash,
      stage: GameStage.growth,
    );
  }
}
