import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/app_state_view.dart';
import '../../../core/widgets/ride_status_badge.dart';
import '../controllers/driver_controller.dart';
import 'driver_navigation.dart';

class DriverHistoryView extends GetView<DriverController> {
  const DriverHistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Trip history')),
      bottomNavigationBar: const DriverNavigation(selectedIndex: 2),
      body: Obx(() {
        if (controller.tripHistory.isEmpty) {
          return const AppStateView(
            icon: Icons.route_outlined,
            title: 'No completed trips',
            message: 'Your completed driver trips will appear here.',
          );
        }
        return ListView.separated(
          padding: const EdgeInsets.fromLTRB(20, 4, 20, 28),
          itemCount: controller.tripHistory.length,
          separatorBuilder: (_, _) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final ride = controller.tripHistory[index];
            return Card(
              child: Padding(
                padding: const EdgeInsets.all(17),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            ride.rider.name,
                            style: const TextStyle(fontWeight: FontWeight.w700),
                          ),
                        ),
                        RideStatusBadge(status: ride.status),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      DateFormat('dd MMM yyyy, h:mm a').format(ride.requestedAt),
                      style: const TextStyle(color: AppColors.muted, fontSize: 12),
                    ),
                    const Divider(height: 26),
                    Text(
                      '${ride.pickup.address} → ${ride.drop.address}',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 14),
                    Row(
                      children: [
                        Text('${ride.distanceKm.toStringAsFixed(1)} km'),
                        const Spacer(),
                        Text(
                          '${AppConstants.currencySymbol}${ride.fare.round()}',
                          style: const TextStyle(fontWeight: FontWeight.w800),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
