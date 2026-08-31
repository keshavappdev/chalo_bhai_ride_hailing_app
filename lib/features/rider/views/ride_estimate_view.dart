import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/app_map_card.dart';
import '../../../data/models/vehicle_model.dart';
import '../controllers/rider_controller.dart';

class RideEstimateView extends GetView<RiderController> {
  const RideEstimateView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Choose your ride')),
      body: Obx(() {
        final estimate = controller.estimate.value;
        if (estimate == null) {
          return const Center(child: Text('No fare estimate available.'));
        }
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 4, 20, 0),
              child: AppMapCard(
                height: 190,
                pickup: controller.pickup.value,
                drop: controller.drop.value,
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
                children: [
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          _RouteLine(
                            color: AppColors.primary,
                            title: 'Pickup',
                            address: controller.pickup.value?.address ?? '',
                          ),
                          const Divider(height: 24),
                          _RouteLine(
                            color: AppColors.danger,
                            title: 'Destination',
                            address: controller.drop.value?.address ?? '',
                          ),
                          const Divider(height: 24),
                          Row(
                            children: [
                              const Icon(Icons.route_rounded, size: 19),
                              const SizedBox(width: 7),
                              Text('${estimate.distanceKm.toStringAsFixed(1)} km'),
                              const Spacer(),
                              const Icon(Icons.schedule_rounded, size: 19),
                              const SizedBox(width: 7),
                              Text('${estimate.durationMinutes} min'),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Available vehicles',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                  const SizedBox(height: 10),
                  ...controller.vehicles.map(
                    (vehicle) => Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: _VehicleTile(
                        vehicle: vehicle,
                        fare: estimate.fareFor(vehicle.type),
                        isSelected:
                            controller.selectedVehicle.value?.id == vehicle.id,
                        onTap: () => controller.chooseVehicle(vehicle),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      }),
      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.fromLTRB(20, 10, 20, 16),
        child: Obx(
          () => FilledButton(
            onPressed: controller.isLoading.value ? null : controller.bookRide,
            child: controller.isLoading.value
                ? const SizedBox(
                    width: 22,
                    height: 22,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.5,
                      color: Colors.white,
                    ),
                  )
                : Text(
                    'Confirm ${controller.selectedVehicle.value?.name ?? 'ride'}',
                  ),
          ),
        ),
      ),
    );
  }
}

class _RouteLine extends StatelessWidget {
  const _RouteLine({
    required this.color,
    required this.title,
    required this.address,
  });

  final Color color;
  final String title;
  final String address;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(radius: 6, backgroundColor: color),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: Theme.of(context).textTheme.labelSmall),
              Text(
                address,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _VehicleTile extends StatelessWidget {
  const _VehicleTile({
    required this.vehicle,
    required this.fare,
    required this.isSelected,
    required this.onTap,
  });

  final VehicleModel vehicle;
  final double fare;
  final bool isSelected;
  final VoidCallback onTap;

  IconData get icon => switch (vehicle.type) {
        VehicleType.bike => Icons.two_wheeler_rounded,
        VehicleType.auto => Icons.electric_rickshaw_rounded,
        _ => Icons.local_taxi_rounded,
      };

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: BorderSide(
          color: isSelected ? AppColors.primary : const Color(0xFFE5EAE6),
          width: isSelected ? 1.8 : 1,
        ),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundColor: isSelected
                    ? AppColors.primaryContainer
                    : const Color(0xFFF1F4F1),
                child: Icon(icon, color: AppColors.primary),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          vehicle.name,
                          style: const TextStyle(fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(width: 8),
                        const Icon(Icons.person_rounded, size: 15),
                        Text('${vehicle.capacity}'),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${vehicle.etaMinutes} min away',
                      style: const TextStyle(color: AppColors.muted),
                    ),
                  ],
                ),
              ),
              Text(
                '${AppConstants.currencySymbol}${fare.round()}',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
