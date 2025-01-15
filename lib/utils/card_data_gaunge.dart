import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart'; // Import Syncfusion Gauges

class CardData extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final double gaugeValue; // Nilai untuk gauge
  final VoidCallback? onTap; // Aksi onTap saat card diklik

  const CardData({
    Key? key,
    required this.title,
    required this.value,
    required this.icon,
    required this.gaugeValue, // Menambahkan parameter gaugeValue
    this.onTap, // Menambahkan onTap
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, // Pasangkan onTap ke GestureDetector
      child: Container(
        width: 150,
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8), // Mengurangi padding vertikal untuk mengurangi tinggi card
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.grey[50]!, Colors.grey[100]!],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              offset: Offset(3, 3),
              blurRadius: 9,
            ),
            BoxShadow(
              color: Colors.white.withOpacity(0.7),
              offset: Offset(-3, -3),
              blurRadius: 9,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start, // Menyusun elemen secara lebih rapat ke atas
          crossAxisAlignment: CrossAxisAlignment.center, // Menyusun elemen di tengah secara horizontal
          children: [
            // Menambahkan teks di atas gauge
            Text(
              "Suhu", // Teks di atas gauge, bisa diganti sesuai kebutuhan
              style: TextStyle(
                fontSize: 14, // Menyesuaikan ukuran font untuk mengurangi tinggi
                fontWeight: FontWeight.bold,
                color: Colors.green[800],
              ),
            ),
            SizedBox(height: 4), // Mengurangi jarak antara teks dan gauge
            // Menambahkan Radial Gauge dengan Stack
            Stack(
              alignment: Alignment.center, // Menyusun elemen di tengah
              children: [
                // Radial Gauge tanpa angka dan pointer
                SfRadialGauge(
                  axes: <RadialAxis>[
                    RadialAxis(
                      minimum: 0,
                      maximum: 100,
                      interval: 10,
                      showLabels: false, // Menonaktifkan label angka
                      showTicks: false, // Menonaktifkan ticks
                      pointers: <GaugePointer>[
                        // Tidak menambahkan NeedlePointer atau pointer lainnya
                      ],
                      annotations: <GaugeAnnotation>[ 
                        // Tidak ada anotasi (angka)
                      ],
                    ),
                  ],
                ),
                // Menambahkan ikon di tengah gauge
                Icon(
                  icon,
                  size: 30, // Mengurangi ukuran ikon untuk mengurangi tinggi card
                  color: Colors.green[800],
                ),
              ],
            ),
            SizedBox(height: 4), // Mengurangi jarak antara gauge dan nilai
            Text(
              value,
              style: TextStyle(
                fontSize: 16, // Menyesuaikan ukuran font untuk mengurangi tinggi card
                fontWeight: FontWeight.bold,
                color: Colors.grey[900],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
