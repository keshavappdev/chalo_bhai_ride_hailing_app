import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/app_map_card.dart';
import '../../../core/widgets/ride_status_badge.dart';
import '../../../data/models/ride_model.dart';
import '../controllers/driver_controller.dart';

class ActiveTripView extends GetView<DriverController> {
  const ActiveTripView({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(title: const Text('Active trip')),
        body: Obx(() {
          final ride = controller.activeRide.value;
          if (ride == null) return const Center(child: Text('No active trip.'));
          final completed = ride.status == RideStatus.tripCompleted;
          return ListView(
            padding: const EdgeInsets.fromLTRB(20, 4, 20, 110),
            children: [
              AppMapCard(
                height: 240,
                pickup: ride.pickup,
                drop: ride.drop,
                title: completed
                    ? 'Trip completed'
                    : ride.status == RideStatus.tripStarted
                        ? '${ride.durationMinutes} min to drop'
                        : 'Navigate to pickup',
              ),
              const SizedBox(height: 16),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(18),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const CircleAvatar(
                            radius: 25,
                            backgroundColor: AppColors.primaryContainer,
                            child: Icon(Icons.person_rounded, color: AppColors.primary),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  ride.rider.name,
                                  style: const TextStyle(fontWeight: FontWeight.w700),
                                ),
                                Text('⭐ ${ride.rider.rating} rider rating'),
                              ],
                            ),
                          ),
                          IconButton.filledTonal(
                            onPressed: () {},
                            icon: const Icon(Icons.phone_rounded),
                          ),
                        ],
                      ),
                      const Divider(height: 28),
                      Row(
                        children: [
                          RideStatusBadge(status: ride.status),
                          const Spacer(),
                          Text(
                            '${AppConstants.currencySymbol}${ride.fare.round()}',
                            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                  fontWeight: FontWeight.w800,
                                ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _TripPoint(
                        label: 'Pickup',
                        address: ride.pickup.address,
                        color: AppColors.primary,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 5),
                        child: SizedBox(
                          height: 24,
                          child: VerticalDivider(thickness: 2),
                        ),
                      ),
                      _TripPoint(
                        label: 'Destination',
                        address: ride.drop.address,
                        color: AppColors.danger,
                      ),
                    ],
                  ),
                ),
              ),
              if (completed) ...[
                const SizedBox(height: 16),
                Card(
                  color: AppColors.primaryContainer,
                  child: Padding(
                    padding: const EdgeInsets.all(18),
                    child: Column(
                      children: [
                        const Icon(
                          Icons.check_circle_rounded,
                          size: 42,
                          color: AppColors.primary,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Great work!',
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.w800,
                              ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${AppConstants.currencySymbol}${ride.fare.round()} added to today’s earnings.',
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ],
          );
        }),
        bottomNavigationBar: SafeArea(
          minimum: const EdgeInsets.fromLTRB(20, 10, 20, 16),
          child: Obx(() {
            final ride = controller.activeRide.value;
            if (ride == null) return const SizedBox.shrink();
            return FilledButton(
              onPressed: controller.isLoading.value
                  ? null
                  : ride.status == RideStatus.tripCompleted
                      ? controller.finishCompletedRide
                      : controller.advanceTrip,
              child: controller.isLoading.value
                  ? const SizedBox(
                      width: 22,
                      height: 22,
                      child: CircularProgressIndicator(
                        strokeWidth: 2.5,
                        color: Colors.white,
                      ),
                    )
                  : Text(controller.actionForStatus(ride.status)),
            );
          }),
        ),
      ),
    );
  }
}

class _TripPoint extends StatelessWidget {
  const _TripPoint({
    required this.label,
    required this.address,
    required this.color,
  });

  final String label;
  final String address;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 6),
          child: CircleAvatar(radius: 6, backgroundColor: color),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: Theme.of(context).textTheme.labelSmall),
              const SizedBox(height: 2),
              Text(address, style: const TextStyle(fontWeight: FontWeight.w600)),
            ],
          ),
        ),
      ],
    );
  }
}
