import 'package:flutter/material.dart';
import '../screens/home/home_screen.dart';
import '../screens/tracker/tracker_screen.dart';
import '../screens/sleep/sleep_screen.dart';
import '../screens/statistics/statistic_screen.dart';
import '../screens/profile/profile_screen.dart';
import '../screens/log_coffee/drink_loc.dart';
import '../screens/log_coffee/home_log_coffee.dart';
import '../screens/log_coffee/cafe_log_coffee.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _selectedIndex = 0;

  final List<Widget> _pages = const [
    HomeScreen(),
    HomeScreen(),
    TrackerScreen(),
    StatisticsScreen(),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    //Log button
    if (index == 1) {
      _showLogCoffeeSheet();
      return;
    }

    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    print(_selectedIndex);
    return Scaffold(
      body: _pages[_selectedIndex],

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,

        type: BottomNavigationBarType.fixed,

        selectedItemColor: const Color(0xFFD8A15B),
        unselectedItemColor: Colors.grey,

        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),

          BottomNavigationBarItem(
            icon: Icon(Icons.coffee_rounded),
            label: "Log",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.waterfall_chart_sharp),
            label: "Tracker",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: "Statistics",
          ),

          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }

  //show log coffee function
  void _showLogCoffeeSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (sheetContext) {
        return SafeArea(
          child: Container(
            padding: const EdgeInsets.fromLTRB(24, 20, 24, 30),
            decoration: const BoxDecoration(
              color: Color(0xFF2B1F19),
              borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 50,
                  height: 5,
                  decoration: BoxDecoration(
                    color: Colors.white24,
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),

                const SizedBox(height: 24),

                const Icon(
                  Icons.coffee_rounded,
                  size: 55,
                  color: Color(0xFFD8B17B),
                ),

                const SizedBox(height: 16),

                const Text(
                  "Where are you drinking today?",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 30),

                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(sheetContext);

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const HomeLogCoffee(),
                            ),
                          );
                        },
                        child: const Text("Home"),
                      ),
                    ),

                    const SizedBox(width: 12),

                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(sheetContext);

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const CafeLogCoffee(),
                            ),
                          );
                        },
                        child: const Text("Cafe"),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
