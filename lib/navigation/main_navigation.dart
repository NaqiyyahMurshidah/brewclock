import 'package:flutter/material.dart';
import '../screens/home/home_screen.dart';
import '../screens/tracker/tracker_screen.dart';
import '../screens/sleep/sleep_screen.dart';
import '../screens/statistics/statistic_screen.dart';
import '../screens/profile/profile_screen.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _selectedIndex = 0;

  final List<Widget> _pages = const [
    HomeScreen(),
    TrackerScreen(),
    SleepScreen(),
    StatisticsScreen(),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      
      body: _pages[_selectedIndex],

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,

        type: BottomNavigationBarType.fixed,

        selectedItemColor: const Color(0xFFD8A15B),
        unselectedItemColor: Colors.grey,

        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.coffee), 
            label: "Tracker"
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.bedtime),
            label: "Sleep"
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: "Statistics"
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.person), 
            label: "Home"
          ),

        ],
      ),
    );
  }
}
