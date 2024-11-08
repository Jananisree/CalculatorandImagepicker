import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:device_preview/device_preview.dart'; // Import the device preview package
import 'Mybottombar.dart'; // Your custom bottom navigation app

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp
  ]); // Locks the app to portrait mode

  runApp(
    DevicePreview(
      enabled: true, // Set to false in production to disable the preview
      tools: const [
        ...DevicePreview.defaultTools, // Default set of tools
        // Add custom plugins here if needed
      ],
      builder: (context) => const MyApp(), // Your app widget
    ),
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
      locale: DevicePreview.locale(context), // This ensures the locale is correct in preview mode
      builder: DevicePreview.appBuilder, // Ensures the preview works across the app
    );
  }
}
