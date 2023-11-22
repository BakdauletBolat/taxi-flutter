// ignore_for_file: file_names

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:in_app_notification/in_app_notification.dart';
import 'package:provider/provider.dart';
import 'package:taxizakaz/components/Notification.dart';

import 'package:taxizakaz/pages/MessagePage.dart';
import 'package:taxizakaz/pages/PaymentPage.dart';
import 'package:taxizakaz/pages/Profile/ProfilePage.dart';
import 'package:taxizakaz/pages/RidePage.dart';
import 'package:taxizakaz/pages/StartPage.dart';
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


  List<Widget> widgetOptions = <Widget>[
    const StartPage(),
    const RidePage(),
    const PaymentPage(),
    const ProfilePage(),
  ];

  @override
  void initState() {
    super.initState();

    UserStore userStore = Provider.of<UserStore>(context, listen: false);
  
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message.notification != null) {
        showNotification(
            message.notification!.title!, message.notification?.body);
        userStore.loadUserPayments();
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      if (message.notification != null) {
        var route = MaterialPageRoute(builder: (context)=>const MessagePage());
        Navigator.of(context).push(route);
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
      onTap: () {
        var route = MaterialPageRoute(builder: (context)=> const MessagePage());
        Navigator.of(context).push(route);
      },
    );
  }


  var items = <BottomNavigationBarItem>[
           const BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.text_badge_plus),
              label: 'Заказать',
            ),
            const BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.car_detailed),
              label: 'Попутки',
            ),
        const BottomNavigationBarItem(
              icon: Icon(Icons.payment),
              label: 'Платежи',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.supervised_user_circle),
              label: 'Профиль',
            ),
          ];
  

  @override
  void dispose() {
    super.dispose();

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          elevation: 0,
          enableFeedback: true,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Theme.of(context).primaryColor,
          unselectedItemColor: Theme.of(context).primaryColor.withOpacity(.60),
          unselectedFontSize: 14,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items:items,
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
        body: widgetOptions.elementAt(_selectedIndex));
  }
}
