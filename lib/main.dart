import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:in_app_notification/in_app_notification.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:taxizakaz/WelcomePage.dart';
import 'package:taxizakaz/pages/Auth/VerifyUserPage.dart';
import 'package:taxizakaz/stores/create-order-store.dart';
import 'package:taxizakaz/stores/order-store.dart';
import 'package:taxizakaz/stores/region-store.dart';
import 'package:taxizakaz/stores/user-store.dart';
import 'MainPage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Map<int, Color> color = const {
  50: Color.fromRGBO(4, 131, 184, .1),
  100: Color.fromRGBO(4, 131, 184, .2),
  200: Color.fromRGBO(4, 131, 184, .3),
  300: Color.fromRGBO(4, 131, 184, .4),
  400: Color.fromRGBO(4, 131, 184, .5),
  500: Color.fromRGBO(4, 131, 184, .6),
  600: Color.fromRGBO(4, 131, 184, .7),
  700: Color.fromRGBO(4, 131, 184, .8),
  800: Color.fromRGBO(4, 131, 184, .9),
  900: Color.fromRGBO(4, 131, 184, 1),
};

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseMessaging messaging = FirebaseMessaging.instance;

  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  runApp(MultiProvider(
    providers: [
      Provider(create: (_) => UserStore()),
      Provider(create: (_) => RegionStore()),
      Provider(create: (_) => OrderStore()),
      Provider(create: (_) => CreateOrderStore())
    ],
    child: const TaxiApp(),
  ));
}

class TaxiApp extends StatefulWidget {
  const TaxiApp({Key? key}) : super(key: key);

  @override
  State<TaxiApp> createState() => _TaxiAppState();
}

class _TaxiAppState extends State<TaxiApp> {
  @override
  void initState() {
    loadUser();
    super.initState();
  }

  void loadUser() async {
    UserStore userStore = Provider.of<UserStore>(context, listen: false);
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    String? token = await messaging.getToken();
    userStore.loadUser(token: token);
  }

  @override
  Widget build(BuildContext context) {
    return InAppNotification(
      child: MaterialApp(
        initialRoute: '/',
        theme: ThemeData(
            primarySwatch: MaterialColor(0xFF14224a, color),
            primaryColor: const Color(0xFF14224a)),
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case '/':
              return MaterialWithModalsPageRoute(
                  builder: (_) => Observer(builder: (context) {
                        UserStore userStore = Provider.of<UserStore>(context);
                        if (userStore.isAuth) {
                          return const MainPage();
                        }
                        return const WelcomePage();
                      }),
                  settings: settings);
            case '/verify-user':
              return MaterialWithModalsPageRoute(
                builder: (context) => const VerifyPage(),
              );
          }
          return null;
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
