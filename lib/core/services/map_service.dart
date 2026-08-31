import '../../data/models/location_model.dart';

class MapService {
  // TODO: Add your Google Maps API key to AndroidManifest.xml and AppDelegate.
  // Replace it with your own key. Do not commit real API keys to GitHub.

  double calculateMockDistanceKm(LocationModel from, LocationModel to) {
    final latitudeDelta = (from.latitude - to.latitude).abs();
    final longitudeDelta = (from.longitude - to.longitude).abs();
    return ((latitudeDelta + longitudeDelta) * 72)
        .clamp(1.0, 50.0)
        .toDouble();
  }
}
