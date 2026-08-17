import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ride_hailing_app/core/constants/app_colors.dart';
import 'package:ride_hailing_app/core/routes/app_routes.dart';
import 'package:ride_hailing_app/data/models/user_model.dart';
import 'package:ride_hailing_app/presentation/blocs/auth/auth_bloc.dart';
import 'package:ride_hailing_app/presentation/blocs/user/user_bloc.dart';
import 'package:ride_hailing_app/presentation/widgets/common/custom_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  late List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      const HomeContent(),
      const RideHistoryScreen(),
      const UserProfileScreen(),
    ];
    context.read<UserBloc>().add(LoadUserEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, authState) {
        if (authState is AuthAuthenticated) {
          return Scaffold(
            body: _pages[_currentIndex],
            bottomNavigationBar: NavigationBar(
              selectedIndex: _currentIndex,
              onDestinationSelected: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              destinations: const [
                NavigationDestination(
                  icon: Icon(Icons.home_outlined),
                  selectedIcon: Icon(Icons.home),
                  label: 'Home',
                ),
                NavigationDestination(
                  icon: Icon(Icons.history_outlined),
                  selectedIcon: Icon(Icons.history),
                  label: 'History',
                ),
                NavigationDestination(
                  icon: Icon(Icons.person_outline),
                  selectedIcon: Icon(Icons.person),
                  label: 'Profile',
                ),
              ],
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ride Hailing'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {
              context.push(AppRoutes.userNotifications);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Quick Actions
            const QuickActions(),
            const SizedBox(height: 24),
            // Where To Card
            const WhereToCard(),
            const SizedBox(height: 24),
            // Recent Places
            const RecentPlaces(),
            const SizedBox(height: 24),
            // Nearby Rides
            const NearbyRides(),
          ],
        ),
      ),
    );
  }
}

class QuickActions extends StatelessWidget {
  const QuickActions({super.key});

  @override
  Widget build(BuildContext context) {
    final actions = [
      {'icon': Icons.home, 'label': 'Home'},
      {'icon': Icons.work, 'label': 'Work'},
      {'icon': Icons.favorite, 'label': 'Saved'},
      {'icon': Icons.history, 'label': 'Recent'},
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: actions.map((action) {
        return Column(
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(
                action['icon'] as IconData,
                color: AppColors.primary,
                size: 28,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              action['label'] as String,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        );
      }).toList(),
    );
  }
}

class WhereToCard extends StatelessWidget {
  const WhereToCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ListTile(
              leading: const Icon(Icons.circle, color: AppColors.success, size: 12),
              title: const Text('Current Location'),
              subtitle: const Text('123 Main Street, City'),
              trailing: IconButton(
                icon: const Icon(Icons.my_location),
                onPressed: () {},
              ),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.circle, color: AppColors.error, size: 12),
              title: const Text('Where to?'),
              subtitle: const Text('Enter your destination'),
              onTap: () {
                context.push(AppRoutes.booking);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class RecentPlaces extends StatelessWidget {
  const RecentPlaces({super.key});

  @override
  Widget build(BuildContext context) {
    final places = [
      {'name': 'Home', 'address': '123 Main Street', 'icon': Icons.home},
      {'name': 'Work', 'address': '456 Office Blvd', 'icon': Icons.work},
      {'name': 'Gym', 'address': '789 Fitness Ave', 'icon': Icons.fitness_center},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Recent Places',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        ...places.map((place) {
          return ListTile(
            leading: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                place['icon'] as IconData,
                color: AppColors.primary,
                size: 20,
              ),
            ),
            title: Text(place['name'] as String),
            subtitle: Text(place['address'] as String),
            onTap: () {
              context.push(AppRoutes.booking);
            },
          );
        }).toList(),
      ],
    );
  }
}

class NearbyRides extends StatelessWidget {
  const NearbyRides({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Nearby Rides',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 120,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              _buildRideTypeCard('Standard', '₹100-₹150', Icons.car_rental),
              const SizedBox(width: 12),
              _buildRideTypeCard('Premium', '₹200-₹300', Icons.car_rental),
              const SizedBox(width: 12),
              _buildRideTypeCard('Luxury', '₹400-₹600', Icons.car_rental),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRideTypeCard(String type, String price, IconData icon) {
    return Card(
      child: Container(
        width: 150,
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 32, color: AppColors.primary),
            const SizedBox(height: 8),
            Text(
              type,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              price,
              style: const TextStyle(
                color: AppColors.textSecondary,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}