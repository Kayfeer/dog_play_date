// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  // Position initiale (exemple : Paris)
  static const LatLng _initialPosition = LatLng(48.8566, 2.3522);

  // Liste fictive de rendez-vous avec leurs positions
  final List<Map<String, dynamic>> _appointments = [
    {"title": "Promenade au parc", "position": LatLng(48.8570, 2.3525)},
    {"title": "Rencontre canine", "position": LatLng(48.8560, 2.3510)},
    {"title": "Sortie duo", "position": LatLng(48.8580, 2.3530)},
  ];

  late GoogleMapController _mapController;
  final Set<Marker> _markers = {};

  // Rayon sélectionné par l'utilisateur (en km)
  double _distanceRadius = 5.0;

  @override
  void initState() {
    super.initState();
    _setMarkers();
  }

  void _setMarkers() {
    _markers.clear();
    for (var appt in _appointments) {
      _markers.add(
        Marker(
          markerId: MarkerId(appt["title"]),
          position: appt["position"],
          infoWindow: InfoWindow(title: appt["title"]),
        ),
      );
    }
  }

  // Exemple de dialogue de notifications (push/SMS)
  void _showNotificationApprovalDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Notifications"),
        content: const Text(
            "Choisissez le mode de notification pour recevoir des mises à jour :"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Notifications push activées.")),
              );
            },
            child: const Text("Push"),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Notifications SMS activées.")),
              );
            },
            child: const Text("SMS"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Carte des rendez-vous"),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: _showNotificationApprovalDialog,
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: GoogleMap(
              initialCameraPosition: const CameraPosition(
                target: _initialPosition,
                zoom: 14,
              ),
              markers: _markers,
              onMapCreated: (GoogleMapController controller) {
                _mapController = controller;
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.white,
            child: Column(
              children: [
                const Text("Choisissez la distance de vision (km) :"),
                Slider(
                  value: _distanceRadius,
                  min: 1,
                  max: 20,
                  divisions: 19,
                  label: _distanceRadius.toStringAsFixed(0),
                  onChanged: (value) {
                    setState(() {
                      _distanceRadius = value;
                      // Ici, vous pouvez filtrer les rendez-vous en fonction du rayon sélectionné.
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
