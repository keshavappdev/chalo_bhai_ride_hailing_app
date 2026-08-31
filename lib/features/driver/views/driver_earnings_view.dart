import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_theme.dart';
import '../controllers/driver_controller.dart';
import 'driver_navigation.dart';

class DriverEarningsView extends GetView<DriverController> {
  const DriverEarningsView({super.key});

  static const dayLabels = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Earnings')),
      bottomNavigationBar: const DriverNavigation(selectedIndex: 1),
      body: Obx(() {
        final earnings = controller.earnings.value;
        final maxValue = earnings.dailyEarnings.isEmpty
            ? 1.0
            : earnings.dailyEarnings.reduce((a, b) => a > b ? a : b);
        return ListView(
          padding: const EdgeInsets.fromLTRB(20, 4, 20, 28),
          children: [
            Card(
              color: AppColors.primary,
              child: Padding(
                padding: const EdgeInsets.all(22),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'This week',
                      style: TextStyle(color: Colors.white70),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      '${AppConstants.currencySymbol}${earnings.thisWeek.round()}',
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w800,
                          ),
                    ),
                    const SizedBox(height: 22),
                    SizedBox(
                      height: 120,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: List.generate(earnings.dailyEarnings.length, (index) {
                          final amount = earnings.dailyEarnings[index];
                          return Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 4),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Expanded(
                                    child: Align(
                                      alignment: Alignment.bottomCenter,
                                      child: FractionallySizedBox(
                                        heightFactor: (amount / maxValue)
                                            .clamp(0.08, 1.0)
                                            .toDouble(),
                                        widthFactor: 0.62,
                                        child: DecoratedBox(
                                          decoration: BoxDecoration(
                                            color: index ==
                                                    earnings.dailyEarnings.length - 1
                                                ? AppColors.accent
                                                : Colors.white54,
                                            borderRadius: const BorderRadius.vertical(
                                              top: Radius.circular(8),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    dayLabels[index],
                                    style: const TextStyle(
                                      color: Colors.white70,
                                      fontSize: 11,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _EarningMetric(
                    label: 'Today',
                    value:
                        '${AppConstants.currencySymbol}${earnings.today.round()}',
                    icon: Icons.today_rounded,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _EarningMetric(
                    label: 'Online',
                    value: '${earnings.onlineHours.toStringAsFixed(1)} hr',
                    icon: Icons.schedule_rounded,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            _EarningMetric(
              label: 'Total trips this week',
              value: '${earnings.totalTrips}',
              icon: Icons.route_rounded,
              horizontal: true,
            ),
            const SizedBox(height: 22),
            Text(
              'Payouts',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
            ),
            const SizedBox(height: 10),
            const Card(
              child: ListTile(
                contentPadding: EdgeInsets.all(16),
                leading: CircleAvatar(
                  backgroundColor: AppColors.primaryContainer,
                  child: Icon(Icons.account_balance_rounded, color: AppColors.primary),
                ),
                title: Text(
                  'Weekly bank transfer',
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
                subtitle: Text('Mock payout •••• 4521'),
                trailing: Icon(Icons.chevron_right_rounded),
              ),
            ),
          ],
        );
      }),
    );
  }
}

class _EarningMetric extends StatelessWidget {
  const _EarningMetric({
    required this.label,
    required this.value,
    required this.icon,
    this.horizontal = false,
  });

  final String label;
  final String value;
  final IconData icon;
  final bool horizontal;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(17),
        child: horizontal
            ? Row(
                children: [
                  Icon(icon, color: AppColors.primary),
                  const SizedBox(width: 12),
                  Expanded(child: Text(label)),
                  Text(value, style: const TextStyle(fontWeight: FontWeight.w800)),
                ],
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(icon, color: AppColors.primary),
                  const SizedBox(height: 12),
                  Text(label, style: const TextStyle(color: AppColors.muted)),
                  const SizedBox(height: 3),
                  Text(
                    value,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w800,
                        ),
                  ),
                ],
              ),
      ),
    );
  }
}
