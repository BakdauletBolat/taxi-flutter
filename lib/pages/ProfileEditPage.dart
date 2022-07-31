// ignore_for_file: non_constant_identifier_names

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:extended_image/extended_image.dart' as Ex;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:sticky_headers/sticky_headers.dart';
import 'package:taxiflutter/components/BAppBar.dart';
import 'package:taxiflutter/components/StickyErrorHeader.dart';
import 'package:taxiflutter/models/profile-model.dart';
import 'package:taxiflutter/stores/user-store.dart';

class ProfileEditPage extends StatefulWidget {
  const ProfileEditPage({Key? key}) : super(key: key);

  @override
  State<ProfileEditPage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfileEditPage> {
  final ImagePicker _picker = ImagePicker();

  XFile? avatar;
  MultipartFile? avatar_form;

  TextEditingController? first_name_controller,
      last_name_controller,
      email_controller;

  void pickImage() async {
    XFile? avatar_not_state =
        await _picker.pickImage(source: ImageSource.gallery);
    avatar_form = await MultipartFile.fromFile(
        File(avatar_not_state!.path).path,
        filename: avatar_not_state.name);
    setState(() {
      avatar = avatar_not_state;
    });
  }

  Widget _renderImage() {
    if (avatar != null) {
      return Image.file(
        File(avatar!.path),
        width: 142,
        height: 142,
        fit: BoxFit.cover,
      );
    }

    return Observer(builder: (context) {
      UserStore userStore = Provider.of<UserStore>(context, listen: false);
      return Ex.ExtendedImage.network(
        userStore.profile?.profile_info?.avatar ??
            'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8bWVufGVufDB8fDB8fA%3D%3D&w=1000&q=80',
        width: 142,
        height: 142,
        fit: BoxFit.cover,
      );
    });
  }

  @override
  void initState() {
    UserStore userStore = Provider.of<UserStore>(context, listen: false);

    first_name_controller = TextEditingController(
        text: userStore.profile?.profile_info?.first_name);
    last_name_controller =
        TextEditingController(text: userStore.profile?.profile_info?.last_name);
    email_controller =
        TextEditingController(text: userStore.profile?.profile_info?.email);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    UserStore userStore = Provider.of<UserStore>(context, listen: false);
    return Scaffold(
        backgroundColor: Colors.white,
        extendBodyBehindAppBar: true,
        appBar: const BAppBar(title: 'Изменение профиля', type: 'transparent'),
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
                          child: _renderImage()),
                    ),
                    Positioned(
                        bottom: 20,
                        child: CupertinoButton.filled(
                          onPressed: pickImage,
                          child: const Text('Изменить фото'),
                        ))
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                color: Colors.white,
                child: Column(
                  children: [
                    Observer(builder: (context) {
                      return StickyErrorHeader(
                          error: userStore.errorUpdateInfo);
                    }),
                    ListTile(
                      subtitle: Text(
                          userStore.profile?.phone ?? 'Телеофон не указано'),
                      title: const Text('Телеофон'),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: CupertinoTextField.borderless(
                        controller: first_name_controller,
                        placeholder: 'Укажите имя',
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: CupertinoTextField.borderless(
                        controller: last_name_controller,
                        placeholder: 'Укажите фамилия',
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: CupertinoTextField.borderless(
                        controller: email_controller,
                        placeholder: 'Укажите почту',
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          children: [
                            Expanded(
                              child: CupertinoButton.filled(
                                onPressed: () async {
                                  await userStore.updateUserInfo(
                                      ProfileInfoCreate(
                                          email: email_controller?.text,
                                          avatar: avatar_form,
                                          first_name:
                                              first_name_controller?.text,
                                          last_name:
                                              last_name_controller?.text));

                                  if (userStore.errorUpdateInfo == null) {
                                    Navigator.of(context).pop();
                                  }
                                },
                                child: const Text('Сохранить'),
                              ),
                            ),
                          ],
                        )),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
