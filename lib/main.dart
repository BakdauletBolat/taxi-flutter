import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import 'package:taxiflutter/WelcomePage.dart';
import 'package:taxiflutter/stores/user-store.dart';
import 'MainPage.dart';

void main() {
  runApp(MultiProvider(
    providers: [Provider(create: (_) => UserStore())],
    child: const TaxiApp(),
  ));
}

class TaxiApp extends StatelessWidget {
  const TaxiApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: 'Flutter Demo',
      theme: const CupertinoThemeData(
        primaryColor: Color.fromRGBO(0, 175, 202, 1),
        barBackgroundColor: Colors.white,
      ),
      home: Observer(builder: (context) {
        UserStore userStore = Provider.of<UserStore>(context);

        if (userStore.isAuth) {
          return const MainPage();
        }

        return const WelcomePage();
      }),
    );
  }
}
