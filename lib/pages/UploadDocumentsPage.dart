import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:taxiflutter/components/BAppBar.dart';
import 'package:taxiflutter/components/FilePicker.dart';
import 'package:taxiflutter/models/profile-model.dart';
import 'package:taxiflutter/stores/user-store.dart';

class UploadDocumentsPage extends StatefulWidget {
  const UploadDocumentsPage({Key? key}) : super(key: key);

  @override
  State<UploadDocumentsPage> createState() => _UploadDocumentsPageState();
}

class _UploadDocumentsPageState extends State<UploadDocumentsPage> {
  final ImagePicker _picker = ImagePicker();

  String? frontPassport, backPassport, carPassport;

  XFile? frontPassportLocal, backPassportLocal, carPassportLocal;

  void pickFrontPassport() async {
    XFile? picked_file = await _picker.pickImage(source: ImageSource.gallery);
    frontPassport = picked_file!.path;
    setState(() {
      frontPassportLocal = picked_file;
    });
  }

  void pickBackPassport() async {
    XFile? picked_file = await _picker.pickImage(source: ImageSource.gallery);
    backPassport = picked_file!.path;
    setState(() {
      backPassportLocal = picked_file;
    });
  }

  void pickCarPassport() async {
    XFile? picked_file = await _picker.pickImage(source: ImageSource.gallery);
    carPassport = picked_file!.path;
    setState(() {
      carPassportLocal = picked_file;
    });
  }

  bool get useDocumentsNotNull =>
      frontPassportLocal != null &&
      backPassportLocal != null &&
      carPassportLocal != null;

  @override
  Widget build(BuildContext context) {
    UserStore userStore = Provider.of<UserStore>(context, listen: false);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const BAppBar(
        title: 'Загрузка документов',
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          FilePicker(
            onPress: pickFrontPassport,
            photo: frontPassportLocal,
            subtitle: 'Передная часть паспорта',
            title: 'Загрузите передную часть документа',
          ),
          FilePicker(
            onPress: pickBackPassport,
            photo: backPassportLocal,
            subtitle: 'Задная часть паспорта',
            title: 'Загрузите задную часть документа',
          ),
          FilePicker(
            onPress: pickCarPassport,
            photo: carPassportLocal,
            subtitle: 'Паспорт машины',
            title: 'Загрузите паспорт машины часть документа',
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                Expanded(
                  child: CupertinoButton.filled(
                      child: Text('Загрузить'),
                      onPressed: useDocumentsNotNull
                          ? () {
                              userStore.requestUserDocument(UserDocumentsCreate(
                                  passport_photo_back: frontPassport,
                                  passport_photo_front: frontPassport,
                                  car_passport: carPassport));
                            }
                          : null),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 100,
          )
        ]),
      ),
    );
  }
}
