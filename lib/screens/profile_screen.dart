import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil utilisateur'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            // Affichage d'une image de profil (vous devez ajouter une image dans assets/images/)
            const CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/images/user_placeholder.png'),
            ),
            const SizedBox(height: 20),
            const Text(
              'Prénom : Jean',
              style: TextStyle(fontSize: 20),
            ),
            const Text(
              'Âge : 30 ans',
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Retour à l'écran précédent
                Navigator.pop(context);
              },
              child: const Text('Retour'),
            ),
          ],
        ),
      ),
    );
  }
}
