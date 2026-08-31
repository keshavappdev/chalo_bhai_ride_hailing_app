import 'package:get/get.dart';

import '../../../core/services/location_service.dart';
import '../../../core/services/notification_service.dart';
import '../../../data/mock/mock_data.dart';
import '../../../data/models/driver_model.dart';
import '../../../data/models/earnings_model.dart';
import '../../../data/models/ride_model.dart';
import '../../../data/repositories/driver_repository.dart';
import '../../../data/repositories/ride_repository.dart';
import '../../../routes/app_routes.dart';
import '../../role_selection/role_controller.dart';

class DriverController extends GetxController {
  DriverController(
    this._driverRepository,
    this._rideRepository,
    this._locationService,
    this._notificationService,
    this._roleController,
  );

  final DriverRepository _driverRepository;
  final RideRepository _rideRepository;
  final LocationService _locationService;
  final NotificationService _notificationService;
  final RoleController _roleController;

  final driver = MockData.driver.obs;
  final isOnline = false.obs;
  final rideRequests = <RideModel>[].obs;
  final activeRide = Rxn<RideModel>();
  final earnings = MockData.earnings.obs;
  final tripHistory = <RideModel>[].obs;
  final isLoading = false.obs;
  final errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadDashboard();
  }

  Future<void> loadDashboard() async {
    isLoading.value = true;
    errorMessage.value = '';
    try {
      earnings.value = await _driverRepository.getEarnings();
      tripHistory.assignAll(await _driverRepository.getTripHistory());
      if (isOnline.value) await loadRideRequests();
    } on Exception catch (error) {
      errorMessage.value = error.toString().replaceFirst('Exception: ', '');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> toggleOnline(bool value) async {
    if (isLoading.value) return;
    isLoading.value = true;
    errorMessage.value = '';
    try {
      await _driverRepository.updateStatus(value);
      isOnline.value = value;
      driver.value = driver.value.copyWith(isOnline: value);
      if (value) {
        await _locationService.startTracking(
          onLocation: _driverRepository.updateLocation,
        );
        await loadRideRequests();
        _notificationService.showInAppMessage(
          'You are online',
          'Nearby ride requests are now available.',
        );
      } else {
        await _locationService.stopTracking();
        rideRequests.clear();
      }
    } on Exception catch (error) {
      isOnline.value = false;
      errorMessage.value = error.toString().replaceFirst('Exception: ', '');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loadRideRequests() async {
    if (!isOnline.value) return;
    rideRequests.assignAll(await _driverRepository.getRideRequests());
  }

  Future<void> acceptRide(RideModel ride) async {
    if (!isOnline.value) {
      errorMessage.value = 'Go online before accepting a ride.';
      return;
    }
    isLoading.value = true;
    try {
      activeRide.value = await _rideRepository.acceptRide(ride, driver.value);
      rideRequests.removeWhere((request) => request.id == ride.id);
      Get.offNamed(AppRoutes.driverActiveTrip);
    } on Exception catch (error) {
      errorMessage.value = error.toString().replaceFirst('Exception: ', '');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> rejectRide(RideModel ride) async {
    await _rideRepository.rejectRide(ride.id);
    rideRequests.removeWhere((request) => request.id == ride.id);
  }

  Future<void> advanceTrip() async {
    final ride = activeRide.value;
    if (ride == null) return;
    isLoading.value = true;
    try {
      activeRide.value = switch (ride.status) {
        RideStatus.driverAssigned =>
          ride.copyWith(status: RideStatus.driverArriving),
        RideStatus.driverArriving => await _rideRepository.markArrived(ride),
        RideStatus.driverArrived => await _rideRepository.startRide(ride),
        RideStatus.tripStarted => await _rideRepository.completeRide(ride),
        _ => ride,
      };

      if (activeRide.value?.status == RideStatus.tripCompleted) {
        earnings.value = earnings.value.addTrip(ride.fare);
        tripHistory.insert(0, activeRide.value!);
        _notificationService.showInAppMessage(
          'Ride completed',
          '₹${ride.fare.round()} added to today’s earnings.',
        );
      }
    } on Exception catch (error) {
      errorMessage.value = error.toString().replaceFirst('Exception: ', '');
    } finally {
      isLoading.value = false;
    }
  }

  String actionForStatus(RideStatus status) => switch (status) {
        RideStatus.driverAssigned => 'Navigate to pickup',
        RideStatus.driverArriving => 'Mark as arrived',
        RideStatus.driverArrived => 'Start trip',
        RideStatus.tripStarted => 'Complete trip',
        RideStatus.tripCompleted => 'Return to dashboard',
        _ => 'Continue',
      };

  void finishCompletedRide() {
    activeRide.value = null;
    Get.offAllNamed(AppRoutes.driverDashboard);
  }

  Future<void> logout() async {
    if (isOnline.value) await toggleOnline(false);
    await _roleController.logout();
  }

  @override
  void onClose() {
    _locationService.stopTracking();
    super.onClose();
  }
}
