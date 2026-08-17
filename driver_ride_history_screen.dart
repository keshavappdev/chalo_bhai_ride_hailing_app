import 'package:flutter/material.dart';
import 'package:ride_hailing_app/core/constants/app_colors.dart';
import 'package:ride_hailing_app/data/models/ride_model.dart';
import 'package:ride_hailing_app/presentation/widgets/common/loading_widget.dart';

class DriverRideHistoryScreen extends StatefulWidget {
  const DriverRideHistoryScreen({super.key});

  @override
  State<DriverRideHistoryScreen> createState() => _DriverRideHistoryScreenState();
}

class _DriverRideHistoryScreenState extends State<DriverRideHistoryScreen> {
  List<Ride> _rides = [];
  bool _isLoading = true;
  int _selectedFilter = 0;

  final List<String> _filters = ['All', 'Completed', 'Cancelled'];

  @override
  void initState() {
    super.initState();
    _loadRideHistory();
  }

  void _loadRideHistory() {
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _rides = _generateMockRides();
        _isLoading = false;
      });
    });
  }

  List<Ride> _generateMockRides() {
    return [
      Ride(
        id: '1',
        userId: 'user1',
        driverId: 'driver1',
        pickupLocation: null!,
        dropoffLocation: null!,
        scheduledTime: DateTime.now().subtract(const Duration(hours: 2)),
        status: RideStatus.completed,
        rideType: RideType.standard,
        estimatedFare: 150,
        actualFare: 170,
        driverRating: 4.8,
        userRating: 4.5,
        createdAt: DateTime.now().subtract(const Duration(hours: 2)),
        updatedAt: DateTime.now().subtract(const Duration(hours: 2)),
      ),
      Ride(
        id: '2',
        userId: 'user2',
        driverId: 'driver1',
        pickupLocation: null!,
        dropoffLocation: null!,
        scheduledTime: DateTime.now().subtract(const Duration(hours: 4)),
        status: RideStatus.completed,
        rideType: RideType.premium,
        estimatedFare: 250,
        actualFare: 280,
        driverRating: 4.9,
        userRating: 5.0,
        createdAt: DateTime.now().subtract(const Duration(hours: 4)),
        updatedAt: DateTime.now().subtract(const Duration(hours: 4)),
      ),
      Ride(
        id: '3',
        userId: 'user3',
        driverId: 'driver1',
        pickupLocation: null!,
        dropoffLocation: null!,
        scheduledTime: DateTime.now().subtract(const Duration(days: 1)),
        status: RideStatus.cancelled,
        rideType: RideType.luxury,
        estimatedFare: 450,
        actualFare: null,
        driverRating: null,
        userRating: null,
        cancellationReason: 'Rider cancelled',
        createdAt: DateTime.now().subtract(const Duration(days: 1)),
        updatedAt: DateTime.now().subtract(const Duration(days: 1)),
      ),
      Ride(
        id: '4',
        userId: 'user4',
        driverId: 'driver1',
        pickupLocation: null!,
        dropoffLocation: null!,
        scheduledTime: DateTime.now().subtract(const Duration(days: 2)),
        status: RideStatus.completed,
        rideType: RideType.standard,
        estimatedFare: 100,
        actualFare: 120,
        driverRating: 4.5,
        userRating: 4.0,
        createdAt: DateTime.now().subtract(const Duration(days: 2)),
        updatedAt: DateTime.now().subtract(const Duration(days: 2)),
      ),
      Ride(
        id: '5',
        userId: 'user5',
        driverId: 'driver1',
        pickupLocation: null!,
        dropoffLocation: null!,
        scheduledTime: DateTime.now().subtract(const Duration(days: 3)),
        status: RideStatus.completed,
        rideType: RideType.standard,
        estimatedFare: 180,
        actualFare: 195,
        driverRating: 4.7,
        userRating: 4.8,
        createdAt: DateTime.now().subtract(const Duration(days: 3)),
        updatedAt: DateTime.now().subtract(const Duration(days: 3)),
      ),
    ];
  }

  List<Ride> _getFilteredRides() {
    if (_selectedFilter == 0) return _rides;
    if (_selectedFilter == 1) {
      return _rides.where((ride) => ride.status == RideStatus.completed).toList();
    }
    return _rides.where((ride) => ride.status == RideStatus.cancelled).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ride History'),
        elevation: 0,
      ),
      body: _isLoading
          ? const LoadingWidget()
          : Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: List.generate(
                _filters.length,
                    (index) => Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: FilterChip(
                      label: Text(_filters[index]),
                      selected: _selectedFilter == index,
                      onSelected: (selected) {
                        setState(() {
                          _selectedFilter = index;
                        });
                      },
                      selectedColor: AppColors.primary.withOpacity(0.2),
                      checkmarkColor: AppColors.primary,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: _getFilteredRides().isEmpty
                ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.history,
                    size: 64,
                    color: AppColors.textSecondary,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No rides found',
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            )
                : ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _getFilteredRides().length,
              itemBuilder: (context, index) {
                final ride = _getFilteredRides()[index];
                return _buildRideCard(ride);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRideCard(Ride ride) {
    final isCompleted = ride.status == RideStatus.completed;
    final isCancelled = ride.status == RideStatus.cancelled;
    final statusColor = isCompleted
        ? AppColors.success
        : isCancelled
        ? AppColors.error
        : AppColors.warning;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    ride.statusDisplay.toUpperCase(),
                    style: TextStyle(
                      color: statusColor,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const Spacer(),
                Text(
                  '₹${ride.actualFare?.toStringAsFixed(0) ?? ride.estimatedFare.toStringAsFixed(0)}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                const Icon(Icons.person, size: 16, color: AppColors.textSecondary),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Rider: ${ride.userId}',
                    style: const TextStyle(fontSize: 14),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                const Icon(Icons.location_on, size: 16, color: AppColors.success),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    ride.pickupLocation?.address ?? 'Pickup',
                    style: const TextStyle(fontSize: 14),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                const Icon(Icons.location_on, size: 16, color: AppColors.error),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    ride.dropoffLocation?.address ?? 'Dropoff',
                    style: const TextStyle(fontSize: 14),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                if (isCompleted) ...[
                  const Icon(Icons.star, size: 16, color: AppColors.warning),
                  const SizedBox(width: 4),
                  Text(
                    'Rated: ${ride.userRating?.toStringAsFixed(1) ?? 'N/A'}',
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ] else if (isCancelled) ...[
                  const Icon(Icons.info_outline, size: 16, color: AppColors.error),
                  const SizedBox(width: 4),
                  Text(
                    ride.cancellationReason ?? 'Cancelled',
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
                const Spacer(),
                Text(
                  '${ride.createdAt.day}/${ride.createdAt.month}/${ride.createdAt.year}',
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}