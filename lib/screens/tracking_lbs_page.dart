import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:async';

class TrackingPage extends StatefulWidget {
  const TrackingPage({super.key});

  @override
  State<TrackingPage> createState() => _TrackingPageState();
}

class _TrackingPageState extends State<TrackingPage> {
  GoogleMapController? _mapController;
  LatLng _currentLatLng =
      const LatLng(-7.797068, 110.370529); // Yogyakarta default
  StreamSubscription<Position>? _positionSubscription; // ✅ dipindah ke sini

  final MarkerId _markerId = const MarkerId("currentLocation");
  final Map<MarkerId, Marker> _markers = {};
  bool _isTracking = false;
  String _currentAddress = "Menunggu lokasi...";

  @override
  void initState() {
    super.initState();
    _initLocationTracking();
  }

  Future<void> _initLocationTracking() async {
    final permissionStatus = await Permission.location.request();
    if (!permissionStatus.isGranted) return;

    bool isEnabled = await Geolocator.isLocationServiceEnabled();
    if (!isEnabled) {
      await Geolocator.openLocationSettings();
      return;
    }

    // Ambil lokasi saat ini sekali (opsional)
    Position position = await Geolocator.getCurrentPosition();
    final currentLatLng = LatLng(position.latitude, position.longitude);
    _updateMarker(currentLatLng);
    _mapController?.animateCamera(CameraUpdate.newLatLng(currentLatLng));
    setState(() {
      _currentLatLng = currentLatLng;
    });

    // Ambil alamat awal (opsional)
    _getAddressFromLatLng(currentLatLng);
  }

  void _startTracking() {
    setState(() {
      _isTracking = true;
    });

    _positionSubscription = Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 5,
      ),
    ).listen((position) async {
      final newLatLng = LatLng(position.latitude, position.longitude);
      setState(() {
        _currentLatLng = newLatLng;
        _updateMarker(newLatLng);
        _mapController?.animateCamera(CameraUpdate.newLatLng(newLatLng));
      });

      await _getAddressFromLatLng(newLatLng);
    });
  }

  Future<void> _getAddressFromLatLng(LatLng latLng) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        latLng.latitude,
        latLng.longitude,
      );
      if (placemarks.isNotEmpty) {
        final place = placemarks[0];
        setState(() {
          _currentAddress =
              "${place.street}, ${place.subLocality}, ${place.locality}";
        });
      }
    } catch (e) {
      setState(() {
        _currentAddress = "Gagal mengambil alamat";
      });
    }
  }

  void _stopTracking() {
    _positionSubscription?.cancel();
    _positionSubscription = null;

    setState(() {
      _isTracking = false;
      _currentAddress = "Tracking berhenti";
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
  void dispose() {
    _positionSubscription?.cancel(); // pastikan stream dimatikan
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tracking Lokasi (LBS)'),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition:
                CameraPosition(target: _currentLatLng, zoom: 16),
            onMapCreated: (controller) => _mapController = controller,
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            markers: Set<Marker>.of(_markers.values),
          ),
          Positioned(
            bottom: 80,
            left: 20,
            right: 80,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.9),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Text(
                _currentAddress,
                style: const TextStyle(fontSize: 14, color: Colors.black87),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _isTracking ? _stopTracking : _startTracking,
        backgroundColor: _isTracking ? Colors.red : Colors.green,
        child: Icon(_isTracking ? Icons.stop : Icons.play_arrow),
      ),
    );
  }
}
