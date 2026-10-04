import 'package:equatable/equatable.dart';

class GameClock extends Equatable {
  final int year;
  final int month;

  const GameClock({
    this.year = 1,
    this.month = 1,
  });

  int get quarter => ((month - 1) ~/ 3) + 1;

  String get formattedDate => 'Year $year, Month $month (Q$quarter)';

  GameClock advanceMonth() {
    if (month >= 12) {
      return GameClock(year: year + 1, month: 1);
    }
    return GameClock(year: year, month: month + 1);
  }

  Map<String, dynamic> toJson() => {
        'year': year,
        'month': month,
      };

  factory GameClock.fromJson(Map<String, dynamic> json) {
    return GameClock(
      year: json['year'] as int? ?? 1,
      month: json['month'] as int? ?? 1,
    );
  }

  @override
  List<Object?> get props => [year, month];
}
