import 'package:calculatorandimagepicker/GetxPage.dart';
import 'package:calculatorandimagepicker/Providercalculator.dart';
import 'package:calculatorandimagepicker/Upload.dart';
import 'package:flutter/material.dart';

class MyBottomNavApp extends StatefulWidget {
  @override
  _MyBottomNavAppState createState() => _MyBottomNavAppState();
}

class _MyBottomNavAppState extends State<MyBottomNavApp> {
  final ValueNotifier<int> _selectedIndex = ValueNotifier<int>(0);

  void _onItemTapped(int index) {
    _selectedIndex.value = index;
  }

  @override
  void dispose() {
    _selectedIndex.dispose();
    super.dispose();
  }

  final List<Widget> _pages = [
    Providercalculator(),
    GetxPage(),
    Upload(),
  ];

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;


    bool isWideScreen = screenWidth > 400;


    // Dynamically adjust bottom navigation height based on screen size
    double bottomNavBarHeight = isWideScreen ? 80.0 : 130.0;

    double bottomNavPadding = MediaQuery.of(context).padding.bottom;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ValueListenableBuilder<int>(
            valueListenable: _selectedIndex,
            builder: (context, value, child) {
              return _pages[value];
            },
          ),
        ),
      ),
      bottomNavigationBar: ValueListenableBuilder<int>(
        valueListenable: _selectedIndex,
        builder: (context, value, child) {
          return Container(
            padding: EdgeInsets.only(bottom: bottomNavPadding), // Ensures space for system UI
            height: bottomNavBarHeight, // Adjusts based on screen size
            decoration: BoxDecoration(
              color: Color(0xffF5F5F5),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(isWideScreen ? 30.0 : 20.0),
                topRight: Radius.circular(isWideScreen ? 30.0 : 20.0),
              ),
            ),
            child: BottomNavigationBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home_outlined,
                    color: value == 0 ? Colors.blue[800] : Colors.black,
                  ),
                  label: 'Provider',
                ),
                BottomNavigationBarItem(
                  icon: Text(
                    'ஃ',
                    style: TextStyle(
                      fontSize: isWideScreen ? 30 : 24,
                      color: value == 1 ? Colors.blue[800] : Colors.black,
                    ),
                  ),
                  label: "GetX",
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.image_outlined,
                    color: value == 2 ? Colors.blue[800] : Colors.black,
                  ),
                  label: 'Upload',
                ),
              ],
              currentIndex: value,
              selectedItemColor: Colors.blue[800],
              unselectedItemColor: Colors.black,
              onTap: _onItemTapped,
            ),
          );
        },
      ),
    );
  }
}
