import 'package:dog_play_date/screens/event_location_picker.dart';
import 'package:flutter/material.dart';
import 'map_screen.dart'; // Assurez-vous d'importer MapScreen
import 'dog_info_screen.dart';
import 'photo_share_screen.dart';
import 'package:dog_play_date/logger.dart'; // Importation du logger

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dog Play Date"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 6,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.deepOrange.shade400,
                      Colors.pinkAccent.shade200
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Text(
                  "Bienvenue sur Dog Play Date !",
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              icon: const Icon(Icons.location_on),
              label: const Text("Voir la carte"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MapScreen()),
                );
              },
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              icon: const Icon(Icons.pets),
              label: const Text("Infos sur le chien"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const DogInfoScreen()),
                );
              },
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              icon: const Icon(Icons.photo),
              label: const Text("Partager une photo"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const PhotoShareScreen()),
                );
              },
            ),
            ElevatedButton.icon(
              icon: const Icon(Icons.place),
              label: const Text("Sélectionner un lieu"),
              onPressed: () async {
                // Vous pouvez initialiser avec une chaîne vide ou un placeId par défaut
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const EventLocationPicker(
                        locationPlaceId: "initial_place_id"),
                  ),
                );
                if (result != null) {
                  // Utilisez le logger au lieu de print pour consigner les résultats
                  logger.info(
                      "PlaceId: ${result['placeId']}, Address: ${result['address']}");
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
