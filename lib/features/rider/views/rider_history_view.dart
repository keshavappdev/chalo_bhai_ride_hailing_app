import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/app_state_view.dart';
import '../../../core/widgets/ride_status_badge.dart';
import '../controllers/rider_controller.dart';
import 'rider_navigation.dart';

class RiderHistoryView extends GetView<RiderController> {
  const RiderHistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Your trips')),
      bottomNavigationBar: const RiderNavigation(selectedIndex: 1),
      body: Obx(() {
        if (controller.rideHistory.isEmpty) {
          return const AppStateView(
            icon: Icons.route_outlined,
            title: 'No trips yet',
            message: 'Your completed and cancelled rides will appear here.',
          );
        }
        return ListView.separated(
          padding: const EdgeInsets.fromLTRB(20, 4, 20, 28),
          itemCount: controller.rideHistory.length,
          separatorBuilder: (_, _) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final ride = controller.rideHistory[index];
            return Card(
              child: Padding(
                padding: const EdgeInsets.all(17),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          DateFormat('dd MMM, h:mm a').format(ride.requestedAt),
                          style: const TextStyle(
                            color: AppColors.muted,
                            fontSize: 12,
                          ),
                        ),
                        const Spacer(),
                        RideStatusBadge(status: ride.status),
                      ],
                    ),
                    const SizedBox(height: 16),
                    _TripAddress(
                      color: AppColors.primary,
                      text: ride.pickup.address,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 5),
                      child: SizedBox(
                        height: 15,
                        child: VerticalDivider(thickness: 1.5),
                      ),
                    ),
                    _TripAddress(color: AppColors.danger, text: ride.drop.address),
                    const Divider(height: 28),
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

class _TripAddress extends StatelessWidget {
  const _TripAddress({required this.color, required this.text});

  final Color color;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(radius: 5, backgroundColor: color),
        const SizedBox(width: 10),
        Expanded(
          child: Text(text, maxLines: 1, overflow: TextOverflow.ellipsis),
        ),
      ],
    );
  }
}
