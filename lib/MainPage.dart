// ignore_for_file: file_names

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:in_app_notification/in_app_notification.dart';
import 'package:provider/provider.dart';
import 'package:taxizakaz/components/Notification.dart';
import 'package:taxizakaz/pages/CreateOrderPage.dart';
import 'package:taxizakaz/pages/PaymentPage.dart';
import 'package:taxizakaz/pages/ProfilePage.dart';
import 'package:taxizakaz/pages/RidePage.dart';
import 'package:taxizakaz/stores/user-store.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MainPage> {
  int _selectedIndex = 0;
  late FToast fToast;

  void _onItemTapped(int value) {
    setState(() {
      _selectedIndex = value;
    });
  }

  @override
  void initState() {
    super.initState();

    UserStore userStore = Provider.of<UserStore>(context, listen: false);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Message data: ${message.data}');

      if (message.notification != null) {
        showNotification(
            message.notification!.title!, message.notification?.body);

        userStore.loadUserPayments();
      }
    });
  }

  showNotification(String title, String? desctiption) {
    InAppNotification.show(
      child: NotificationComponent(
        title: title,
        description: desctiption,
      ),
      duration: const Duration(seconds: 2),
      context: context,
      onTap: () => print('Notification tapped!'),
    );
  }

  static const List<Widget> _widgetOptions = <Widget>[
    CreateOrderPage(),
    RidePage(),
    ProfilePage(),
    PaymentPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0,
        enableFeedback: true,
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Theme.of(context).primaryColor,
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
          BottomNavigationBarItem(
            icon: Icon(Icons.payment),
            label: 'Платежи',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
    );
  }
}
