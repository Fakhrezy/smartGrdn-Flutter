import 'package:flutter/material.dart';

class StatusCard extends StatelessWidget {
  final String title;
  // final String value;
  final IconData icon;
  final double width;
  final double height;

  const StatusCard({
    required this.title,
    // required this.value,
    required this.icon,
    this.width = 150, // Lebar default diperbesar
    this.height = 150, // Tinggi default diperbesar
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.lightGreenAccent,  Colors.greenAccent], // Warna gradient diperbesar
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 40, color: Colors.teal[900]), // Ikon diperbesar
          SizedBox(height: 5),
          Text(title, style: TextStyle(fontSize: 17, color: Colors.teal[900])), // Font diperbesar
          // Text(value, style: TextStyle(fontSize: 20, color: Colors.teal[900])), // Font diperbesar
        ],
      ),
    );
  }
}
