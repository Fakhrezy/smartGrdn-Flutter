import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class StatsPage extends StatefulWidget {
  const StatsPage({Key? key}) : super(key: key);

  @override
  _StatsPageState createState() => _StatsPageState();
}

class _StatsPageState extends State<StatsPage> {
  final String apiUrl = 'https://usriyusron.my.id/api/avg.php';
  String selectedFilter = 'temperature-1, turbidity-1'; // Default filter

  Future<Map<String, dynamic>> fetchData() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      throw Exception('Error fetching data: $e');
    }
  }

  IconData getIconForKey(String key) {
    if (key.contains('temperature')) {
      return Icons.thermostat;
    } else if (key.contains('turbidity')) {
      return Icons.water_drop;
    }
    return Icons.device_unknown; // Default icon
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
      body: Column(
        children: [
          // Menambahkan teks 'Rata-rata perJam'
          // Menambahkan teks 'Rata-rata perJam' dengan ikon
Padding(
  padding: const EdgeInsets.all(16.0),
  child: Row(
    mainAxisAlignment: MainAxisAlignment.start, // Menempatkan konten di sebelah kiri
    children: [
      Icon(
        Icons.access_time, // Ikon yang sesuai, misalnya ikon jam
        color: Colors.teal, // Warna ikon
        size: 20, // Ukuran ikon
      ),
      const SizedBox(width: 8), // Jarak antara ikon dan teks
      Text(
        'Rata-rata perJam', // Teks yang ditambahkan
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.teal, // Anda bisa menyesuaikan warna teks
        ),
      ),
    ],
  ),
),

// Tambahkan gambar di bawah teks
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Image.asset(
              'assets/stats.jpg', // Ganti dengan path gambar Anda
              height: 300, // Tinggi gambar
              width: 300, // Lebar gambar
              fit: BoxFit.cover, // Menyesuaikan gambar dengan container
            ),
          ),

          // Dropdown Filter
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: DropdownButton<String>(
              value: selectedFilter,
              items: const [
                DropdownMenuItem(
                  value: 'temperature-1, turbidity-1',
                  child: Text('Hidroponik 1'), // Menampilkan label yang lebih ramah
                ),
                DropdownMenuItem(
                  value: 'temperature-2, turbidity-2',
                  child: Text('Hidroponik 2'), // Menampilkan label yang lebih ramah
                ),
              ],
              onChanged: (value) {
                setState(() {
                  selectedFilter = value!;
                });
              },
              isExpanded: true,
            ),
          ),
          // Data List
          Expanded(
            child: FutureBuilder<Map<String, dynamic>>(
              future: fetchData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No data available'));
                }

                final data = snapshot.data!;
                final sortedKeys = data.keys.toList()..sort(); // Sort keys in ascending order
                final reversedKeys = sortedKeys.reversed.toList(); // Reverse the order to show the latest first

                return ListView.builder(
                  itemCount: reversedKeys.length,
                  itemBuilder: (context, index) {
                    final timestamp = reversedKeys[index];
                    final values = data[timestamp] as Map<String, dynamic>;

                    // Filtered Data Based on Dropdown Selection
                    final filteredValues = values.entries.where((entry) {
                      if (selectedFilter == 'temperature-1, turbidity-1') {
                        return entry.key.contains('temperature-1') || entry.key.contains('turbidity-1');
                      } else {
                        return entry.key.contains('temperature-2') || entry.key.contains('turbidity-2');
                      }
                    }).toList();

                    // Tentukan warna box berdasarkan tipe data
                    Color cardColor = Colors.white; // Default color
                    if (filteredValues.any((entry) => entry.key.contains('temperature'))) {
                      cardColor = Colors.green[50]!; // Warna box untuk suhu
                    } else if (filteredValues.any((entry) => entry.key.contains('turbidity'))) {
                      cardColor = Colors.green[50]!; // Warna box untuk kekeruhan
                    }

                    return Card(
                      color: cardColor, // Mengatur warna box
                      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Menampilkan Timestamp dengan warna teks yang dimodifikasi
                            Text(
                              '$timestamp',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.teal[900], // Menambahkan warna biru pada teks timestamp
                              ),
                            ),
                            const SizedBox(height: 8),
                            // Menampilkan Data yang telah difilter dengan ikon di samping
                            ...filteredValues.map(
                              (entry) {
                                // Mengganti nama data ke label yang ramah
                                String label = '';
                                Color labelColor = Colors.black; // Default color for text

                                if (entry.key == 'temperature-1') {
                                  label = 'Suhu';
                                  labelColor = Colors.green; // Color for temperature
                                } else if (entry.key == 'turbidity-1') {
                                  label = 'Kekeruhan';
                                  labelColor = Colors.green; // Color for turbidity
                                } else if (entry.key == 'temperature-2') {
                                  label = 'Suhu';
                                  labelColor = Colors.green; // Color for temperature
                                } else if (entry.key == 'turbidity-2') {
                                  label = 'Kekeruhan';
                                  labelColor = Colors.green; // Color for turbidity
                                }

                                IconData icon = getIconForKey(entry.key);
                                return Row(
                                  children: [
                                    Icon(icon, size: 20, color: Colors.green),
                                    const SizedBox(width: 8),
                                    Text(
                                      '$label: ${entry.value.toStringAsFixed(2)}',
                                      style: TextStyle(fontSize: 14, color: labelColor), // Color for label text
                                    ),
                                  ],
                                );
                              },
                            ).toList(),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
