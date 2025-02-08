import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// Utilisez flutter_google_places pour lancer la recherche de lieu
import 'package:flutter_google_places/flutter_google_places.dart';
// Utilisez google_maps_webservice pour obtenir les détails du lieu
import 'package:google_maps_webservice/places.dart';
import '../globals.dart';

class EventLocationPicker extends StatefulWidget {
  final String locationPlaceId;
  const EventLocationPicker({super.key, required this.locationPlaceId});

  @override
  EventLocationPickerState createState() =>
      EventLocationPickerState(locationPlaceId: locationPlaceId);
}

class EventLocationPickerState extends State<EventLocationPicker> {
  String locationPlaceId;
  String originalLocationPlaceId;
  EventLocationPickerState({required this.locationPlaceId})
      : originalLocationPlaceId = locationPlaceId;

  final Completer<GoogleMapController> _controller = Completer();

  // Initialisation de l'API de Google Maps Places avec votre clé
  final GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: GOOGLE_API_KEY);

  String locationAddress = "";
  String hintText = "Search for a location";
  LatLng startingPosition =
      const LatLng(37.7749, -122.4194); // Exemple : San Francisco
  Set<Marker> markers = {};

  /// Retourne un Floating Action Button qui permet de valider la sélection
  Widget getFAB() {
    if (locationPlaceId != originalLocationPlaceId) {
      return FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        child: const Icon(Icons.check),
        onPressed: () {
          Navigator.pop(context, {
            "placeId": locationPlaceId,
            "address": locationAddress,
          });
        },
      );
    } else {
      return Container();
    }
  }

  /// Met à jour la carte et les marqueurs en fonction du [placeId] sélectionné
  Future<void> goToLocation(String placeId) async {
    final PlacesDetailsResponse detailResponse =
        await _places.getDetailsByPlaceId(placeId);
    if (detailResponse.status == "OK" &&
        detailResponse.result.geometry != null) {
      final location = detailResponse.result.geometry!.location;
      setState(() {
        locationPlaceId = placeId;
        locationAddress = detailResponse.result.formattedAddress ?? "";
        startingPosition = LatLng(location.lat, location.lng);
        markers.clear();
        markers.add(
          Marker(
            markerId: MarkerId("eventLocation"),
            position: LatLng(location.lat, location.lng),
            infoWindow: InfoWindow(title: "Location", snippet: locationAddress),
          ),
        );
        hintText = locationAddress;
      });
    }
  }

  /// Récupère les détails du lieu à partir de son ID
  Future<void> getPlaceById(String placeId) async {
    if (placeId.isEmpty) {
      return;
    }
    await goToLocation(placeId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: const Text("Event Location"),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      floatingActionButton: getFAB(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: FutureBuilder(
        future: getPlaceById(locationPlaceId),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).primaryColor,
              ),
            );
          } else {
            return Column(
              children: [
                // Bouton qui lance l'autocomplétion de lieu
                ElevatedButton.icon(
                  icon: const Icon(Icons.search),
                  label: Text(hintText),
                  onPressed: () async {
                    Prediction? p = await PlacesAutocomplete.show(
                      context: context,
                      apiKey: GOOGLE_API_KEY,
                      mode: Mode.overlay, // Ou Mode.fullscreen
                      language: "fr",
                      components: [Component(Component.country, "fr")],
                    );
                    if (p != null && p.placeId != null) {
                      await goToLocation(p.placeId!);
                    }
                  },
                ),
                Expanded(
                  child: GoogleMap(
                    zoomControlsEnabled: false,
                    markers: markers,
                    initialCameraPosition: CameraPosition(
                      target: startingPosition,
                      zoom: 14,
                    ),
                    onMapCreated: (GoogleMapController controller) {
                      if (!_controller.isCompleted) {
                        _controller.complete(controller);
                      }
                    },
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
