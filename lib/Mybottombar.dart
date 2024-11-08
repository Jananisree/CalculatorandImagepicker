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
      bottomNavigationBar: SafeArea(
        child: ValueListenableBuilder<int>(
          valueListenable: _selectedIndex,
          builder: (context, value, child) {
            return Container(
              height: 75,
              decoration: BoxDecoration(
                color: Color(0xffF5F5F5),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
              ),
              child: BottomNavigationBar(
                backgroundColor: Colors.transparent, // Keeps the color set by Container
                elevation: 0, // Removes shadow for a cleaner look
                items: <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.home_outlined,
                      color: value == 0 ? Colors.blue[800] : Colors.black, // Selected color blue
                    ),
                    label: 'Provider',
                  ),
                  BottomNavigationBarItem(
                    icon: Text(
                      'ஃ',
                      style: TextStyle(
                        fontSize: 18,fontWeight: FontWeight.bold,
                        color: value == 1 ? Colors.blue[800] : Colors.black, // Dynamically change color
                      ),
                    ),
                    label: "GetX",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.image_outlined,
                      color: value == 2 ? Colors.blue[800] : Colors.black, // Selected color blue
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
      ),
    );
  }
}
