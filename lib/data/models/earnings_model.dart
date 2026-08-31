class EarningsModel {
  const EarningsModel({
    required this.today,
    required this.thisWeek,
    required this.totalTrips,
    required this.onlineHours,
    required this.dailyEarnings,
  });

  final double today;
  final double thisWeek;
  final int totalTrips;
  final double onlineHours;
  final List<double> dailyEarnings;

  // TODO: Update this model according to your existing backend API response.
  factory EarningsModel.fromJson(Map<String, dynamic> json) {
    return EarningsModel(
      today: (json['today'] as num?)?.toDouble() ?? 0,
      thisWeek: (json['this_week'] as num?)?.toDouble() ?? 0,
      totalTrips: (json['total_trips'] as num?)?.toInt() ?? 0,
      onlineHours: (json['online_hours'] as num?)?.toDouble() ?? 0,
      dailyEarnings: ((json['daily_earnings'] as List<dynamic>?) ?? [])
          .map((item) => (item as num).toDouble())
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'today': today,
        'this_week': thisWeek,
        'total_trips': totalTrips,
        'online_hours': onlineHours,
        'daily_earnings': dailyEarnings,
      };

  EarningsModel addTrip(double fare) {
    return EarningsModel(
      today: today + fare,
      thisWeek: thisWeek + fare,
      totalTrips: totalTrips + 1,
      onlineHours: onlineHours,
      dailyEarnings: dailyEarnings.isEmpty
          ? [fare]
          : [
              ...dailyEarnings.take(dailyEarnings.length - 1),
              dailyEarnings.last + fare,
            ],
    );
  }
}
