// ignore_for_file: file_names

import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:mobx/mobx.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:sticky_headers/sticky_headers.dart';
import 'package:taxizakaz/components/BAppBar.dart';
import 'package:taxizakaz/components/ListTile.dart';
import 'package:taxizakaz/components/Select.dart';
import 'package:taxizakaz/components/StickyErrorHeader.dart';
import 'package:taxizakaz/stores/create-order-store.dart';
import 'package:taxizakaz/stores/region-store.dart';
import 'package:taxizakaz/stores/user-store.dart';

class CreateOrderPage extends StatefulWidget {
  const CreateOrderPage({Key? key}) : super(key: key);

  @override
  State<CreateOrderPage> createState() => _CreateOrderPageState();
}

class _CreateOrderPageState extends State<CreateOrderPage> {
  late var disposeFunc;

  @override
  void initState() {
    CreateOrderStore createOrderStore =
        Provider.of<CreateOrderStore>(context, listen: false);
    RegionStore regionStore = Provider.of<RegionStore>(context, listen: false);
    regionStore.loadCities();
    super.initState();

    disposeFunc =
        reaction((_) => createOrderStore.error, (msg) => _showDialog());
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    disposeFunc();
  }

  TextEditingController textEditingController = TextEditingController();

  Future<String> openSecondModal(type) async {
    CreateOrderStore createOrderStore =
        Provider.of<CreateOrderStore>(context, listen: false);
    var res = await showCupertinoModalBottomSheet(
      context: context,
      expand: false,
      builder: (context) => Scaffold(
          backgroundColor: Colors.white,
          appBar: const BAppBar(title: 'Напишите место откуда вас забрать'),
          body: SingleChildScrollView(
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: CupertinoTextField(
                  controller: textEditingController,
                  placeholder: 'Айбергенова 5А',
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: CupertinoButton.filled(
                    child: const Text('Подтвердить'),
                    onPressed: () {
                      if (type == 'from_city') {
                        if (textEditingController.text.isEmpty) {
                          createOrderStore.from_address = null;
                        } else {
                          createOrderStore.from_address =
                              textEditingController.text;
                        }
                      }
                      if (type == 'to_city') {
                        if (textEditingController.text.isEmpty) {
                          createOrderStore.to_address = null;
                        } else {
                          createOrderStore.to_address =
                              textEditingController.text;
                        }
                      }

                      textEditingController.text = '';
                      Navigator.pop(context, 'exit');
                    }),
              )
            ]),
          )),
    );
    return res.toString();
  }

  void openModal(type) {
    RegionStore regionStore = Provider.of<RegionStore>(context, listen: false);
    CreateOrderStore createOrderStore =
        Provider.of<CreateOrderStore>(context, listen: false);

    UserStore userStore = Provider.of<UserStore>(context, listen: false);

    showCupertinoModalBottomSheet(
      context: context,
      expand: false,
      builder: (context) => Scaffold(
          backgroundColor: Colors.white,
          appBar: const BAppBar(title: 'Выберите город'),
          body: SingleChildScrollView(
            child: Column(children: [
              const Padding(
                padding: EdgeInsets.all(20),
                child: CupertinoSearchTextField(
                  placeholder: 'Искать',
                ),
              ),
              Observer(builder: (context) {
                return ListView.builder(
                    itemCount: regionStore.cities.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () async {
                          if (type == 'from_city') {
                            createOrderStore.from_city_name =
                                regionStore.cities[index].name;
                            createOrderStore.from_city_id =
                                regionStore.cities[index].id;
                          }
                          if (type == 'to_city') {
                            createOrderStore.to_city_name =
                                regionStore.cities[index].name;
                            createOrderStore.to_city_id =
                                regionStore.cities[index].id;
                          }

                          if (userStore.profile?.type_user != null &&
                              userStore.profile?.type_user == 2) {
                            var res = await openSecondModal(type);

                            if (res == 'exit') {
                              // ignore: use_build_context_synchronously
                              Navigator.of(context).pop();
                            }
                          } else {
                            Navigator.of(context).pop();
                          }
                        },
                        child: BListTile(
                          region_name: regionStore.cities[index].region!.name,
                          city_name: regionStore.cities[index].name,
                        ),
                      );
                    });
              })
            ]),
          )),
    );
  }

  DateFormat dateFormat = DateFormat("yyyy-MM-dd");
  DateFormat timeFormat = DateFormat("HH:mm:ss");

  void _showDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title:
            const Text("Для того чтобы создать заказ, нужно оплатить поездку"),
        content: Column(
          children: [Text("createOrderStore.error['message']")],
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            child: Container(
              color: Colors.green,
              padding: const EdgeInsets.all(14),
              child: const Text("okay"),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    CreateOrderStore createOrderStore =
        Provider.of<CreateOrderStore>(context, listen: false);
    UserStore userStore = Provider.of<UserStore>(context, listen: false);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const BAppBar(
        title: 'Межгород',
      ),
      body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: StickyHeader(
            header: Observer(
                builder: (context) => StickyErrorHeader(error: 'error')),
            content: Observer(builder: (context) {
              // if (createOrderStore.error != null) {

              // }
              return Column(
                children: [
                  Select(
                    iconData: Icons.directions,
                    onPress: () {
                      openModal('from_city');
                    },
                    city_name: createOrderStore.from_city_name,
                    address: createOrderStore.from_address,
                  ),
                  Select(
                    iconData: Icons.place,
                    onPress: () {
                      openModal('to_city');
                    },
                    placeholder: 'Туда',
                    city_name: createOrderStore.to_city_name,
                    address: createOrderStore.to_address,
                  ),
                  CupertinoTextFormFieldRow(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    placeholder: 'Цена',
                    initialValue: createOrderStore.price.toString(),
                    onChanged: (value) {
                      createOrderStore.price = int.tryParse(value);
                    },
                    decoration: const BoxDecoration(),
                    prefix: Icon(Icons.wallet,
                        color: Theme.of(context).primaryColor),
                  ),
                  CupertinoTextFormFieldRow(
                    initialValue: createOrderStore.comment,
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    placeholder: 'Комментарий',
                    onChanged: (value) {
                      createOrderStore.comment = value;
                    },
                    decoration: const BoxDecoration(),
                    prefix: Icon(Icons.chat_bubble_rounded,
                        color: Theme.of(context).primaryColor),
                  ),
                  Select(
                    iconData: Icons.calendar_month,
                    placeholder: 'Выезд',
                    value: createOrderStore.date,
                    onPress: () {
                      DatePicker.showDatePicker(context, showTitleActions: true,
                          onConfirm: (date) {
                        createOrderStore.date = dateFormat.format(date);
                      }, currentTime: DateTime.now(), locale: LocaleType.ru);
                    },
                  ),
                  Select(
                    iconData: Icons.timer,
                    placeholder: 'Время выезда',
                    value: createOrderStore.time,
                    onPress: () {
                      DatePicker.showTimePicker(context, showTitleActions: true,
                          onConfirm: (date) {
                        createOrderStore.time = timeFormat.format(date);
                      }, currentTime: DateTime.now());
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      children: [
                        Expanded(
                            child: CupertinoButton.filled(
                                child: Builder(builder: (context) {
                          if (userStore.profile?.type_user == 2) {
                            return const Text('Заказать');
                          }
                          return const Text('Создать заказ');
                        }), onPressed: () async {
                          if (createOrderStore.isCreate) {
                            await createOrderStore.create();
                            if (createOrderStore.error == null) {
                              createOrderStore.clear();
                              showCupertinoDialog(
                                context: context,
                                builder: (context) {
                                  return CupertinoAlertDialog(
                                    title: Column(
                                      children: [
                                        Lottie.asset(
                                            'assets/lottie/success.json'),
                                        const Text("Заказ успешно создан "),
                                      ],
                                    ),
                                    content: const Text("Посмотреть заказ ?"),
                                    actions: [
                                      CupertinoDialogAction(
                                          child: const Text("Да"),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          }),
                                      CupertinoDialogAction(
                                        child: const Text("Нет"),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      )
                                    ],
                                  );
                                },
                              );
                            }
                          } else {
                            showCupertinoDialog(
                              barrierDismissible: true,
                              context: context,
                              builder: (context) {
                                return CupertinoAlertDialog(
                                  title: Column(
                                    children: [
                                      Lottie.asset(
                                          'assets/lottie/warning.json'),
                                      const Text(
                                          "Пожалуйста запоните все поля "),
                                    ],
                                  ),
                                );
                              },
                            );
                          }
                        })),
                      ],
                    ),
                  ),
                  Builder(
                    builder: (context) {
                      if (userStore.profile?.type_user == 1) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(CupertinoIcons.car_detailed,
                                  color: Theme.of(context).primaryColor),
                              const SizedBox(
                                width: 10,
                              ),
                              const Text('Вы создаете заказ как водитель')
                            ],
                          ),
                        );
                      }

                      return const SizedBox.shrink();
                    },
                  ),
                ],
              );
            }),
          )),
    );
  }
}
