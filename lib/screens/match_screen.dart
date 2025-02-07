import 'package:flutter/material.dart';

class MatchScreen extends StatefulWidget {
  const MatchScreen({Key? key}) : super(key: key);

  @override
  _MatchScreenState createState() => _MatchScreenState();
}

class _MatchScreenState extends State<MatchScreen> {
  // Exemple de profils canins
  final List<Map<String, dynamic>> dogProfiles = [
    {
      "name": "Buddy",
      "age": 3,
      "image": "assets/images/dog1.jpg",
      "bio": "Labrador énergique et sociable."
    },
    {
      "name": "Bella",
      "age": 2,
      "image": "assets/images/dog2.jpg",
      "bio": "Chienne douce qui adore jouer au frisbee."
    },
  ];

  int currentIndex = 0;

  void _swipeLeft() {
    setState(() {
      if (currentIndex < dogProfiles.length - 1) currentIndex++;
    });
  }

  void _swipeRight() {
    setState(() {
      if (currentIndex < dogProfiles.length - 1) currentIndex++;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (dogProfiles.isEmpty) {
      return Center(child: Text("Aucun profil disponible."));
    }

    final currentProfile = dogProfiles[currentIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text("Rencontre Canine"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Faites défiler pour trouver votre compagnon",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            // Carte de profil
            Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.85,
                height: MediaQuery.of(context).size.height * 0.55,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                    image: AssetImage(currentProfile["image"]),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: LinearGradient(
                      colors: [
                        Colors.black.withOpacity(0.6),
                        Colors.transparent,
                      ],
                      begin: Alignment.bottomCenter,
                      end: Alignment.center,
                    ),
                  ),
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        "${currentProfile["name"]}, ${currentProfile["age"]} ans\n${currentProfile["bio"]}",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 30),
            // Boutons de swipe
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FloatingActionButton(
                  backgroundColor: Colors.red,
                  onPressed: _swipeLeft,
                  child: Icon(Icons.close),
                ),
                SizedBox(width: 40),
                FloatingActionButton(
                  backgroundColor: Colors.green,
                  onPressed: _swipeRight,
                  child: Icon(Icons.favorite),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
