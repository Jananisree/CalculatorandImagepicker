import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'Mybottombar.dart'; // Your custom bottom navigation app

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp
  ]); // Locks the app to portrait mode

  runApp(
   const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Calculator & Image Upload',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyBottomNavApp(), // Your custom bottom navigation app
      debugShowCheckedModeBanner: false, // Disables the debug banner
    );
  }
}
