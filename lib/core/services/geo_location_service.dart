import 'package:geolocator/geolocator.dart';

class GeoLocationService {
  Future<void> locationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error("Layanan lokasi tidak aktif.");
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error("Izin lokasi ditolak.");
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error("Izin lokasi ditolak secara permanen.");
    }
  }

  Future<Position> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error("Layanan lokasi tidak aktif.");
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error("Izin lokasi ditolak.");
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error("Izin lokasi ditolak secara permanen.");
    }

    final currentLocation = await Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.best,
      ),
    );
    return currentLocation;
  }
}
