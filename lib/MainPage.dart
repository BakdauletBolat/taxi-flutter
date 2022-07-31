import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taxiflutter/pages/CreateOrderPage.dart';
import 'package:taxiflutter/pages/ProfilePage.dart';
import 'package:taxiflutter/pages/RidePage.dart';
import 'package:taxiflutter/pages/SubscriptionPage.dart';
import 'package:taxiflutter/stores/user-store.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MainPage> {
  int _selectedIndex = 0;

  void _onItemTapped(int value) {
    setState(() {
      _selectedIndex = value;
    });
  }

  static const List<Widget> _widgetOptions = <Widget>[
    CreateOrderPage(),
    // SubscriptionPage(),
    RidePage(),
    ProfilePage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0,
        enableFeedback: true,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.text_badge_plus),
            label: 'Заказать',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.car_detailed),
            label: 'Попутки',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.supervised_user_circle),
            label: 'Профиль',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
    );
  }
}
