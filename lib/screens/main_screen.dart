import 'package:flutter/material.dart';
import 'grafik_page.dart';
import 'monitoring_page.dart';
import 'controlling_page.dart';
import '../models/chart_data.dart';  // Pastikan model ini diimpor

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 1;

  // Data sampel untuk GrafikPage (ganti dengan data asli dari backend Anda)
  final List<ChartData> sampleData = [
    ChartData(DateTime.now().subtract(Duration(hours: 1)), 25.0, 10.0),
    ChartData(DateTime.now(), 28.0, 15.0),
    // Tambahkan data palsu lainnya jika diperlukan
  ];

  // Membuat list halaman dengan mengirimkan data pada grafik page
  final List<Widget> _pages = [
    GrafikPage(sensorDataList: [
      ChartData(DateTime.now().subtract(Duration(hours: 1)), 25.0, 10.0),
      ChartData(DateTime.now(), 28.0, 15.0),
      // Tambahkan data palsu lainnya jika diperlukan
    ]), // GrafikPage dengan data
    MonitoringPage(),
    ControllingPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex], // Menampilkan halaman berdasarkan index
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index; // Menyimpan halaman yang dipilih
          });
        },
        selectedItemColor: Colors.green, // Mengatur warna ikon yang dipilih
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.show_chart),
            label: 'Grafik',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.monitor),
            label: 'Monitoring',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Controlling',
          ),
        ],
      ),
    );
  }
}
