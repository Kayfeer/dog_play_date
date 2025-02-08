import 'package:flutter/material.dart';
import 'dashboard_screen.dart';
import 'match_screen.dart';
import 'appointments_screen.dart';
import 'profile_screen.dart';
import 'settings_drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  final List<Widget> _screens = const [
    DashboardScreen(),
    MatchScreen(),
    AppointmentsScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const SettingsDrawer(),
      body: _screens[_currentIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home), label: "Accueil"),
          NavigationDestination(icon: Icon(Icons.favorite), label: "Match"),
          NavigationDestination(icon: Icon(Icons.event), label: "Rendez-vous"),
          NavigationDestination(icon: Icon(Icons.person), label: "Profil"),
        ],
      ),
    );
  }
}
