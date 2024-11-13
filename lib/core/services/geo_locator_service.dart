// import 'package:geolocator/geolocator.dart';
//
// class GeoLocatorService {
//   Future<Position> getCurrentLocation() async {
//     bool serviceEnabled;
//     LocationPermission permission;
//
//     // Mengecek apakah layanan lokasi aktif
//     serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       return Future.error('Layanan lokasi tidak aktif.');
//     }
//
//     // Meminta izin lokasi jika belum diberikan
//     permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) {
//         return Future.error('Izin lokasi ditolak.');
//       }
//     }
//
//     if (permission == LocationPermission.deniedForever) {
//       return Future.error('Izin lokasi ditolak secara permanen.');
//     }
//
//     // Mendapatkan posisi lokasi saat ini
//     return await Geolocator.getCurrentPosition(
//       locationSettings: const LocationSettings(
//         accuracy: LocationAccuracy.best,
//
//       ),
//     );
//   }
// }
