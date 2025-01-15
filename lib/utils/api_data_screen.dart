import 'package:flutter/material.dart';
import 'dart:convert'; // Untuk mengolah data JSON
import 'package:http/http.dart' as http;
import 'package:syncfusion_flutter_charts/charts.dart'; // Untuk grafik
import '../../widgets/card_data.dart';

class ApiDataScreen extends StatefulWidget {
  @override
  _ApiDataScreenState createState() => _ApiDataScreenState();
}

class _ApiDataScreenState extends State<ApiDataScreen> {
  late Map<String, dynamic> latestData; // Menyimpan data terakhir (ESP1)
  late List<ChartData> suhuData = [];
  late List<ChartData> kekeruhanData = [];
  bool isLoading = true; // Untuk memantau status loading
  String errorMessage = ""; // Untuk menyimpan pesan error
  late TooltipBehavior _tooltipBehavior; // Variabel untuk Tooltip

  @override
  void initState() {
    super.initState();
    latestData = {}; // Inisialisasi dengan data kosong
    _tooltipBehavior = TooltipBehavior(enable: true); // Mengaktifkan tooltip
    fetchDataFromAPI(); // Memanggil fungsi untuk mengambil data API saat aplikasi pertama kali dijalankan
  }

  // Fungsi untuk mengambil data dari API
  Future<void> fetchDataFromAPI() async {
    final url = Uri.parse('https://usriyusron.my.id/api/fetchAPI.php'); // Ganti dengan URL API Anda
    try {
      final response = await http.get(url); // Mengambil data dari API

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body); // Mengubah data JSON menjadi Map

        // Memeriksa apakah data "sensors" ada dalam JSON
        if (jsonResponse['sensors'] != null) {
          setState(() {
            latestData = jsonResponse['sensors'].values.last; // Menyimpan data terakhir
            _processChartData(jsonResponse); // Memproses data untuk grafik
            isLoading = false; // Mengubah status loading menjadi false
          });
        } else {
          setState(() {
            errorMessage = 'Data tidak ditemukan';
            isLoading = false;
          });
        }
      } else {
        setState(() {
          errorMessage = 'Gagal mengambil data dari API';
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Error fetching data: $e';
        isLoading = false;
      });
    }
  }

  // Fungsi untuk memproses data API dan mengisi list untuk grafik
  void _processChartData(Map<String, dynamic> jsonResponse) {
    List<ChartData> suhuTempData = [];
    List<ChartData> kekeruhanTempData = [];

    jsonResponse['sensors'].forEach((key, value) {
      try {
        DateTime timestamp = DateTime.parse(value['timestamp']);
        double suhuValue = value['ESP1']['temperature-1']?.toDouble() ?? 0.0;
        double kekeruhanValue = value['ESP1']['turbidity-1']?.toDouble() ?? 0.0;

        // Menambahkan data suhu dan kekeruhan ke dalam list
        suhuTempData.add(ChartData(timestamp, suhuValue, 0.0));
        kekeruhanTempData.add(ChartData(timestamp, 0.0, kekeruhanValue));
      } catch (e) {
        print("Error processing data: $e");
      }
    });

    // Batasi hanya 20 data terakhir
    if (suhuTempData.length > 20) {
      suhuTempData = suhuTempData.take(20).toList(); // Ambil 20 data terakhir
    }

    if (kekeruhanTempData.length > 20) {
      kekeruhanTempData = kekeruhanTempData.take(20).toList(); // Ambil 20 data terakhir
    }

    setState(() {
      suhuData = suhuTempData;
      kekeruhanData = kekeruhanTempData;
    });
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
              "Smart Garden",
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
            Padding(
  padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
  child: Row(
    children: [
      Icon(
        Icons.water_drop, // Ikon yang sesuai, misalnya ikon tetesan air
        color: Colors.teal, // Warna ikon teal
        size: 20, // Ukuran ikon
      ),
      const SizedBox(width: 8), // Jarak antara ikon dan teks
      Text(
        "Status Hidroponik 1", // Teks yang ditambahkan
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.teal, // Mengatur warna teks menjadi teal
        ),
      ),
    ],
  ),
),

            // Menampilkan indikator loading saat data sedang diambil
            if (isLoading)
              Center(child: CircularProgressIndicator())
            else if (errorMessage.isNotEmpty)
              Center(child: Text(errorMessage, style: TextStyle(color: Colors.red)))
            else ...[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CardData(
                      title: "Suhu",
                      value: "${latestData['ESP1']['temperature-1']} °C",
                      icon: Icons.thermostat,
                    ),
                    CardData(
                      title: "Kekeruhan",
                      value: "${latestData['ESP1']['turbidity-1']} NTU",
                      icon: Icons.opacity,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              
              // Garis pembatas tidak full menggunakan Container
              Center(
                child: Container(
                  height: 1,
                  width: 300, // Mengatur panjang garis
                  color: Colors.grey,
                ),
              ), 

              // Rata tengah untuk 'Grafik Suhu'
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.thermostat,
                        color: Colors.green[800],
                      ),
                      SizedBox(width: 8),
                      Text(
                        "Grafik Suhu", 
                        style: TextStyle(
                          fontSize: 15, 
                          fontWeight: FontWeight.bold,
                          color: Colors.green[800],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                height: 300,
                child: SfCartesianChart(
                  tooltipBehavior: _tooltipBehavior,
                  primaryXAxis: DateTimeAxis(),
                  series: <CartesianSeries>[
                    LineSeries<ChartData, DateTime>(
                      dataSource: suhuData,
                      xValueMapper: (ChartData data, _) => data.time,
                      yValueMapper: (ChartData data, _) => data.suhu,
                      name: "Suhu",
                      color: Colors.green,
                      markerSettings: MarkerSettings(
                        isVisible: true,
                        shape: DataMarkerType.circle,
                        color: Colors.white,
                        borderWidth: 2,
                        height: 6,
                        width: 6,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20),

              // Garis pembatas tidak full setelah grafik suhu
              Center(
                child: Container(
                  height: 1,
                  width: 300, // Mengatur panjang garis
                  color: Colors.grey,
                ),
              ), 

              // Rata tengah untuk 'Grafik Kekeruhan'
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.opacity,
                        color: Colors.green[800],
                      ),
                      SizedBox(width: 8),
                      Text(
                        "Grafik Kekeruhan", 
                        style: TextStyle(
                          fontSize: 15, 
                          fontWeight: FontWeight.bold,
                          color: Colors.green[800],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                height: 300,
                child: SfCartesianChart(
                  tooltipBehavior: _tooltipBehavior,
                  primaryXAxis: DateTimeAxis(),
                  series: <CartesianSeries>[
                    LineSeries<ChartData, DateTime>(
                      dataSource: kekeruhanData,
                      xValueMapper: (ChartData data, _) => data.time,
                      yValueMapper: (ChartData data, _) => data.kekeruhan,
                      name: "Kekeruhan",
                      color: Colors.green,
                      markerSettings: MarkerSettings(
                        isVisible: true,
                        shape: DataMarkerType.circle,
                        color: Colors.white,
                        borderWidth: 2,
                        height: 6,
                        width: 6,
                      ),
                    ),
                  ],
                ),
              ),
            ]
          ],
        ),
      ),
    );
  }
}

class ChartData {
  final DateTime time;
  final double suhu;
  final double kekeruhan;

  ChartData(this.time, this.suhu, this.kekeruhan);
}
