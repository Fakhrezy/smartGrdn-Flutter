import 'package:flutter/material.dart';

class TeamPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> teamMembers = [
      {'nama': 'Zahra Cahya Dewi S', 'nrp': '152022131', 'role': 'Produk', 'icon': 'person'},
      {'nama': 'Muhamad Usri Yusron', 'nrp': '152022132', 'role': 'Mekatronika', 'icon': 'person'},
      {'nama': 'Baraja Barsya', 'nrp': '152022137', 'role': 'Produk', 'icon': 'person'},
      {'nama': 'Gumiwang Maysa Nusi', 'nrp': '152022142', 'role': 'Produk', 'icon': 'person'},
      {'nama': 'Ambar Wulandara', 'nrp': '152022149', 'role': 'Backend', 'icon': 'person'},
      {'nama': 'Irna Rahma U', 'nrp': '152022155', 'role': 'Website', 'icon': 'person'},
      {'nama': 'Tri Sartika R', 'nrp': '152022157', 'role': 'Mekatronika', 'icon': 'person'},
      {'nama': 'Risha Marcella', 'nrp': '152022172', 'role': 'Mekatronika', 'icon': 'person'},
      {'nama': 'Deden Fahrul', 'nrp': '152022182', 'role': 'Mobile', 'icon': 'person'},
      {'nama': 'R Jayani Maulana S', 'nrp': '152022250', 'role': 'Produk', 'icon': 'person'},
    ];

    return Scaffold(
      backgroundColor: Colors.white, // Menambahkan background putih pada seluruh Scaffold
      appBar: AppBar(
        title: Row(
          children: [
            SizedBox(width: 8),
            Text(
              "Smart Hydroponic",
              style: TextStyle(
                color: Colors.black,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            Icon(
              Icons.eco,
              color: Colors.green,
            ),
          ],
        ),
        backgroundColor: Colors.white, // AppBar tetap putih
        elevation: 0,
      ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            backgroundColor: Colors.white, // SliverAppBar tetap putih
            title: Row(
              children: [
                Icon(
                  Icons.group, // Ikon untuk "Our Team"
                  color: Colors.teal,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  'Our Team',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal,
                  ),
                ),
              ],
            ),
            elevation: 0,
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  'assets/team.jpg', // Path ke gambar lokal Anda
                  height: 250,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SliverGrid(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final member = teamMembers[index];
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      gradient: LinearGradient(
                        colors: [Colors.greenAccent, Colors.lightGreenAccent], // Gradasi warna
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.teal[900],
                            radius: 30,
                            child: Icon(
                              _getIconFornama(member['icon']!),
                              size: 30,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            member['nama']!,
                            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.teal[900]),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 4),
                          Text(
                            member['nrp']!,
                            style: TextStyle(fontSize: 12, color: Colors.green),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 4),
                          Text(
                            member['role']!,
                            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.teal[900]),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
              childCount: teamMembers.length,
            ),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 5.0,
              mainAxisSpacing: 5.0,
            ),
          ),
        ],
      ),
    );
  }

  IconData _getIconFornama(String iconnama) {
    switch (iconnama) {
      case 'person':
        return Icons.person;
      case 'account_circle':
        return Icons.account_circle;
      default:
        return Icons.help_outline;
    }
  }
}
