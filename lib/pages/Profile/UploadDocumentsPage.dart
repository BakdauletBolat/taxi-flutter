// ignore_for_file: file_names, non_constant_identifier_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:sticky_headers/sticky_headers.dart';
import 'package:taxizakaz/components/BAppBar.dart';
import 'package:taxizakaz/components/FilePicker.dart';
import 'package:taxizakaz/hooks/showSnackBar.dart';
import 'package:taxizakaz/models/profile-model.dart';
import 'package:taxizakaz/stores/user-store.dart';

class UploadDocumentsPage extends StatefulWidget {
  const UploadDocumentsPage({Key? key}) : super(key: key);

  @override
  State<UploadDocumentsPage> createState() => _UploadDocumentsPageState();
}

class _UploadDocumentsPageState extends State<UploadDocumentsPage> {
  final ImagePicker _picker = ImagePicker();

  String? frontPassport, backPassport, carPassportFront, carPassportBack;

  XFile? frontPassportLocal,
      backPassportLocal,
      carPassportFrontLocal,
      carPassportBackLocal;

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

  void pickCarPassportFront() async {
    XFile? picked_file = await _picker.pickImage(source: ImageSource.gallery);
    carPassportFront = picked_file!.path;
    setState(() {
      carPassportFrontLocal = picked_file;
    });
  }

  void pickCarPassportBack() async {
    XFile? picked_file = await _picker.pickImage(source: ImageSource.gallery);
    carPassportBack = picked_file!.path;
    setState(() {
      carPassportBackLocal = picked_file;
    });
  }

  void onUploadClicked() async {
    UserStore userStore = Provider.of<UserStore>(context, listen: false);

    await userStore.requestUserDocument(UserDocumentsCreate(
        passport_photo_back: frontPassport,
        passport_photo_front: backPassport,
        car_passport_front: carPassportFront,
        car_passport_back: carPassportBack));

    if (userStore.error == null) {
      if (!mounted) return;
      showSuccessSnackBar(context, 'Документы успешно загружены');
    } else {
      if (!mounted) return;
      showSnackBar(context, 'Ошибка при загрузке документа');
    }
  }

  bool get useDocumentsNotNull =>
      frontPassportLocal != null &&
      backPassportLocal != null &&
      carPassportFrontLocal != null &&
      carPassportBackLocal != null;

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
            onPress: pickCarPassportFront,
            photo: carPassportFrontLocal,
            subtitle: 'Паспорт машины',
            title: 'Загрузите передную часть паспорт машины часть документа',
          ),
          FilePicker(
            onPress: pickCarPassportBack,
            photo: carPassportBackLocal,
            subtitle: 'Паспорт машины',
            title: 'Загрузите задную паспорт машины часть документа',
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                Observer(builder: (context) {
                  return Expanded(
                    child: CupertinoButton.filled(
                      onPressed: useDocumentsNotNull ? onUploadClicked : null,
                      child: userStore.isLoadingUploadDocument
                          ? const CupertinoActivityIndicator(
                              color: Colors.white)
                          : const Text('Загрузить'),
                    ),
                  );
                }),
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
