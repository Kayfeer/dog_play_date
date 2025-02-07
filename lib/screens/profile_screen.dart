import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profil utilisateur'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            // Affichage d'une image de profil (vous devez ajouter une image dans assets/images/)
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/images/user_placeholder.png'),
            ),
            SizedBox(height: 20),
            Text(
              'Prénom : Jean',
              style: TextStyle(fontSize: 20),
            ),
            Text(
              'Âge : 30 ans',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Retour à l'écran précédent
                Navigator.pop(context);
              },
              child: Text('Retour'),
            ),
          ],
        ),
      ),
    );
  }
}
