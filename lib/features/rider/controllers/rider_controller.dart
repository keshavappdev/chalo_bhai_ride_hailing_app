import 'package:get/get.dart';

import '../../../core/services/location_service.dart';
import '../../../core/services/notification_service.dart';
import '../../../data/mock/mock_data.dart';
import '../../../data/models/location_model.dart';
import '../../../data/models/ride_estimate_model.dart';
import '../../../data/models/ride_model.dart';
import '../../../data/models/user_model.dart';
import '../../../data/models/vehicle_model.dart';
import '../../../data/repositories/ride_repository.dart';
import '../../../routes/app_routes.dart';
import '../../role_selection/role_controller.dart';

class RiderController extends GetxController {
  RiderController(
    this._rideRepository,
    this._locationService,
    this._notificationService,
    this._roleController,
  );

  final RideRepository _rideRepository;
  final LocationService _locationService;
  final NotificationService _notificationService;
  final RoleController _roleController;

  final rider = const UserModel(
    id: 'rider_101',
    name: 'Keshav Upadhyay',
    email: 'rider@chalobhai.demo',
    phone: '+91 98765 43210',
    rating: 4.9,
  ).obs;
  final pickup = Rxn<LocationModel>();
  final drop = Rxn<LocationModel>();
  final selectedVehicle = Rxn<VehicleModel>();
  final estimate = Rxn<RideEstimateModel>();
  final currentRide = Rxn<RideModel>();
  final rideHistory = <RideModel>[].obs;
  final locations = <LocationModel>[...MockData.locations].obs;
  final vehicles = <VehicleModel>[...MockData.vehicles].obs;
  final searchQuery = ''.obs;
  final isLoading = false.obs;
  final errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadHome();
  }

  List<LocationModel> get filteredLocations {
    final query = searchQuery.value.trim().toLowerCase();
    if (query.isEmpty) return locations;
    return locations.where((location) {
      return (location.title ?? '').toLowerCase().contains(query) ||
          location.address.toLowerCase().contains(query);
    }).toList();
  }

  Future<void> loadHome() async {
    isLoading.value = true;
    errorMessage.value = '';
    try {
      pickup.value = await _locationService.getCurrentLocation();
      rideHistory.assignAll(await _rideRepository.getRideHistory());
      selectedVehicle.value = vehicles.firstWhere(
        (vehicle) => vehicle.type == VehicleType.economy,
      );
    } on Exception catch (error) {
      errorMessage.value = error.toString().replaceFirst('Exception: ', '');
    } finally {
      isLoading.value = false;
    }
  }

  void selectLocation(LocationModel location, {required bool asPickup}) {
    if (asPickup) {
      pickup.value = location;
    } else {
      drop.value = location;
      estimate.value = null;
    }
  }

  Future<void> prepareEstimate() async {
    final pickupLocation = pickup.value;
    final dropLocation = drop.value;
    if (pickupLocation == null || dropLocation == null) {
      errorMessage.value = 'Select both pickup and destination.';
      return;
    }

    isLoading.value = true;
    errorMessage.value = '';
    try {
      estimate.value = await _rideRepository.getRideEstimate(
        pickup: pickupLocation,
        drop: dropLocation,
      );
      Get.offNamed(AppRoutes.riderRideEstimate);
    } on Exception catch (error) {
      errorMessage.value = error.toString().replaceFirst('Exception: ', '');
    } finally {
      isLoading.value = false;
    }
  }

  void chooseVehicle(VehicleModel vehicle) {
    selectedVehicle.value = vehicle;
  }

  Future<void> bookRide() async {
    final pickupLocation = pickup.value;
    final dropLocation = drop.value;
    final vehicle = selectedVehicle.value;
    final rideEstimate = estimate.value;
    if (pickupLocation == null ||
        dropLocation == null ||
        vehicle == null ||
        rideEstimate == null) {
      errorMessage.value = 'Ride information is incomplete.';
      return;
    }

    isLoading.value = true;
    try {
      currentRide.value = await _rideRepository.bookRide(
        rider: rider.value,
        pickup: pickupLocation,
        drop: dropLocation,
        vehicle: vehicle,
        estimate: rideEstimate,
      );
      Get.offNamed(AppRoutes.riderSearchingDriver);
      _assignDriverAfterDelay();
    } on Exception catch (error) {
      errorMessage.value = error.toString().replaceFirst('Exception: ', '');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> _assignDriverAfterDelay() async {
    await Future<void>.delayed(const Duration(seconds: 2));
    final ride = currentRide.value;
    if (ride == null || ride.status != RideStatus.searchingDriver) return;
    currentRide.value = ride.copyWith(
      driver: MockData.driver,
      status: RideStatus.driverAssigned,
    );
    _notificationService.showInAppMessage(
      'Driver found',
      '${MockData.driver.name} is on the way.',
    );
    Get.offNamed(AppRoutes.riderLiveRide);
  }

  Future<void> advanceRide() async {
    final ride = currentRide.value;
    if (ride == null) return;

    final nextStatus = switch (ride.status) {
      RideStatus.driverAssigned => RideStatus.driverArriving,
      RideStatus.driverArriving => RideStatus.driverArrived,
      RideStatus.driverArrived => RideStatus.tripStarted,
      RideStatus.tripStarted => RideStatus.tripCompleted,
      _ => ride.status,
    };

    currentRide.value = ride.copyWith(
      status: nextStatus,
      completedAt: nextStatus == RideStatus.tripCompleted ? DateTime.now() : null,
    );
    if (nextStatus == RideStatus.tripCompleted) {
      rideHistory.insert(0, currentRide.value!);
    }
  }

  Future<void> cancelCurrentRide() async {
    final ride = currentRide.value;
    if (ride == null) return;
    currentRide.value = await _rideRepository.cancelRide(ride);
    Get.offAllNamed(AppRoutes.riderHome);
  }

  Future<void> rateCurrentRide(double rating) async {
    final ride = currentRide.value;
    if (ride == null) return;
    currentRide.value = await _rideRepository.rateRide(ride, rating);
    _notificationService.showInAppMessage(
      'Thank you',
      'Your ${rating.toInt()}-star rating was saved.',
    );
    Get.offAllNamed(AppRoutes.riderHome);
  }

  String actionForStatus(RideStatus status) => switch (status) {
        RideStatus.driverAssigned => 'Simulate driver approaching',
        RideStatus.driverArriving => 'Simulate driver arrival',
        RideStatus.driverArrived => 'Start demo trip',
        RideStatus.tripStarted => 'Complete demo trip',
        RideStatus.tripCompleted => 'Rate your driver',
        _ => 'Continue',
      };

  Future<void> logout() => _roleController.logout();
}
