import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_animations/flutter_map_animations.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:nectar/src/data/services/geoservices.dart';
import 'package:nectar/src/presentation/utils/app_colors.dart';
import 'package:nectar/src/secrets.dart';

class SetLocationMapPage extends StatefulWidget {
  const SetLocationMapPage({super.key});

  @override
  State<SetLocationMapPage> createState() => _SetLocationMapPageState();
}

class _SetLocationMapPageState extends State<SetLocationMapPage>
    with TickerProviderStateMixin {
  final mapController = MapController();
  late final _animatedMapController = AnimatedMapController(
    vsync: this,
    mapController: mapController,
  );

  Position? position;

  @override
  void dispose() {
    _animatedMapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Set Location'),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // zoom in
          FloatingActionButton(
            heroTag: 'zoomIn',
            child: const Icon(Icons.zoom_in),
            onPressed: () {
              _animatedMapController.animatedZoomIn();
            },
          ),
          const SizedBox(height: 10),
          // zoom out
          FloatingActionButton(
            heroTag: 'zoomOut',
            child: const Icon(Icons.zoom_out),
            onPressed: () {
              _animatedMapController.animatedZoomOut();
            },
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
            onPressed: () async {
              String placeName = await Geoservices().reverseGeocoding(
                position!.latitude,
                position!.longitude,
              );

              if (context.mounted) {
                Navigator.pop(context, placeName);
              }
            },
            child: const Icon(Icons.done),
          ),
        ],
      ),
      body: FutureBuilder<Position>(
        future: _getCurrentLocation(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            position = snapshot.data!;
            return FlutterMap(
              mapController: _animatedMapController.mapController,
              options: MapOptions(
                initialCenter: LatLng(position!.latitude, position!.longitude),
                initialZoom: 15.0,
                cameraConstraint: CameraConstraint.contain(
                  bounds: LatLngBounds(
                    const LatLng(-90, -180.0),
                    const LatLng(90.0, 180.0),
                  ),
                ),
              ),
              children: [
                TileLayer(
                  urlTemplate:
                      "https://api.mapbox.com/styles/v1/mapbox/streets-v12/tiles/{z}/{x}/{y}?access_token=$mapboxAccessToken",
                ),
                CurrentLocationLayer(),
              ],
            );
          }
        },
      ),
    );
  }

  Future<Position> _getCurrentLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      permission = await Geolocator.requestPermission();
    }

    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.best,
    );
  }
}
