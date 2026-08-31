import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/theme/app_theme.dart';
import '../controllers/rider_controller.dart';
import 'rider_navigation.dart';

class RiderProfileView extends GetView<RiderController> {
  const RiderProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Rider profile')),
      bottomNavigationBar: const RiderNavigation(selectedIndex: 2),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 6, 20, 28),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 32,
                    backgroundColor: AppColors.primaryContainer,
                    child: Icon(Icons.person_rounded, color: AppColors.primary, size: 34),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          controller.rider.value.name,
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.w800,
                              ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          controller.rider.value.phone,
                          style: const TextStyle(color: AppColors.muted),
                        ),
                      ],
                    ),
                  ),
                  const Icon(Icons.edit_outlined),
                ],
              ),
            ),
          ),
          const SizedBox(height: 18),
          const _ProfileItem(
            icon: Icons.account_balance_wallet_outlined,
            title: 'Payments',
            subtitle: 'Cash • Mock payment method',
          ),
          const _ProfileItem(
            icon: Icons.place_outlined,
            title: 'Saved places',
            subtitle: 'Home, work and favourites',
          ),
          const _ProfileItem(
            icon: Icons.shield_outlined,
            title: 'Safety & privacy',
            subtitle: 'Emergency contacts and trip sharing',
          ),
          const _ProfileItem(
            icon: Icons.help_outline_rounded,
            title: 'Help & support',
            subtitle: 'FAQs and ride support',
          ),
          const _ProfileItem(
            icon: Icons.settings_outlined,
            title: 'Settings',
            subtitle: 'Notifications and preferences',
          ),
          const SizedBox(height: 18),
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
