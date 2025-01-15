import 'package:flutter/material.dart';
// import 'package:smartgarden_app/api_data_screen.dart';
import 'package:smartgarden_app/screens/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

// import 'bottom_navigation.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(SmartGardenApp());
}

class SmartGardenApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Hydroponic',
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SplashScreen(),
      // home: ApiDataScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
