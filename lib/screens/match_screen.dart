import 'package:dog_play_date/screens/chat_screen.dart';
import 'package:flutter/material.dart';

class MatchScreen extends StatefulWidget {
  const MatchScreen({super.key});

  @override
  State<MatchScreen> createState() => _MatchScreenState();
}

class _MatchScreenState extends State<MatchScreen> {
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

  void _swipe() {
    setState(() {
      if (currentIndex < dogProfiles.length - 1) {
        currentIndex++;
      } else {
        currentIndex = 0; // Réinitialisation pour l'exemple
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentProfile = dogProfiles[currentIndex];
    return Scaffold(
      appBar: AppBar(
        title: const Text("Rencontre Canine"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Carte de profil avec Hero pour transition vers le chat
            Hero(
              tag: 'chatHero',
              child: Card(
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
                          Color.fromARGB(255, 0, 0, 0).withValues(alpha: 0.1),
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
                          style: const TextStyle(
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
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FloatingActionButton(
                  backgroundColor: Colors.red,
                  onPressed: _swipe,
                  child: const Icon(Icons.close),
                ),
                const SizedBox(width: 40),
                FloatingActionButton(
                  backgroundColor: Colors.green,
                  onPressed: () {
                    // Transition vers l'écran de chat avec animation personnalisée.
                    Navigator.of(context).push(PageRouteBuilder(
                      transitionDuration: const Duration(milliseconds: 500),
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          const ChatScreen(),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        return FadeTransition(
                          opacity: animation,
                          child: child,
                        );
                      },
                    ));
                  },
                  child: const Icon(Icons.favorite),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
