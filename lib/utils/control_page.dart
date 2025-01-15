import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ControlServoPage extends StatefulWidget {
  @override
  _ControlServoPageState createState() => _ControlServoPageState();
}

class _ControlServoPageState extends State<ControlServoPage> {
  final String esp32Url = "http://192.168.1.64"; // Ganti dengan IP ESP32 Anda 1.58
  double _currentAngle = 90;

  // Fungsi untuk mengirim perintah sudut servo
  Future<void> sendServoAngle(int angle) async {
    final url = Uri.parse('$esp32Url/?angle=$angle');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        print("Servo berhasil diatur ke $angle°");
      } else {
        print("Gagal mengatur servo: ${response.statusCode}");
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kontrol Servo ESP32'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Posisi Servo: ${_currentAngle.toInt()}°",
            style: TextStyle(fontSize: 20),
          ),
          Slider(
            value: _currentAngle,
            min: 0,
            max: 180,
            divisions: 180,
            label: "${_currentAngle.toInt()}°",
            onChanged: (value) {
              setState(() {
                _currentAngle = value;
              });
            },
            onChangeEnd: (value) {
              sendServoAngle(value.toInt());
            },
          ),
        ],
      ),
    );
  }
}
