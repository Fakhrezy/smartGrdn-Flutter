import 'package:flutter/material.dart';

class ControllingPage extends StatefulWidget {
  @override
  _ControllingPageState createState() => _ControllingPageState();
}

class _ControllingPageState extends State<ControllingPage> {
  bool isRainy = true; // Status cuaca (hujan/cerah)
  bool isPumpOn = false; // Status pompa (mati/otomatis)

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Controlling"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Box untuk cuaca
            _buildStatusBox(
              title: isRainy ? "Atap Tertutup" : "Atap Terbuka",
              subtitle: isRainy ? "Cuaca buruk" : "Cuaca baik",
              isActive: !isRainy,
              icon: isRainy ? Icons.cloud : Icons.wb_sunny,
              activeColor: Colors.orangeAccent,
              inactiveColor: Colors.lightBlueAccent,
              onToggle: (value) {
                setState(() {
                  isRainy = !value;
                });
              },
            ),
            SizedBox(height: 16),
            // Box untuk pompa
            _buildStatusBox(
              title: "Pompa",
              subtitle: isPumpOn ? "Otomatis" : "Mati",
              isActive: isPumpOn,
              icon: Icons.water_drop,
              activeColor: Colors.cyanAccent,
              inactiveColor: Colors.tealAccent,
              onToggle: (value) {
                setState(() {
                  isPumpOn = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusBox({
    required String title,
    required String subtitle,
    required bool isActive,
    required IconData icon,
    required Color activeColor,
    required Color inactiveColor,
    required ValueChanged<bool> onToggle,
  }) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isActive
              ? [Colors.blueAccent, Colors.lightBlueAccent]
              : [Colors.lightGreenAccent, Colors.greenAccent],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: ListTile(
        leading: Icon(icon, color: isActive ? Colors.white : Colors.teal[900]),
        title: Text(
          title,
          style: TextStyle(
            color: isActive ? Colors.white : Colors.teal[900],
          ),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(
            color: isActive ? Colors.white70 : Colors.black54,
          ),
        ),
        trailing: Switch(
          value: isActive,
          onChanged: onToggle,
          activeColor: Colors.white,
        ),
      ),
    );
  }
}
