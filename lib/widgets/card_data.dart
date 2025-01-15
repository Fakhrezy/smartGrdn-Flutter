import 'package:flutter/material.dart';

class CardData extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final VoidCallback? onTap; // Tambahkan parameter onTap untuk aksi klik

  const CardData({
    Key? key,
    required this.title,
    required this.value,
    required this.icon,
    this.onTap, // Tambahkan ini ke konstruktor
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector( // Gunakan GestureDetector untuk mendukung onTap
      onTap: onTap, // Pasangkan onTap ke GestureDetector
      child: Container(
        width: 150,
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.grey[50]!, Colors.grey[100]!],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            // Efek bayangan emboss - memberikan kesan terangkat dan tertekan
            BoxShadow(
              color: Colors.black.withOpacity(0.2), // Bayangan lebih gelap untuk bagian bawah
              offset: Offset(3, 3), // Posisi bayangan (ke bawah dan kanan)
              blurRadius: 9,
            ),
            BoxShadow(
              color: Colors.white.withOpacity(0.7), // Bayangan terang untuk bagian atas
              offset: Offset(-3, -3), // Posisi bayangan (ke atas dan kiri)
              blurRadius: 9,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: Colors.green[800]),
            SizedBox(height: 10),
            Text(
              title,
              style: TextStyle(fontSize: 16, color: Colors.green[800]),
            ),
            SizedBox(height: 5),
            Text(
              value,
              style: TextStyle(
                fontSize: 20,
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
