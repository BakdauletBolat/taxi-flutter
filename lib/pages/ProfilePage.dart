import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:taxiflutter/components/BAppBar.dart';
import 'package:taxiflutter/pages/ProfileEditPage.dart';
import 'package:taxiflutter/pages/RequestDriverPage.dart';
import 'package:taxiflutter/stores/user-store.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    UserStore userStore = Provider.of<UserStore>(context, listen: false);
    return Scaffold(
        backgroundColor: Colors.white24,
        extendBodyBehindAppBar: true,
        appBar: const BAppBar(title: 'Профиль', type: 'transparent'),
        body: SingleChildScrollView(
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
                  Positioned(
                    top: 129,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(142),
                      child: Observer(builder: (context) {
                        return ExtendedImage.network(
                          userStore.profile?.profile_info?.avatar ??
                              'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8bWVufGVufDB8fDB8fA%3D%3D&w=1000&q=80',
                          width: 142,
                          height: 142,
                          fit: BoxFit.cover,
                        );
                      }),
                    ),
                  ),
                  Positioned(
                      bottom: 20,
                      child: CupertinoButton.filled(
                          child: Text('Изменить данные'),
                          onPressed: () {
                            var route = CupertinoPageRoute(builder: (context) {
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
                          userStore.profile?.phone ?? 'Телеофон не указано'),
                      title: const Text('Телеофон'),
                    ),
                    ListTile(
                      subtitle: Text(
                          userStore.profile?.profile_info?.first_name ??
                              'Имя не указано'),
                      title: const Text('Имя'),
                    ),
                    ListTile(
                      subtitle: Text(
                          userStore.profile?.profile_info?.last_name ??
                              'Фамилия не указано'),
                      title: const Text('Фамилия'),
                    ),
                    ListTile(
                      subtitle: Text(userStore.profile?.profile_info?.email ??
                          'Почта не указано'),
                      title: const Text('Почта'),
                    ),
                    ListTile(
                      title: CupertinoButton.filled(
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
                            var route = CupertinoPageRoute(builder: (context) {
                              return const RequestDriverPage();
                            });
                            Navigator.of(context).push(route);
                          }),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                  ],
                ),
              );
            })
          ],
        )));
  }
}
