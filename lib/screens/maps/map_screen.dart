import 'package:ai_real_estate/widgets/app_shell.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatelessWidget { const MapScreen({super.key}); @override Widget build(BuildContext context) => const AppShell(title: 'Location Intelligence', child: GoogleMap(initialCameraPosition: CameraPosition(target: LatLng(37.7749, -122.4194), zoom: 13), markers: {Marker(markerId: MarkerId('home'), position: LatLng(37.7749, -122.4194), infoWindow: InfoWindow(title: 'Selected property')), Marker(markerId: MarkerId('school'), position: LatLng(37.7849, -122.4194), infoWindow: InfoWindow(title: 'Nearby school')), Marker(markerId: MarkerId('park'), position: LatLng(37.7749, -122.4094), infoWindow: InfoWindow(title: 'Nearby park'))})); }
