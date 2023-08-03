import 'package:nectar/secrets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:dio/dio.dart';

class Geoservices {
// get current location, ask for permission if not granted
  Future<Position> getCurrentLocation() async {
    final GeolocatorPlatform geolocatorPlatform = GeolocatorPlatform.instance;
    final LocationPermission permission =
        await geolocatorPlatform.checkPermission();
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.',
      );
    } else if (permission == LocationPermission.denied) {
      final LocationPermission permission =
          await geolocatorPlatform.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    return await geolocatorPlatform.getCurrentPosition();
  }

  Future<String> reverseGeocoding(double latitude, double longitude) async {
    final String url =
        'https://api.mapbox.com/geocoding/v5/mapbox.places/$longitude,$latitude.json?access_token=$mapboxAccessToken';
    final Response response = await Dio().get(url);
    // get street name and house number
    final String streetName = response.data['features'][0]['text'] ?? 'Unknown';
    final String houseNumber =
        response.data['features'][0]['address'] ?? 'Unknown';
    return '$houseNumber, $streetName';
  }
}
