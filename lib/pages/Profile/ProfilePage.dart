// ignore_for_file: file_names

import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:taxizakaz/components/BAppBar.dart';
import 'package:taxizakaz/components/ProfileImage.dart';
import 'package:taxizakaz/dialogs/ExitDialog.dart';
import 'package:taxizakaz/hooks/showSnackBar.dart';
import 'package:taxizakaz/pages/PreviewDocumentsPage.dart';
import 'package:taxizakaz/pages/Profile/ProfileEditPage.dart';
import 'package:taxizakaz/pages/Profile/RequestDriverPage.dart';
import 'package:taxizakaz/stores/user-store.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  void onLogoutClicked() {
    showCupertinoDialog(
        context: context, builder: (context) => const ExitDialog());
  }

  @override
  Widget build(BuildContext context) {
    UserStore userStore = Provider.of<UserStore>(context, listen: false);

    Widget renderTypeUser() {
      if (userStore.user?.type_user != null) {
        if (userStore.user!.type_user! == 2) {
          return const Text('Пассажир');
        } else if (userStore.user!.type_user! == 1) {
          return const Text('Водитель');
        }
      }

      return const Text('');
    }

    return Scaffold(
        backgroundColor: Colors.white24,
        extendBodyBehindAppBar: true,
        appBar: BAppBar(
          title: 'Профиль',
          actions: [
            IconButton(
                onPressed: onLogoutClicked, icon: const Icon(Icons.exit_to_app))
          ],
        ),
        body: RefreshIndicator(
          key: _refreshIndicatorKey,
          onRefresh: userStore.loadUser,
          child: SingleChildScrollView(
              child: Column(
            children: [
              Container(
                height: 350,
                width: MediaQuery.of(context).size.width,
                color: Colors.white,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Positioned(
                        top: 0,
                        child: Container(
                            height: 200,
                            width: MediaQuery.of(context).size.width,
                            color: Theme.of(context).primaryColor)),
                    const Positioned(top: 129, child: ProfileImage()),
                    Positioned(
                        bottom: 20,
                        child: CupertinoButton.filled(
                            child: const Text('Изменить данные'),
                            onPressed: () {
                              var route =
                                  CupertinoPageRoute(builder: (context) {
                                return const ProfileEditPage();
                              });
                              Navigator.of(context).push(route);
                            }))
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Observer(builder: (context) {
                return Container(
                  color: Colors.white,
                  child: Column(
                    children: [
                      ListTile(
                        subtitle: Text(
                            '${userStore.user?.coins?.toString()} (${userStore.user?.coins_expected?.toString()})'),
                        title: const Text('Баланс'),
                      ),
                      ListTile(
                        subtitle: renderTypeUser(),
                        title: const Text('Тип аккаунта'),
                      ),
                      ListTile(
                        subtitle: Text(
                            userStore.user?.phone ?? 'Телеофон не указано'),
                        title: const Text('Телефон'),
                      ),
                      ListTile(
                        subtitle: Text(userStore.user?.user_info?.first_name ??
                            'Имя не указано'),
                        title: const Text('Имя'),
                      ),
                      ListTile(
                        subtitle: Text(userStore.user?.user_info?.last_name ??
                            'Фамилия не указано'),
                        title: const Text('Фамилия'),
                      ),
                      ListTile(
                        subtitle: Text(userStore.user?.user_info?.email ??
                            'Почта не указано'),
                        title: const Text('Почта'),
                      ),
                      Builder(builder: (context) {
                        if (userStore.user?.is_driver != null ||
                            userStore.user!.is_driver!) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Column(
                              children: [
                                CupertinoButton.filled(
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: const [
                                          Icon(Icons.document_scanner_outlined),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text('Смотреть документы')
                                        ]),
                                    onPressed: () {
                                      var route = CupertinoPageRoute(
                                          builder: (context) {
                                        return const PreviewDocumentsPage();
                                      });
                                      Navigator.of(context).push(route);
                                    }),
                                const SizedBox(
                                  height: 10,
                                ),
                                CupertinoButton(
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: const [
                                          Icon(Icons.supervised_user_circle,
                                              color: CupertinoColors.systemRed),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            'Сменить аккаунт',
                                            style: TextStyle(
                                                color:
                                                    CupertinoColors.systemRed),
                                          )
                                        ]),
                                    onPressed: () {
                                      userStore.changeUserType();
                                      showSuccessSnackBar(context,
                                          'Изменился тип пользователя');
                                    })
                              ],
                            ),
                          );
                        }
                        return CupertinoButton.filled(
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Icon(Icons.drive_eta_rounded),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text('Стать водителям')
                                ]),
                            onPressed: () {
                              var route =
                                  CupertinoPageRoute(builder: (context) {
                                return const RequestDriverPage();
                              });
                              Navigator.of(context).push(route);
                            });
                      }),
                      const SizedBox(
                        height: 50,
                      ),
                    ],
                  ),
                );
              })
            ],
          )),
        ));
  }
}
