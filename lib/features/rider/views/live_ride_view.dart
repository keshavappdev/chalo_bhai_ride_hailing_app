import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/app_map_card.dart';
import '../../../core/widgets/ride_status_badge.dart';
import '../../../data/models/ride_model.dart';
import '../controllers/rider_controller.dart';

class LiveRideView extends GetView<RiderController> {
  const LiveRideView({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(title: const Text('Your ride')),
        body: Obx(() {
          final ride = controller.currentRide.value;
          if (ride == null) return const Center(child: Text('No active ride.'));
          return ListView(
            padding: const EdgeInsets.fromLTRB(20, 4, 20, 120),
            children: [
              AppMapCard(
                height: 220,
                pickup: ride.pickup,
                drop: ride.drop,
                title: ride.status == RideStatus.tripStarted
                    ? '${ride.durationMinutes} min to destination'
                    : 'Driver is 4 min away',
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
                            radius: 27,
                            backgroundColor: AppColors.primaryContainer,
                            child: Icon(Icons.person_rounded, color: AppColors.primary),
                          ),
                          const SizedBox(width: 13),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  ride.driver?.name ?? 'Driver',
                                  style: const TextStyle(fontWeight: FontWeight.w700),
                                ),
                                const SizedBox(height: 3),
                                Text(
                                  '${ride.driver?.vehicleName ?? ''} • ${ride.driver?.vehicleNumber ?? ''}',
                                  style: const TextStyle(color: AppColors.muted),
                                ),
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
                          const Icon(Icons.star_rounded, color: AppColors.accent, size: 18),
                          const SizedBox(width: 4),
                          Text('${ride.driver?.rating ?? 0}'),
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
                    children: [
                      _AddressRow(
                        color: AppColors.primary,
                        text: ride.pickup.address,
                      ),
                      const Divider(height: 24),
                      _AddressRow(
                        color: AppColors.danger,
                        text: ride.drop.address,
                      ),
                      const Divider(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('${ride.distanceKm.toStringAsFixed(1)} km'),
                          Text(
                            '${AppConstants.currencySymbol}${ride.fare.round()}',
                            style: const TextStyle(fontWeight: FontWeight.w800),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Demo lifecycle',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
              ),
              const SizedBox(height: 10),
              _RideTimeline(currentStatus: ride.status),
            ],
          );
        }),
        bottomNavigationBar: SafeArea(
          minimum: const EdgeInsets.fromLTRB(20, 10, 20, 16),
          child: Obx(() {
            final ride = controller.currentRide.value;
            if (ride == null) return const SizedBox.shrink();
            if (ride.status == RideStatus.tripCompleted) {
              return FilledButton(
                onPressed: () => _showRating(context),
                child: const Text('Rate your driver'),
              );
            }
            return FilledButton(
              onPressed: controller.advanceRide,
              child: Text(controller.actionForStatus(ride.status)),
            );
          }),
        ),
      ),
    );
  }

  void _showRating(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (context) => Padding(
        padding: const EdgeInsets.fromLTRB(24, 8, 24, 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'How was your ride?',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
            ),
            const SizedBox(height: 8),
            const Text('Tap a star to rate your driver.'),
            const SizedBox(height: 18),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                5,
                (index) => IconButton(
                  onPressed: () => controller.rateCurrentRide(index + 1),
                  icon: const Icon(
                    Icons.star_rounded,
                    color: AppColors.accent,
                    size: 34,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AddressRow extends StatelessWidget {
  const _AddressRow({required this.color, required this.text});

  final Color color;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(radius: 6, backgroundColor: color),
        const SizedBox(width: 12),
        Expanded(child: Text(text, maxLines: 1, overflow: TextOverflow.ellipsis)),
      ],
    );
  }
}

class _RideTimeline extends StatelessWidget {
  const _RideTimeline({required this.currentStatus});

  final RideStatus currentStatus;

  static const statuses = [
    RideStatus.driverAssigned,
    RideStatus.driverArriving,
    RideStatus.driverArrived,
    RideStatus.tripStarted,
    RideStatus.tripCompleted,
  ];

  @override
  Widget build(BuildContext context) {
    final currentIndex = statuses.indexOf(currentStatus);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          children: List.generate(statuses.length, (index) {
            final done = index <= currentIndex;
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Icon(
                      done ? Icons.check_circle_rounded : Icons.circle_outlined,
                      color: done ? AppColors.primary : AppColors.muted,
                      size: 20,
                    ),
                    if (index < statuses.length - 1)
                      Container(
                        width: 2,
                        height: 24,
                        color: done ? AppColors.primary : const Color(0xFFDDE3DE),
                      ),
                  ],
                ),
                const SizedBox(width: 12),
                Padding(
                  padding: const EdgeInsets.only(top: 1),
                  child: Text(
                    statuses[index].label,
                    style: TextStyle(
                      fontWeight: done ? FontWeight.w700 : FontWeight.w400,
                      color: done ? AppColors.ink : AppColors.muted,
                    ),
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
