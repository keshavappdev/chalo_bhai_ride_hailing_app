import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/app_map_card.dart';
import '../controllers/rider_controller.dart';

class SearchingDriverView extends GetView<RiderController> {
  const SearchingDriverView({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: SafeArea(
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              AppMapCard(
                height: 310,
                showCar: false,
                pickup: controller.pickup.value,
                drop: controller.drop.value,
              ),
              const SizedBox(height: 18),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(22),
                  child: Column(
                    children: [
                      const SizedBox(
                        width: 42,
                        height: 42,
                        child: CircularProgressIndicator(strokeWidth: 4),
                      ),
                      const SizedBox(height: 18),
                      Text(
                        'Finding your driver',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.w800,
                            ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'We are checking nearby drivers. This demo continues automatically.',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: AppColors.muted, height: 1.45),
                      ),
                      const SizedBox(height: 18),
                      OutlinedButton(
                        onPressed: controller.cancelCurrentRide,
                        child: const Text('Cancel ride'),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
