import 'package:equatable/equatable.dart';
import 'game_clock.dart';

enum GameStage { idea, seed, growth, unicorn, bankrupt }

class GameState extends Equatable {
  final String companyName;
  final String founderName;
  final String industry;
  final double cash;
  final double monthlyRevenue;
  final double monthlyExpenses;
  final int activeCustomers;
  final double customerAcquisitionCost; // CAC
  final double churnRate; // Decimal e.g. 0.05 for 5%
  final double industryMultiple;
  final int employeeCount;
  final double averageMorale; // 0.0 to 1.0
  final GameClock clock;
  final GameStage stage;

  const GameState({
    this.companyName = 'New Venture Inc.',
    this.founderName = 'Founder',
    this.industry = 'AI & Software',
    this.cash = 100000.0,
    this.monthlyRevenue = 0.0,
    this.monthlyExpenses = 5000.0,
    this.activeCustomers = 0,
    this.customerAcquisitionCost = 50.0,
    this.churnRate = 0.03,
    this.industryMultiple = 8.0,
    this.employeeCount = 2,
    this.averageMorale = 0.85,
    this.clock = const GameClock(),
    this.stage = GameStage.idea,
  });

  GameState copyWith({
    String? companyName,
    String? founderName,
    String? industry,
    double? cash,
    double? monthlyRevenue,
    double? monthlyExpenses,
    int? activeCustomers,
    double? customerAcquisitionCost,
    double? churnRate,
    double? industryMultiple,
    int? employeeCount,
    double? averageMorale,
    GameClock? clock,
    GameStage? stage,
  }) {
    return GameState(
      companyName: companyName ?? this.companyName,
      founderName: founderName ?? this.founderName,
      industry: industry ?? this.industry,
      cash: cash ?? this.cash,
      monthlyRevenue: monthlyRevenue ?? this.monthlyRevenue,
      monthlyExpenses: monthlyExpenses ?? this.monthlyExpenses,
      activeCustomers: activeCustomers ?? this.activeCustomers,
      customerAcquisitionCost:
          customerAcquisitionCost ?? this.customerAcquisitionCost,
      churnRate: churnRate ?? this.churnRate,
      industryMultiple: industryMultiple ?? this.industryMultiple,
      employeeCount: employeeCount ?? this.employeeCount,
      averageMorale: averageMorale ?? this.averageMorale,
      clock: clock ?? this.clock,
      stage: stage ?? this.stage,
    );
  }

  Map<String, dynamic> toJson() => {
        'companyName': companyName,
        'founderName': founderName,
        'industry': industry,
        'cash': cash,
        'monthlyRevenue': monthlyRevenue,
        'monthlyExpenses': monthlyExpenses,
        'activeCustomers': activeCustomers,
        'customerAcquisitionCost': customerAcquisitionCost,
        'churnRate': churnRate,
        'industryMultiple': industryMultiple,
        'employeeCount': employeeCount,
        'averageMorale': averageMorale,
        'clock': clock.toJson(),
        'stage': stage.name,
      };

  factory GameState.fromJson(Map<String, dynamic> json) {
    return GameState(
      companyName: json['companyName'] as String? ?? 'New Venture Inc.',
      founderName: json['founderName'] as String? ?? 'Founder',
      industry: json['industry'] as String? ?? 'AI & Software',
      cash: (json['cash'] as num?)?.toDouble() ?? 100000.0,
      monthlyRevenue: (json['monthlyRevenue'] as num?)?.toDouble() ?? 0.0,
      monthlyExpenses: (json['monthlyExpenses'] as num?)?.toDouble() ?? 5000.0,
      activeCustomers: json['activeCustomers'] as int? ?? 0,
      customerAcquisitionCost:
          (json['customerAcquisitionCost'] as num?)?.toDouble() ?? 50.0,
      churnRate: (json['churnRate'] as num?)?.toDouble() ?? 0.03,
      industryMultiple: (json['industryMultiple'] as num?)?.toDouble() ?? 8.0,
      employeeCount: json['employeeCount'] as int? ?? 2,
      averageMorale: (json['averageMorale'] as num?)?.toDouble() ?? 0.85,
      clock: json['clock'] != null
          ? GameClock.fromJson(json['clock'] as Map<String, dynamic>)
          : const GameClock(),
      stage: GameStage.values.firstWhere(
        (e) => e.name == json['stage'],
        orElse: () => GameStage.idea,
      ),
    );
  }

  @override
  List<Object?> get props => [
        companyName,
        founderName,
        industry,
        cash,
        monthlyRevenue,
        monthlyExpenses,
        activeCustomers,
        customerAcquisitionCost,
        churnRate,
        industryMultiple,
        employeeCount,
        averageMorale,
        clock,
        stage,
      ];
}
