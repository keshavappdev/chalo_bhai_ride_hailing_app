import 'dart:async';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

import '../../data/models/location_model.dart';
import '../config/app_config.dart';

class LocationService extends GetxService {
  final isTracking = false.obs;
  final latestLocation = Rxn<LocationModel>();
  StreamSubscription<Position>? _positionSubscription;

  Future<LocationModel> getCurrentLocation() async {
    if (AppConfig.useMockData) {
      const mockLocation = LocationModel(
        latitude: 28.6139,
        longitude: 77.2090,
        address: 'Connaught Place, New Delhi',
      );
      latestLocation.value = mockLocation;
      return mockLocation;
    }

    await _ensurePermission();
    final position = await Geolocator.getCurrentPosition();
    var address = 'Current location';
    try {
      final placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );
      if (placemarks.isNotEmpty) {
        final place = placemarks.first;
        address = [
          place.name,
          place.subLocality,
          place.locality,
        ].whereType<String>().where((part) => part.isNotEmpty).join(', ');
      }
    } on Exception {
      // Coordinates remain usable if the platform geocoder is unavailable.
    }
    final location = LocationModel(
      latitude: position.latitude,
      longitude: position.longitude,
      address: address,
    );
    latestLocation.value = location;
    return location;
  }

  Future<void> startTracking({
    void Function(LocationModel location)? onLocation,
  }) async {
    if (isTracking.value) return;
    isTracking.value = true;

    if (AppConfig.useMockData) {
      final location = await getCurrentLocation();
      onLocation?.call(location);
      return;
    }

    await _ensurePermission();
    const settings = LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 20,
    );
    _positionSubscription = Geolocator.getPositionStream(
      locationSettings: settings,
    ).listen((position) {
      final location = LocationModel(
        latitude: position.latitude,
        longitude: position.longitude,
        address: 'Live driver location',
      );
      latestLocation.value = location;
      onLocation?.call(location);
    });
  }

  Future<void> stopTracking() async {
    await _positionSubscription?.cancel();
    _positionSubscription = null;
    isTracking.value = false;
  }

  Future<void> _ensurePermission() async {
    if (!await Geolocator.isLocationServiceEnabled()) {
      throw Exception('Location services are disabled.');
    }

    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      throw Exception('Location permission is required.');
    }
  }

  @override
  void onClose() {
    _positionSubscription?.cancel();
    super.onClose();
  }
}
