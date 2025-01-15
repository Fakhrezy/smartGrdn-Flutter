import 'package:flutter/material.dart';
// import 'package:smartgarden_app/hidroponik_page1.dart';
// import 'package:smartgarden_app/hidroponik_page2.dart';
import 'package:http/http.dart' as http;
import '../../widgets/status_card.dart';
import '../../screens/hidroponik_page1.dart';
import '../../screens/hidroponik_page2.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<ChartData> data = [];
  double hidroponik1 = 0.0, hidroponik2 = 0.0;

  bool isRoofClosed = true;

  @override
  void initState() {
    super.initState();
  }

  Future<void> sendRoofControlCommand(String state) async {
    try {
      final url = Uri.parse('http://192.168.1.64/roof');
      final response = await http.post(
        url,
        body: {'state': state},
      );

      if (response.statusCode == 200) {
        print("Perintah $state berhasil dikirim ke ESP32");
      } else {
        print("Gagal mengirim perintah $state");
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Row(
          children: [
            SizedBox(width: 8), // Memberikan jarak antara ikon dan teks
            Text(
              "Smart Hydroponic",
              style: TextStyle(
                color: Colors.black,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            Icon(
              Icons.eco, // Ikon yang sesuai (misalnya ikon tanaman)
              color: Colors.green,  // Warna ikon
            ),
          ],
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Setelah Dimodifikasi
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,  // Pastikan elemen berada di kiri
                children: [
                  SizedBox(width: 16),  // Memberikan jarak ke kanan sedikit
                  Icon(
                    Icons.dashboard, // Ikon Dashboard
                    color: Colors.teal,
                  ),
                  SizedBox(width: 8), // Memberi jarak antara ikon dan teks
                  Text(
                    "Dashboard",
                    style: TextStyle(fontSize: 20, color: Colors.teal, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            // Menambahkan ilustrasi gambar di atas kontrol
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Center(
                child: Image.asset(
                  'assets/home.jpg',  // Gambar ilustrasi, sesuaikan dengan path file Anda
                  height: 300, // Atur tinggi gambar sesuai kebutuhan
                  width: 300,  // Atur lebar gambar sesuai kebutuhan
                  fit: BoxFit.cover, // Sesuaikan cara gambar mengisi ruang
                ),
              ),
            ),

            // Pindahkan toggle control di sini, antara grafik dan status card
            // Padding(
            //   padding: const EdgeInsets.all(16.0),
            //   child: _buildToggleControl(),
            // ),

            // Status Card
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      // Navigasi ke Halaman Hidroponik 1
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HidroponikPage1(),
                        ),
                      );
                    },
                    child: StatusCard(
                      title: "Hidroponik 1",
                      // value: " ", // Hapus suhu di sini
                      icon: Icons.eco,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      // Navigasi ke Halaman Hidroponik 2
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HidroponikPage2(),
                        ),
                      );
                    },
                    child: StatusCard(
                      title: "Hidroponik 2",
                      // value: " ", // Hapus suhu di sini
                      icon: Icons.eco,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget _buildToggleControl() {
  //   return Container(
  //     decoration: BoxDecoration(
  //       gradient: LinearGradient(
  //         colors: isRoofClosed
  //             ? [Colors.greenAccent, Colors.lightGreenAccent]
  //             : [Colors.blueAccent, Colors.lightBlueAccent],
  //         begin: Alignment.topLeft,
  //         end: Alignment.bottomRight,
  //       ),
  //       borderRadius: BorderRadius.circular(8.0),
  //     ),
  //     child: ListTile(
  //       leading: Icon(
  //         isRoofClosed ? Icons.wb_sunny : Icons.cloud,
  //         color: Colors.teal[900],
  //       ),
  //       title: Text(
  //         isRoofClosed ? "Atap Terbuka" : "Atap Tertutup",
  //         style: TextStyle(color: Colors.teal[900]),
  //       ),
  //       subtitle: Text(
  //         isRoofClosed ? "Cuaca Baik" : "Cuaca Buruk",
  //         style: TextStyle(color: Colors.teal[900]),
  //       ),
  //       trailing: Switch(
  //         value: !isRoofClosed,
  //         onChanged: (value) {
  //           setState(() {
  //             isRoofClosed = !value;
  //           });
  //           sendRoofControlCommand(isRoofClosed ? "close" : "open");
  //         },
  //         activeColor: Colors.white,
  //       ),
  //     ),
  //   );
  // }
}

class ChartData {
  final DateTime time;
  final double suhu;
  final double kekeruhan;

  ChartData(this.time, this.suhu, this.kekeruhan);
}
