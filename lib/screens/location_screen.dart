import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
// ignore_for_file: library_private_types_in_public_api

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  String _locationMessage = "Localisation non récupérée";

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Vérifie que le service de localisation est activé sur l'appareil.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      setState(() {
        _locationMessage = "Les services de localisation sont désactivés.";
      });
      return;
    }

    // Vérifie la permission actuelle.
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      // Demande la permission à l'utilisateur.
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        setState(() {
          _locationMessage = "Permissions de localisation refusées.";
        });
        return;
      }
    }

    // Si la permission est refusée définitivement.
    if (permission == LocationPermission.deniedForever) {
      setState(() {
        _locationMessage =
            "Les permissions de localisation sont refusées définitivement.";
      });
      return;
    }

    // Récupère la position actuelle avec une précision élevée.
    Position position = await Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(accuracy: LocationAccuracy.high),
    );

    setState(() {
      _locationMessage =
          "Latitude: ${position.latitude}, Longitude: ${position.longitude}";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ma position"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_locationMessage),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _getCurrentLocation,
              child: const Text("Récupérer ma position"),
            ),
          ],
        ),
      ),
    );
  }
}
