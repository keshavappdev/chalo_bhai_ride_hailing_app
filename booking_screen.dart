import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ride_hailing_app/core/constants/app_colors.dart';
import 'package:ride_hailing_app/core/routes/app_routes.dart';
import 'package:ride_hailing_app/presentation/widgets/common/custom_button.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  final TextEditingController _pickupController = TextEditingController();
  final TextEditingController _dropoffController = TextEditingController();
  String _selectedRideType = 'Standard';
  DateTime? _selectedDateTime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Book a Ride'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Pickup Location
            TextField(
              controller: _pickupController,
              decoration: InputDecoration(
                labelText: 'Pickup Location',
                hintText: 'Enter pickup address',
                prefixIcon: const Icon(Icons.location_on_outlined, color: AppColors.primary),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Dropoff Location
            TextField(
              controller: _dropoffController,
              decoration: InputDecoration(
                labelText: 'Dropoff Location',
                hintText: 'Enter destination address',
                prefixIcon: const Icon(Icons.location_on_outlined, color: AppColors.error),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 24),
            // Ride Type Selection
            const Text(
              'Select Ride Type',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              children: [
                _buildRideTypeChip('Standard', Icons.car_rental),
                _buildRideTypeChip('Premium', Icons.car_rental),
                _buildRideTypeChip('Luxury', Icons.car_rental),
                _buildRideTypeChip('Shared', Icons.people),
                _buildRideTypeChip('Pet', Icons.pets),
                _buildRideTypeChip('Wheelchair', Icons.wheelchair_pickup),
              ],
            ),
            const SizedBox(height: 24),
            // Schedule Ride
            Card(
              child: ListTile(
                leading: const Icon(Icons.schedule, color: AppColors.primary),
                title: const Text('Schedule Ride'),
                subtitle: Text(
                  _selectedDateTime == null
                      ? 'Ride now'
                      : '${_selectedDateTime!.day}/${_selectedDateTime!.month}/${_selectedDateTime!.year} at ${_selectedDateTime!.hour}:${_selectedDateTime!.minute}',
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.calendar_today),
                  onPressed: _selectDateTime,
                ),
              ),
            ),
            const SizedBox(height: 24),
            // Estimate Fare Button
            CustomButton(
              text: 'Estimate Fare',
              onPressed: () {
                context.push(AppRoutes.fareEstimation);
              },
            ),
            const SizedBox(height: 12),
            // Book Ride Button
            CustomButton(
              text: 'Book Ride',
              onPressed: () {
                context.push(AppRoutes.driverSearching);
              },
              backgroundColor: AppColors.success,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRideTypeChip(String label, IconData icon) {
    final isSelected = _selectedRideType == label;
    return FilterChip(
      selected: isSelected,
      label: Text(label),
      avatar: Icon(icon, size: 18),
      onSelected: (selected) {
        setState(() {
          _selectedRideType = label;
        });
      },
      selectedColor: AppColors.primary.withOpacity(0.2),
      checkmarkColor: AppColors.primary,
    );
  }

  Future<void> _selectDateTime() async {
    final DateTime? date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 30)),
    );
    if (date != null) {
      final TimeOfDay? time = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );
      if (time != null) {
        setState(() {
          _selectedDateTime = DateTime(
            date.year,
            date.month,
            date.day,
            time.hour,
            time.minute,
          );
        });
      }
    }
  }
}