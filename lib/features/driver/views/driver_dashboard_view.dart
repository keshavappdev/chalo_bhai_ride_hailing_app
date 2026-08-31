import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/app_state_view.dart';
import '../../../core/widgets/app_map_card.dart';
import '../../../routes/app_routes.dart';
import '../controllers/driver_controller.dart';
import 'driver_navigation.dart';

class DriverDashboardView extends GetView<DriverController> {
  const DriverDashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const DriverNavigation(selectedIndex: 0),
      body: SafeArea(
        child: Obx(() {
          if (controller.errorMessage.value.isNotEmpty &&
              controller.tripHistory.isEmpty) {
            return AppStateView(
              icon: Icons.cloud_off_rounded,
              title: 'Could not load dashboard',
              message: controller.errorMessage.value,
              actionLabel: 'Retry',
              onAction: controller.loadDashboard,
            );
          }
          return RefreshIndicator(
            onRefresh: controller.loadDashboard,
            child: ListView(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 28),
              children: [
                Row(
                  children: [
                    const CircleAvatar(
                      radius: 24,
                      backgroundColor: AppColors.primaryContainer,
                      child: Icon(Icons.person_rounded, color: AppColors.primary),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Welcome back,',
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color: AppColors.muted,
                                ),
                          ),
                          Text(
                            controller.driver.value.name,
                            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                  fontWeight: FontWeight.w800,
                                ),
                          ),
                        ],
                      ),
                    ),
                    IconButton.filledTonal(
                      onPressed: () {},
                      icon: const Badge(child: Icon(Icons.notifications_none_rounded)),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Card(
                  color: controller.isOnline.value
                      ? AppColors.primary
                      : AppColors.surface,
                  child: Padding(
                    padding: const EdgeInsets.all(18),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                controller.isOnline.value
                                    ? 'You are online'
                                    : 'You are offline',
                                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                      color: controller.isOnline.value
                                          ? Colors.white
                                          : AppColors.ink,
                                      fontWeight: FontWeight.w800,
                                    ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                controller.isOnline.value
                                    ? 'Location sharing is active.'
                                    : 'Go online to receive requests.',
                                style: TextStyle(
                                  color: controller.isOnline.value
                                      ? Colors.white70
                                      : AppColors.muted,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Switch(
                          value: controller.isOnline.value,
                          onChanged: controller.isLoading.value
                              ? null
                              : controller.toggleOnline,
                          activeThumbColor: Colors.white,
                          activeTrackColor: AppColors.accent,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                const AppMapCard(height: 210),
                const SizedBox(height: 18),
                Row(
                  children: [
                    Expanded(
                      child: _MetricCard(
                        icon: Icons.payments_rounded,
                        label: 'Today',
                        value:
                            '${AppConstants.currencySymbol}${controller.earnings.value.today.round()}',
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _MetricCard(
                        icon: Icons.route_rounded,
                        label: 'Trips',
                        value: '${controller.earnings.value.totalTrips}',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 22),
                Row(
                  children: [
                    Text(
                      'Ride requests',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w800,
                          ),
                    ),
                    const Spacer(),
                    if (controller.isOnline.value)
                      TextButton(
                        onPressed: () => Get.toNamed(AppRoutes.driverRideRequests),
                        child: Text('View all (${controller.rideRequests.length})'),
                      ),
                  ],
                ),
                const SizedBox(height: 8),
                if (!controller.isOnline.value)
                  const Card(
                    child: Padding(
                      padding: EdgeInsets.all(22),
                      child: Row(
                        children: [
                          Icon(Icons.power_settings_new_rounded, color: AppColors.muted),
                          SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              'Go online to start receiving nearby ride requests.',
                              style: TextStyle(color: AppColors.muted),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                else if (controller.rideRequests.isEmpty)
                  const Card(
                    child: Padding(
                      padding: EdgeInsets.all(22),
                      child: Center(child: Text('Waiting for nearby requests…')),
                    ),
                  )
                else
                  Card(
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(16),
                      leading: const CircleAvatar(
                        backgroundColor: AppColors.primaryContainer,
                        child: Icon(Icons.person_pin_circle_rounded, color: AppColors.primary),
                      ),
                      title: Text(
                        controller.rideRequests.first.rider.name,
                        style: const TextStyle(fontWeight: FontWeight.w700),
                      ),
                      subtitle: Text(
                        '${controller.rideRequests.first.distanceKm.toStringAsFixed(1)} km • ${controller.rideRequests.first.durationMinutes} min',
                      ),
                      trailing: const Icon(Icons.chevron_right_rounded),
                      onTap: () => Get.toNamed(AppRoutes.driverRideRequests),
                    ),
                  ),
              ],
            ),
          );
        }),
      ),
    );
  }
}

class _MetricCard extends StatelessWidget {
  const _MetricCard({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: AppColors.primary),
            const SizedBox(height: 13),
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
