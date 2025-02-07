import 'package:flutter/material.dart';
import 'location_screen.dart';
import 'dog_info_screen.dart';
import 'photo_share_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dog Play Date"),
      ),
      body: Center(
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          shrinkWrap: true,
          children: [
            ElevatedButton.icon(
              icon: Icon(Icons.location_on),
              label: Text("Ma position"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LocationScreen()),
                );
              },
            ),
            SizedBox(height: 16),
            ElevatedButton.icon(
              icon: Icon(Icons.pets),
              label: Text("Infos sur le chien"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DogInfoScreen()),
                );
              },
            ),
            SizedBox(height: 16),
            ElevatedButton.icon(
              icon: Icon(Icons.photo),
              label: Text("Partager une photo"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PhotoShareScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
