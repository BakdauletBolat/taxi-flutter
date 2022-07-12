import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taxiflutter/stores/user-store.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
        tabBar: CupertinoTabBar(
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
              icon: Icon(CupertinoIcons.list_bullet),
              label: 'Мой заказы',
            ),
          ],
        ),
        tabBuilder: (context, index) {
          late final CupertinoTabView returnValue;
          switch (index) {
            case 0:
              returnValue = CupertinoTabView(
                builder: (context) => CupertinoPageScaffold(
                    navigationBar: CupertinoNavigationBar(
                      trailing: CupertinoButton(
                        padding: const EdgeInsets.all(0),
                        onPressed: () {
                          UserStore userStore =
                              Provider.of<UserStore>(context, listen: false);
                          userStore.logout();
                        },
                        child: const Icon(
                          CupertinoIcons.share,
                          size: 22,
                        ),
                      ),
                      middle: const Text('Межгород'),
                    ),
                    child: const Center(
                      child: Text('Заказать'),
                    )),
              );
              break;
            case 1:
              returnValue = CupertinoTabView(
                builder: (context) => const CupertinoPageScaffold(
                    child: Center(
                  child: Text('Попутки'),
                )),
              );
              break;
            case 2:
              returnValue = CupertinoTabView(
                builder: (context) => const CupertinoPageScaffold(
                    child: Center(
                  child: Text('Мой заказы'),
                )),
              );
              break;
          }

          return returnValue;
        });
  }
}
