import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class TrackingPage extends StatefulWidget {
  const TrackingPage({super.key});

  @override
  State<TrackingPage> createState() => _TrackingPageState();
}

class _TrackingPageState extends State<TrackingPage> {
  GoogleMapController? _mapController;
  LatLng _currentLatLng =
      const LatLng(-7.797068, 110.370529); // Yogyakarta default
  Stream<Position>? _positionStream;

  final MarkerId _markerId = const MarkerId("currentLocation");
  final Map<MarkerId, Marker> _markers = {};
  bool _isTracking = false;

  @override
  void initState() {
    super.initState();
    _initLocationTracking();
  }

  @override
  void dispose() {
    super.dispose();
    _positionStream = null;
  }

  Future<void> _initLocationTracking() async {
    final permissionStatus = await Permission.location.request();
    if (!permissionStatus.isGranted) return;

    bool isEnabled = await Geolocator.isLocationServiceEnabled();
    if (!isEnabled) {
      await Geolocator.openLocationSettings();
      return;
    }

    _positionStream = Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 5,
      ),
    );
  }

  void _startTracking() {
    setState(() {
      _isTracking = true;
    });

    _positionStream!.listen((position) {
      setState(() {
        _currentLatLng = LatLng(position.latitude, position.longitude);
        _updateMarker(_currentLatLng);
        _mapController?.animateCamera(CameraUpdate.newLatLng(_currentLatLng));
      });
    });
  }

  void _stopTracking() {
    setState(() {
      _isTracking = false;
    });
  }

  void _updateMarker(LatLng position) {
    final marker = Marker(
      markerId: _markerId,
      position: position,
      infoWindow: const InfoWindow(title: "Lokasi Saya"),
    );

    setState(() {
      _markers[_markerId] = marker;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tracking Lokasi (LBS)'),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(target: _currentLatLng, zoom: 16),
        onMapCreated: (controller) => _mapController = controller,
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
        markers: Set<Marker>.of(_markers.values),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _isTracking ? _stopTracking : _startTracking,
        backgroundColor: _isTracking ? Colors.red : Colors.green,
        child: Icon(_isTracking ? Icons.stop : Icons.play_arrow),
      ),
    );
  }
}
