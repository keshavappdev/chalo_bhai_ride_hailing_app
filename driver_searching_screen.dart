import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ride_hailing_app/core/constants/app_colors.dart';
import 'package:ride_hailing_app/core/routes/app_routes.dart';

class DriverSearchingScreen extends StatefulWidget {
  const DriverSearchingScreen({super.key});

  @override
  State<DriverSearchingScreen> createState() => _DriverSearchingScreenState();
}

class _DriverSearchingScreenState extends State<DriverSearchingScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _pulseAnimation;
  int _searchTime = 0;
  bool _isSearching = true;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    // Simulate driver search
    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        _isSearching = false;
      });
      // Auto navigate after finding driver
      Future.delayed(const Duration(seconds: 1), () {
        if (mounted) {
          context.push(AppRoutes.driverAssigned);
        }
      });
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Finding Driver'),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            // Cancel search
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Animated Search Icon
            AnimatedBuilder(
              animation: _pulseAnimation,
              builder: (context, child) {
                return Transform.scale(
                  scale: _pulseAnimation.value,
                  child: Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.search,
                      size: 60,
                      color: AppColors.primary,
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 32),
            Text(
              _isSearching ? 'Searching for nearby drivers...' : 'Driver Found!',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              _isSearching
                  ? 'Please wait while we find the best driver for you'
                  : 'Connecting to your driver...',
              style: TextStyle(
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 24),
            if (_isSearching) ...[
              const CircularProgressIndicator(),
              const SizedBox(height: 16),
              Text(
                'Searching... ${_searchTime}s',
                style: TextStyle(
                  color: AppColors.textSecondary,
                ),
              ),
            ] else ...[
              const Icon(
                Icons.check_circle,
                color: AppColors.success,
                size: 48,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  context.push(AppRoutes.driverAssigned);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 12,
                  ),
                ),
                child: const Text('View Driver Details'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}