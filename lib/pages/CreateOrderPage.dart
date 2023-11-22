// ignore_for_file: file_names

import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart'
    as PluginDatetimePicker;
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:taxizakaz/components/BAppBar.dart';
import 'package:taxizakaz/components/Select.dart';
import 'package:taxizakaz/dialogs/ErrorDialog.dart';
import 'package:taxizakaz/dialogs/OrderNotBalanceDialog.dart';
import 'package:taxizakaz/dialogs/OrderNotPriceDialog.dart';
import 'package:taxizakaz/dialogs/OrderConfirmDialog.dart';
import 'package:taxizakaz/hooks/showModal.dart';
import 'package:taxizakaz/hooks/showSnackBar.dart';
import 'package:taxizakaz/modals/ListModal.dart';
import 'package:taxizakaz/modals/PlaceInputModal.dart';
import 'package:taxizakaz/pages/Orders.dart';
import 'package:taxizakaz/pages/FeedBackPage.dart';
import 'package:taxizakaz/stores/create-order-store.dart';
import 'package:taxizakaz/stores/order-store.dart';
import 'package:taxizakaz/stores/region-store.dart';
import 'package:taxizakaz/stores/user-store.dart';

class CreateOrderPage extends StatefulWidget {
  const CreateOrderPage({Key? key}) : super(key: key);

  @override
  State<CreateOrderPage> createState() => _CreateOrderPageState();
}

class _CreateOrderPageState extends State<CreateOrderPage> {
  @override
  void initState() {
    RegionStore regionStore = Provider.of<RegionStore>(context, listen: false);
    regionStore.loadRegions(context);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  DateFormat dateFormat = DateFormat("yyyy-MM-dd");
  DateFormat timeFormat = DateFormat("HH:mm:ss");

  void createOrder() async {
    CreateOrderStore createOrderStore =
        Provider.of<CreateOrderStore>(context, listen: false);

    UserStore userStore = Provider.of<UserStore>(context, listen: false);
    OrderStore orderStore = Provider.of<OrderStore>(context, listen: false);
    await userStore.loadUser();
    await createOrderStore.create();
    if (createOrderStore.error == null) {
      createOrderStore.clear();
      orderStore.loadUserOrders();
      if (mounted) {
        showSuccessSnackBar(context, 'Успешно создано');
        var route = MaterialPageRoute(builder: (context) => const OrdersPage());
        Navigator.of(context).push(route);
      }
    } else {
      if (mounted) {
        if (createOrderStore.error?.response?.statusCode == 431) {
          return showDialog(
            barrierDismissible: true,
            context: context,
            builder: (context) {
              return OrderNotBalanceDialog(
                errorsData: createOrderStore.error?.response?.data['errors'],
              );
            },
          );
        }
        showSnackBar(context,
            createOrderStore.error?.response?.data['detail'].toString());
      }
    }
  }

  void navigateToFeedBackPage() {
    var route = CupertinoPageRoute(builder: (context) => const FeedBackPage());
    Navigator.of(context).push(route);
  }

  void onOrderCreateClicked() async {
    CreateOrderStore createOrderStore =
        Provider.of<CreateOrderStore>(context, listen: false);

    if (createOrderStore.isCreate) {
      createOrder();
    } else {
      showDialog(
        barrierDismissible: true,
        context: context,
        builder: (context) {
          return const ErrorDialog();
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    CreateOrderStore createOrderStore =
        Provider.of<CreateOrderStore>(context, listen: false);
    UserStore userStore = Provider.of<UserStore>(context, listen: false);
    RegionStore regionStore = Provider.of<RegionStore>(context, listen: false);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: BAppBar(
        title: 'Межгород',
        actions: [
          CupertinoButton(
              child: const Text('Заказы'),
              onPressed: () {
                var route =
                    MaterialPageRoute(builder: (context) => const OrdersPage());
                Navigator.of(context).push(route);
              })
        ],
      ),
      body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Select(
                iconData: Icons.directions,
                onPress: () {
                  showModal(
                      context,
                      ListModal(
                          items: regionStore.regions,
                          placeWidget:
                              PlaceInputModal(onClick: (String? value) {
                            createOrderStore.from_address = value;
                          }),
                          onClick: (dynamic item) {
                            createOrderStore.from_city_id = item.id;
                            createOrderStore.from_city_name = item.name;
                          }));
                },
                placeholder: 'Откуда',
                city_name: createOrderStore.from_city_name,
                address: createOrderStore.from_address,
              ),
              Select(
                iconData: Icons.place,
                onPress: () {
                  showModal(
                      context,
                      ListModal(
                          items: regionStore.regions,
                          placeWidget:
                              PlaceInputModal(onClick: (String? value) {
                            createOrderStore.to_address = value;
                          }),
                          onClick: (dynamic item) {
                            createOrderStore.to_city_id = item.id;
                            createOrderStore.to_city_name = item.name;
                          }));
                },
                placeholder: 'Куда',
                city_name: createOrderStore.to_city_name,
                address: createOrderStore.to_address,
              ),
              CupertinoTextFormFieldRow(
                padding: const EdgeInsets.symmetric(vertical: 5),
                keyboardType: TextInputType.number,
                placeholder: 'Цена',
                onChanged: (value) {
                  createOrderStore.price = int.tryParse(value);
                },
                decoration: const BoxDecoration(),
                prefix:
                    Icon(Icons.wallet, color: Theme.of(context).primaryColor),
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
              Observer(builder: (context) {
                return Select(
                  iconData: Icons.calendar_month,
                  placeholder: 'Выезд',
                  value: createOrderStore.date,
                  onPress: () {
                    PluginDatetimePicker.DatePicker.showDatePicker(context,
                        showTitleActions: true, onConfirm: (date) {
                      createOrderStore.date = dateFormat.format(date);
                    },
                        currentTime: DateTime.now(),
                        locale: PluginDatetimePicker.LocaleType.ru,
                        theme: PluginDatetimePicker.DatePickerTheme(
                            doneStyle: TextStyle(
                                color: Theme.of(context).primaryColor)));
                  },
                );
              }),
              Observer(builder: (context) {
                return Select(
                  iconData: Icons.timer,
                  placeholder: 'Время выезда',
                  value: createOrderStore.time,
                  onPress: () {
                    PluginDatetimePicker.DatePicker.showTimePicker(context,
                        showTitleActions: true, onConfirm: (date) {
                      createOrderStore.time = timeFormat.format(date);
                    },
                        currentTime: DateTime.now(),
                        locale: PluginDatetimePicker.LocaleType.ru,
                        theme: PluginDatetimePicker.DatePickerTheme(
                            doneStyle: TextStyle(
                                color: Theme.of(context).primaryColor)));
                  },
                );
              }),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    Expanded(
                        child: CupertinoButton.filled(
                      onPressed: onOrderCreateClicked,
                      child: Observer(builder: (context) {
                        if (userStore.user?.type_user == 2) {
                          return const Text('Заказать');
                        }
                        return const Text('Создать заказ');
                      }),
                    )),
                  ],
                ),
              ),
              Observer(
                builder: (context) {
                  if (userStore.user?.type_user == 1) {
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
              SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                        style: const TextStyle(color: Colors.black),
                        text: 'Если у вас возникли проблемы, ',
                        children: [
                          TextSpan(
                              style: const TextStyle(
                                  color: Colors.blueGrey,
                                  decoration: TextDecoration.underline),
                              text: 'напишите нам',
                              recognizer: TapGestureRecognizer()
                                ..onTap = navigateToFeedBackPage)
                        ]),
                  ))
            ],
          )),
    );
  }
}
