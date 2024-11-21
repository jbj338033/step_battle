import 'package:geolocator/geolocator.dart';

class LocationService {
  Future<Position?> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return null;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return null;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return null;
    }

    return await Geolocator.getCurrentPosition();
  }

  Future<double> getDistanceToBattle(Position battleLocation) async {
    Position? currentLocation = await getCurrentLocation();
    if (currentLocation == null) return double.infinity;

    return Geolocator.distanceBetween(
      currentLocation.latitude,
      currentLocation.longitude,
      battleLocation.latitude,
      battleLocation.longitude,
    );
  }
}
