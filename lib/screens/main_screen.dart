import 'package:flutter/material.dart';
import 'package:motion_tab_bar_v2/motion-tab-bar.dart';

// Import halaman yang akan digunakan
import 'home_page.dart';
import 'stats_page.dart';
import 'team_page.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0; // Menyimpan index tab yang terpilih

  // Daftar halaman yang akan ditampilkan sesuai tab
  final List<Widget> _pages = [
    HomePage(),  // Halaman Home
    StatsPage(), // Halaman Stats
    TeamPage(),  // Halaman Team
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex], // Menampilkan halaman sesuai index
      bottomNavigationBar: MotionTabBar(
        initialSelectedTab: "Home",
        labels: const ["Home", "Stats", "Team"],
        icons: const [Icons.home, Icons.bar_chart, Icons.people],
        tabSize: 50,
        tabBarHeight: 60,
        textStyle: const TextStyle(color: Colors.green, fontSize: 12),
        tabIconColor: Colors.grey,
        tabIconSize: 24,
        tabIconSelectedSize: 28,
        tabSelectedColor: Colors.green,
        onTabItemSelected: (int value) {
          setState(() {
            _selectedIndex = value; // Ubah index saat tab di-klik
          });
        },
      ),
    );
  }
}
