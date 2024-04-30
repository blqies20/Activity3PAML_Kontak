import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  final Function(String) onLocationSeleced;

  MapScreen({super.key, required this.onLocationSeleced});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController mapController;
  LatLng? _lastMapPosistion;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    await Geolocator.requestPermission()
        .then((value) {})
        .onError((error, stackTrace) async {
      await Geolocator.requestPermission();
    });

    var position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      _lastMapPosistion = LatLng(position.latitude, position.longitude);
    });
    mapController.animateCamera(CameraUpdate.newLatLng(_lastMapPosistion!));
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    if (_lastMapPosistion != null) {
      setState(() {
        mapController.animateCamera(CameraUpdate.newLatLng(_lastMapPosistion!));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Select Location"),
      ),
      body: GoogleMap(
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
        buildingsEnabled: true,
        trafficEnabled: true,
        zoomControlsEnabled: true,
        zoomGesturesEnabled: true,
        mapToolbarEnabled: true,
        compassEnabled: true,
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
            target: _lastMapPosistion ?? LatLng(0.0, 0.0), zoom: 20.0),
        markers: {
          if (_lastMapPosistion != null)
            Marker(
                markerId: MarkerId('current location'),
                position: _lastMapPosistion!)
        },
        onTap: (position) {
          setState(() {
            _lastMapPosistion = position;
          });
        },
      ),
    );
  }
}
