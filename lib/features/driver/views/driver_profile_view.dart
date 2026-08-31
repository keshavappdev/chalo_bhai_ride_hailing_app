import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/theme/app_theme.dart';
import '../controllers/driver_controller.dart';
import 'driver_navigation.dart';

class DriverProfileView extends GetView<DriverController> {
  const DriverProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Driver profile')),
      bottomNavigationBar: const DriverNavigation(selectedIndex: 3),
      body: Obx(() {
        final driver = controller.driver.value;
        return ListView(
          padding: const EdgeInsets.fromLTRB(20, 6, 20, 28),
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    const CircleAvatar(
                      radius: 36,
                      backgroundColor: AppColors.primaryContainer,
                      child: Icon(Icons.person_rounded, color: AppColors.primary, size: 38),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      driver.name,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w800,
                          ),
                    ),
                    const SizedBox(height: 4),
                    Text('⭐ ${driver.rating} • Verified driver'),
                    const SizedBox(height: 16),
                    DecoratedBox(
                      decoration: BoxDecoration(
                        color: controller.isOnline.value
                            ? AppColors.primaryContainer
                            : const Color(0xFFF0F2F0),
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
                        child: Text(
                          controller.isOnline.value ? 'Online' : 'Offline',
                          style: const TextStyle(fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 14),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Vehicle details',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                    const SizedBox(height: 14),
                    _DetailRow(label: 'Vehicle', value: driver.vehicleName),
                    _DetailRow(label: 'Number', value: driver.vehicleNumber),
                    _DetailRow(label: 'Colour', value: driver.vehicleColor),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 14),
            const _ProfileItem(
              icon: Icons.description_outlined,
              title: 'Documents',
              subtitle: 'Licence, RC and insurance',
            ),
            const _ProfileItem(
              icon: Icons.account_balance_outlined,
              title: 'Bank account',
              subtitle: 'Payout information',
            ),
            const _ProfileItem(
              icon: Icons.help_outline_rounded,
              title: 'Driver support',
              subtitle: 'FAQs and issue reporting',
            ),
            const _ProfileItem(
              icon: Icons.settings_outlined,
              title: 'Settings',
              subtitle: 'Navigation and notification preferences',
            ),
            const SizedBox(height: 14),
            OutlinedButton.icon(
              onPressed: controller.logout,
              icon: const Icon(Icons.logout_rounded),
              label: const Text('Logout'),
              style: OutlinedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
                foregroundColor: AppColors.danger,
              ),
            ),
          ],
        );
      }),
    );
  }
}

class _DetailRow extends StatelessWidget {
  const _DetailRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Text(label, style: const TextStyle(color: AppColors.muted)),
          const Spacer(),
          Text(value, style: const TextStyle(fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}

class _ProfileItem extends StatelessWidget {
  const _ProfileItem({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  final IconData icon;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: const Color(0xFFF0F4F1),
          child: Icon(icon, color: AppColors.ink),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.chevron_right_rounded),
        onTap: () {},
      ),
    );
  }
}
