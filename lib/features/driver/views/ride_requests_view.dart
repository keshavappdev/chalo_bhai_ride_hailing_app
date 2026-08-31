import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/app_state_view.dart';
import '../../../data/models/ride_model.dart';
import '../controllers/driver_controller.dart';

class RideRequestsView extends GetView<DriverController> {
  const RideRequestsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ride requests'),
        actions: [
          IconButton(
            onPressed: controller.loadRideRequests,
            icon: const Icon(Icons.refresh_rounded),
          ),
        ],
      ),
      body: Obx(() {
        if (!controller.isOnline.value) {
          return const AppStateView(
            icon: Icons.power_settings_new_rounded,
            title: 'You are offline',
            message: 'Return to the dashboard and go online first.',
          );
        }
        if (controller.rideRequests.isEmpty) {
          return AppStateView(
            icon: Icons.search_rounded,
            title: 'No requests right now',
            message: 'Stay online and refresh to check again.',
            actionLabel: 'Refresh',
            onAction: controller.loadRideRequests,
          );
        }
        return ListView.separated(
          padding: const EdgeInsets.fromLTRB(20, 4, 20, 28),
          itemCount: controller.rideRequests.length,
          separatorBuilder: (_, _) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            return _RequestCard(
              ride: controller.rideRequests[index],
              onAccept: () => controller.acceptRide(controller.rideRequests[index]),
              onReject: () => controller.rejectRide(controller.rideRequests[index]),
            );
          },
        );
      }),
    );
  }
}

class _RequestCard extends StatelessWidget {
  const _RequestCard({
    required this.ride,
    required this.onAccept,
    required this.onReject,
  });

  final RideModel ride;
  final VoidCallback onAccept;
  final VoidCallback onReject;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const CircleAvatar(
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
                Text(
                  '${AppConstants.currencySymbol}${ride.fare.round()}',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                ),
              ],
            ),
            const Divider(height: 28),
            _RequestLocation(
              color: AppColors.primary,
              label: 'Pickup',
              address: ride.pickup.address,
            ),
            const SizedBox(height: 14),
            _RequestLocation(
              color: AppColors.danger,
              label: 'Drop',
              address: ride.drop.address,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                const Icon(Icons.route_rounded, size: 18),
                const SizedBox(width: 6),
                Text('${ride.distanceKm.toStringAsFixed(1)} km'),
                const SizedBox(width: 18),
                const Icon(Icons.schedule_rounded, size: 18),
                const SizedBox(width: 6),
                Text('${ride.durationMinutes} min'),
              ],
            ),
            const SizedBox(height: 18),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: onReject,
                    child: const Text('Reject'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: FilledButton(
                    onPressed: onAccept,
                    child: const Text('Accept'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _RequestLocation extends StatelessWidget {
  const _RequestLocation({
    required this.color,
    required this.label,
    required this.address,
  });

  final Color color;
  final String label;
  final String address;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 5),
          child: CircleAvatar(radius: 5, backgroundColor: color),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: Theme.of(context).textTheme.labelSmall),
              Text(address, style: const TextStyle(fontWeight: FontWeight.w600)),
            ],
          ),
        ),
      ],
    );
  }
}
