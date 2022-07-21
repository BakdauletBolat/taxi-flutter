import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:taxiflutter/WelcomePage.dart';
import 'package:taxiflutter/pages/CreateOrderPage.dart';
import 'package:taxiflutter/pages/VerifyUserPage.dart';
import 'package:taxiflutter/stores/region-store.dart';
import 'package:taxiflutter/stores/user-store.dart';
import 'MainPage.dart';

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

void main() {
  runApp(MultiProvider(
    providers: [
      Provider(create: (_) => UserStore()),
      Provider(create: (_) => RegionStore())
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
    UserStore userStore = Provider.of<UserStore>(context, listen: false);
    userStore.loadUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
              builder: (context) => VerifyPage(),
            );
        }
        return null;
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
