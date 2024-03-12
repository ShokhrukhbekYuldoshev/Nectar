import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';

class Geoservices {
  /// Get the address of the given latitude and longitude
  Future<String> reverseGeocoding(double latitude, double longitude) async {
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(latitude, longitude);
      Placemark place = placemarks[0];

      // Construct the address
      String address = "${place.street}, ${place.locality}, ${place.country}";

      return address;
    } catch (e, s) {
      debugPrintStack(label: e.toString(), stackTrace: s);
      return "Unable to get address";
    }
  }
}
