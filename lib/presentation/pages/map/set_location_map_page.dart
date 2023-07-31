import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nectar/data/services/geoservices.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:nectar/presentation/utils/app_colors.dart';
import 'package:nectar/secrets.dart';

class SetLocationMapPage extends StatefulWidget {
  const SetLocationMapPage({super.key});

  @override
  State<SetLocationMapPage> createState() => _SetLocationMapPageState();
}

class _SetLocationMapPageState extends State<SetLocationMapPage> {
  static Position? _currentPosition;

  @override
  void initState() {
    super.initState();

    Geoservices().getCurrentLocation().then((value) {
      if (mounted) {
        setState(() {
          _currentPosition = value;
        });
      }
    });
  }

  LatLng selectedLocation = LatLng(
    _currentPosition?.latitude ?? 37.7749,
    _currentPosition?.longitude ?? -122.4194,
  );

  void _selectLocation(LatLng position) {
    setState(() {
      selectedLocation = position;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Geoservices().getCurrentLocation(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return _buildMap();
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget _buildMap() {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Select Location"),
      ),
      body: FlutterMap(
        options: MapOptions(
          zoom: 18.0,
          maxZoom: 18.0,
          center: selectedLocation,
          onTap: (tapPosition, latLng) => _selectLocation(latLng),
          maxBounds: LatLngBounds(
            const LatLng(-90, -180.0),
            const LatLng(90.0, 180.0),
          ),
        ),
        children: [
          TileLayer(
            urlTemplate:
                "https://api.mapbox.com/styles/v1/mapbox/streets-v12/tiles/{z}/{x}/{y}?access_token=$MAPBOX_ACCESS_TOKEN",
          ),
          MarkerLayer(
            markers: [
              Marker(
                width: 30,
                height: 30,
                point: selectedLocation,
                builder: (ctx) => SvgPicture.asset(
                  "assets/svg/location.svg",
                  colorFilter: const ColorFilter.mode(
                    AppColors.primary,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        onPressed: () async {
          String placeName = await Geoservices().reverseGeocoding(
            selectedLocation.latitude,
            selectedLocation.longitude,
          );

          if (mounted) {
            Navigator.pop(context, placeName);
          }
        },
        child: const Icon(Icons.check),
      ),
    );
  }
}
