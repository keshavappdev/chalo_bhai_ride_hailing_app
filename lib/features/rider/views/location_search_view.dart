import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/theme/app_theme.dart';
import '../controllers/rider_controller.dart';

class LocationSearchView extends GetView<RiderController> {
  const LocationSearchView({super.key});

  @override
  Widget build(BuildContext context) {
    final asPickup = Get.arguments as bool? ?? false;
    return Scaffold(
      appBar: AppBar(title: Text(asPickup ? 'Choose pickup' : 'Choose destination')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 14),
            child: TextField(
              autofocus: true,
              onChanged: (value) => controller.searchQuery.value = value,
              decoration: InputDecoration(
                hintText: 'Search an address or landmark',
                prefixIcon: const Icon(Icons.search_rounded),
                suffixIcon: Obx(
                  () => controller.searchQuery.value.isEmpty
                      ? const SizedBox.shrink()
                      : IconButton(
                          onPressed: () => controller.searchQuery.value = '',
                          icon: const Icon(Icons.close_rounded),
                        ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }
              final locations = controller.filteredLocations;
              if (locations.isEmpty) {
                return const Center(child: Text('No matching locations found.'));
              }
              return ListView.separated(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
                itemCount: locations.length,
                separatorBuilder: (_, _) => const Divider(height: 1),
                itemBuilder: (context, index) {
                  final location = locations[index];
                  return ListTile(
                    contentPadding: const EdgeInsets.symmetric(vertical: 6),
                    onTap: () async {
                      controller.selectLocation(location, asPickup: asPickup);
                      if (asPickup) {
                        Get.back();
                      } else {
                        await controller.prepareEstimate();
                      }
                    },
                    leading: const CircleAvatar(
                      backgroundColor: AppColors.primaryContainer,
                      child: Icon(Icons.location_on_outlined, color: AppColors.primary),
                    ),
                    title: Text(
                      location.title ?? 'Saved place',
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    subtitle: Text(location.address),
                    trailing: const Icon(Icons.north_west_rounded, size: 19),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
