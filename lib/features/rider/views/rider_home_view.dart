import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/app_state_view.dart';
import '../../../core/widgets/app_map_card.dart';
import '../../../routes/app_routes.dart';
import '../controllers/rider_controller.dart';
import 'rider_navigation.dart';

class RiderHomeView extends GetView<RiderController> {
  const RiderHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const RiderNavigation(selectedIndex: 0),
      body: SafeArea(
        child: Obx(() {
          if (controller.isLoading.value && controller.pickup.value == null) {
            return const Center(child: CircularProgressIndicator());
          }
          if (controller.errorMessage.value.isNotEmpty &&
              controller.pickup.value == null) {
            return AppStateView(
              icon: Icons.cloud_off_rounded,
              title: 'Could not load your location',
              message: controller.errorMessage.value,
              actionLabel: 'Retry',
              onAction: controller.loadHome,
            );
          }

          return RefreshIndicator(
            onRefresh: controller.loadHome,
            child: ListView(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 28),
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Good morning,',
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: AppColors.muted,
                                ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            controller.rider.value.name.split(' ').first,
                            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
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
                const SizedBox(height: 22),
                AppMapCard(pickup: controller.pickup.value),
                const SizedBox(height: 18),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(18),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Plan your ride',
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.w700,
                              ),
                        ),
                        const SizedBox(height: 14),
                        InkWell(
                          onTap: () => Get.toNamed(
                            AppRoutes.riderLocationSearch,
                            arguments: true,
                          ),
                          borderRadius: BorderRadius.circular(14),
                          child: _LocationRow(
                            icon: Icons.my_location_rounded,
                            color: AppColors.primary,
                            title: 'Pickup',
                            value: controller.pickup.value?.address ??
                                'Select pickup location',
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 17),
                          child: SizedBox(
                            height: 18,
                            child: VerticalDivider(width: 1, thickness: 2),
                          ),
                        ),
                        InkWell(
                          onTap: () => Get.toNamed(
                            AppRoutes.riderLocationSearch,
                            arguments: false,
                          ),
                          borderRadius: BorderRadius.circular(14),
                          child: const _LocationRow(
                            icon: Icons.location_on_rounded,
                            color: AppColors.danger,
                            title: 'Destination',
                            value: 'Where are you going?',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 22),
                Row(
                  children: [
                    Text(
                      'Popular destinations',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                    const Spacer(),
                    TextButton(
                      onPressed: () => Get.toNamed(AppRoutes.riderLocationSearch),
                      child: const Text('View all'),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                ...controller.locations.take(3).map(
                  (location) => Card(
                    margin: const EdgeInsets.only(bottom: 10),
                    child: ListTile(
                      onTap: () async {
                        controller.selectLocation(location, asPickup: false);
                        await controller.prepareEstimate();
                      },
                      leading: const CircleAvatar(
                        backgroundColor: AppColors.primaryContainer,
                        child: Icon(Icons.place_outlined, color: AppColors.primary),
                      ),
                      title: Text(location.title ?? 'Destination'),
                      subtitle: Text(
                        location.address,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      trailing: const Icon(Icons.chevron_right_rounded),
                    ),
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

class _LocationRow extends StatelessWidget {
  const _LocationRow({
    required this.icon,
    required this.color,
    required this.title,
    required this.value,
  });

  final IconData icon;
  final Color color;
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          CircleAvatar(
            radius: 17,
            backgroundColor: color.withValues(alpha: 0.12),
            child: Icon(icon, color: color, size: 18),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: Theme.of(context).textTheme.labelMedium),
                const SizedBox(height: 2),
                Text(
                  value,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
          const Icon(Icons.edit_location_alt_outlined, size: 20),
        ],
      ),
    );
  }
}
