import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class FieldMap extends StatefulWidget {
  const FieldMap({
    super.key,
    required this.selectLocation,
  });

  final void Function(LatLng location) selectLocation;

  @override
  State<FieldMap> createState() => _FieldMapState();
}

class _FieldMapState extends State<FieldMap> {
  GoogleMapController? _controller;

  LatLng? _selectedLocation;
  LatLng _initialLocation = const LatLng(-17.824858, 31.053028);

  void _onMapCreated(GoogleMapController controller) {
    _controller = controller;
    _controller!.moveCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: _initialLocation, zoom: 14),
      ),
    );
  }

  Future<void> _getUserLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return;
    }

    Position position = await Geolocator.getCurrentPosition();
    setState(() {
      _initialLocation = LatLng(position.latitude, position.longitude);
    });
  }

  void _onTap(LatLng location) {
    setState(() {
      _selectedLocation = location;
    });
    widget.selectLocation(location);
  }

  @override
  void initState() {
    super.initState();
    _getUserLocation();
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      mapType: MapType.normal,
      initialCameraPosition: CameraPosition(
        target: _initialLocation,
        zoom: 14,
      ),
      onMapCreated: _onMapCreated,
      onTap: _onTap,
      markers: _selectedLocation != null
          ? {
              Marker(
                markerId: const MarkerId('selected-location'),
                position: _selectedLocation!,
              ),
            }
          : {},
      myLocationEnabled: true,
      myLocationButtonEnabled: true,
    );
  }
}
