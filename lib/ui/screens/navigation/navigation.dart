import 'package:book_shelf/constants/colors.dart';
import 'package:book_shelf/constants/config.dart';
import 'package:book_shelf/ui/screens/home/homePage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Config appConfig;

class Navigation extends StatefulWidget {
  @override
  _NavigationState createState() => _NavigationState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _NavigationState extends State<Navigation> {
  int _selectedIndex = 0;
  static List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    HomePage(),
    HomePage()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    appConfig = Config(context);
    return WillPopScope(
      onWillPop: () {
        print("I am Nav");
      },
      child: Scaffold(
        backgroundColor: Colors.black26,
        body: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.white,
          elevation: 10,
          type: BottomNavigationBarType.fixed,
          iconSize: 30,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.home),
                title: SizedBox(
                  height: 0.1,
                )),
            BottomNavigationBarItem(
                icon: Icon(Icons.notifications),
                title: SizedBox(
                  height: 0.1,
                )),
            BottomNavigationBarItem(
                icon: Icon(Icons.person),
                title: SizedBox(
                  height: 0.1,
                ))
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: AppColors.secondaryDark,
          unselectedItemColor: Colors.grey[400],
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
