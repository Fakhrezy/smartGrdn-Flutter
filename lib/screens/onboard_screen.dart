import 'package:flutter/material.dart';
import 'main_screen.dart'; // Pastikan Anda mengimpor halaman utama

class OnboardScreen extends StatefulWidget {
  @override
  State<OnboardScreen> createState() => _OnboardScreenState();
}

// Model untuk data onboarding
class AllinOnboardModel {
  final String imgStr;
  final String description;
  final String titlestr;

  AllinOnboardModel(this.imgStr, this.description, this.titlestr);
}

// Warna dan konstanta
const Color lightgreenshede = Color(0xFFF0FAF6);
const Color lightgreenshede1 = Color(0xFFB2D9CC);
const Color primarygreen = Color(0xFF1E3A34);
const Duration kAnimationDuration = Duration(milliseconds: 200);

class _OnboardScreenState extends State<OnboardScreen> {
  int currentIndex = 0;
  late PageController _pageController;

  final List<AllinOnboardModel> allinonboardlist = [
    AllinOnboardModel(
      "assets/splash.jpg",
      "Halo, Selamat Datang di Aplikasi Smart Garden!",
      "Greetings",
    ),
    AllinOnboardModel(
      "assets/smart.jpg",
      "Aplikasi ini dibuat untuk membantu memantau dan mengontrol kebun hidroponik",
      "About",
    ),
    AllinOnboardModel(
      "assets/enjoy.jpg",
      "Selamat menggunakan!",
      "Enjoy",
    ),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          " ",
          style: TextStyle(color: primarygreen),
        ),
        backgroundColor: lightgreenshede,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            onPageChanged: (value) {
              setState(() {
                currentIndex = value;
              });
            },
            itemCount: allinonboardlist.length,
            itemBuilder: (context, index) {
              return PageBuilderWidget(
                title: allinonboardlist[index].titlestr,
                description: allinonboardlist[index].description,
                imgurl: allinonboardlist[index].imgStr,
              );
            },
          ),
          Positioned(
            bottom: MediaQuery.of(context).size.height * 0.3,
            left: MediaQuery.of(context).size.width * 0.44,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                allinonboardlist.length,
                (index) => buildDot(index: index),
              ),
            ),
          ),
          // Tombol tetap di bawah layar dan tidak ikut bergerak
          Positioned(
            bottom: 80, // Menentukan jarak dari bagian bawah layar
            left: 0, // Untuk mengatur tombol agar berada di tengah horizontal
            right: 0, // Menjamin tombol tetap terletak di tengah
            child: Center(
              child: ElevatedButton(
                onPressed: () {
                  if (currentIndex < allinonboardlist.length - 1) {
                    _pageController.nextPage(
                      duration: kAnimationDuration,
                      curve: Curves.easeInOut,
                    );
                  } else {
                    // Navigasi ke MainScreen setelah proses onboarding selesai
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => MainScreen()), // Ganti MainScreen dengan nama layar utama Anda
                    );
                  }
                },
                child: Text(
                  currentIndex == allinonboardlist.length - 1
                      ? "Mulai"
                      : "Lanjut",
                  style: const TextStyle(fontSize: 18, color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: primarygreen,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  AnimatedContainer buildDot({int? index}) {
    return AnimatedContainer(
      duration: kAnimationDuration,
      margin: const EdgeInsets.only(right: 5),
      height: 6,
      width: currentIndex == index ? 20 : 6,
      decoration: BoxDecoration(
        color: currentIndex == index ? primarygreen : const Color(0xFFD8D8D8),
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}

class PageBuilderWidget extends StatelessWidget {
  final String title;
  final String description;
  final String imgurl;

  const PageBuilderWidget({
    Key? key,
    required this.title,
    required this.description,
    required this.imgurl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,  // Menambahkan ini untuk memastikan konten di tengah secara vertikal
        crossAxisAlignment: CrossAxisAlignment.center,  // Menjaga agar konten tetap rata tengah secara horizontal
        children: [
          Container(
            margin: const EdgeInsets.only(top: 20),
            child: Image.asset(
              imgurl,
              height: 250,  // Menentukan tinggi gambar
              width: MediaQuery.of(context).size.width * 0.8,  // Menentukan lebar gambar (80% dari lebar layar)
              fit: BoxFit.cover, // Menyesuaikan gambar dengan mempertahankan aspek rasio
            ),
          ),
          const SizedBox(height: 20),
          Text(
            title,
            textAlign: TextAlign.center,  // Menambahkan textAlign untuk memastikan judul berada di tengah
            style: const TextStyle(
              color: primarygreen,
              fontSize: 30,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            description,
            textAlign: TextAlign.center,  // Menambahkan textAlign untuk memastikan deskripsi berada di tengah
            style: const TextStyle(
              color: primarygreen,
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }
}

