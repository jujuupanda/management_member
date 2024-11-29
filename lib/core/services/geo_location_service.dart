import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

import '../utils/utils.dart';

class GeoLocationService {
  Future<void> requestLocationPermission() async {
    PermissionStatus status = await Permission.location.request();

    if (status.isGranted) {
      // // PermissionStatus backgroundStatus =
      // //     await Permission.locationAlways.request();
      // if (backgroundStatus.isGranted) {}
    } else {
      if (status.isDenied) {}
    }
  }

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

  Future<Position> getCurrentLocation(BuildContext context) async {
    await requestLocationPermission();
    // bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    // if (!serviceEnabled) {
    //   return Future.error("Layanan lokasi tidak aktif.");
    // }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            duration: const Duration(seconds: 1),
            content: Text(
              "Lokasi tidak aktif",
              style: StyleText().openSansNormalBlack,
            ),
          ),
        );
      }
      return Future.error("Izin lokasi ditolak.");
    }

    if (permission == LocationPermission.deniedForever) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            duration: const Duration(seconds: 1),
            content: Text(
              "Lokasi tidak diizinkan",
              style: StyleText().openSansNormalBlack,
            ),
          ),
        );
      }
      return Future.error("Izin lokasi ditolak secara permanen.");
    }

    try {
      final currentLocation = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.best,
        ),
      );
      return currentLocation;
    } catch (e) {
      return Future.error("Gagal mendapatkan lokasi");
    }
  }
}
