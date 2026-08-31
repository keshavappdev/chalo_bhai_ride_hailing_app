import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../data/models/location_model.dart';
import '../config/app_config.dart';
import 'map_mock_card.dart';

class AppMapCard extends StatelessWidget {
  const AppMapCard({
    super.key,
    this.height = 230,
    this.title = 'Delhi route preview',
    this.showCar = true,
    this.pickup,
    this.drop,
  });

  final double height;
  final String title;
  final bool showCar;
  final LocationModel? pickup;
  final LocationModel? drop;

  @override
  Widget build(BuildContext context) {
    if (AppConfig.useMockData) {
      return MapMockCard(
        height: height,
        title: title,
        showCar: showCar,
      );
    }

    final start = pickup ??
        const LocationModel(
          latitude: 28.6139,
          longitude: 77.2090,
          address: 'New Delhi',
        );
    final startPosition = LatLng(start.latitude, start.longitude);
    final destination = drop == null
        ? null
        : LatLng(drop!.latitude, drop!.longitude);

    return ClipRRect(
      borderRadius: BorderRadius.circular(22),
      child: SizedBox(
        height: height,
        width: double.infinity,
        child: GoogleMap(
          initialCameraPosition: CameraPosition(target: startPosition, zoom: 13),
          myLocationButtonEnabled: false,
          zoomControlsEnabled: false,
          compassEnabled: false,
          mapToolbarEnabled: false,
          markers: {
            Marker(
              markerId: const MarkerId('pickup'),
              position: startPosition,
              infoWindow: InfoWindow(title: start.title ?? 'Pickup'),
            ),
            if (destination != null)
              Marker(
                markerId: const MarkerId('drop'),
                position: destination,
                infoWindow: InfoWindow(title: drop?.title ?? 'Destination'),
              ),
          },
        ),
      ),
    );
  }
}
