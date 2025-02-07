import 'package:flutter/material.dart';

class AppointmentsScreen extends StatelessWidget {
  const AppointmentsScreen({Key? key}) : super(key: key);

  final List<String> appointments = const [
    "Promenade au parc - 12/05/2025",
    "Rencontre canine - 14/05/2025",
    "Sortie duo - 16/05/2025",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mes rendez-vous"),
      ),
      body: ListView.builder(
        itemCount: appointments.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Icon(Icons.event),
            title: Text(appointments[index]),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Ici, vous pourriez afficher un formulaire pour ajouter un rendez-vous.
        },
        child: Icon(Icons.add),
        tooltip: "Ajouter un rendez-vous",
      ),
    );
  }
}
