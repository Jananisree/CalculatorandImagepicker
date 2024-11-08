import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'Mybottombar.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp
  ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Calculator & Image Upload',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyBottomNavApp(),debugShowCheckedModeBanner: false,
    );
  }
}
