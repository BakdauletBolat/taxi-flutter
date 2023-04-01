// ignore_for_file: file_names

import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
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
import 'package:taxizakaz/hooks/showSnackBar.dart';
import 'package:taxizakaz/modals/CitiesListModal.dart';
import 'package:taxizakaz/modals/PlaceInputModal.dart';
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
    regionStore.loadCities(context);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void openModal(type) {
    showCupertinoModalBottomSheet(
      context: context,
      expand: false,
      builder: (context) => CitiesListModal(type: type),
    );
  }

  DateFormat dateFormat = DateFormat("yyyy-MM-dd");
  DateFormat timeFormat = DateFormat("HH:mm:ss");

  void createDriverOrder() async {
    CreateOrderStore createOrderStore =
        Provider.of<CreateOrderStore>(context, listen: false);

    UserStore userStore = Provider.of<UserStore>(context, listen: false);
    OrderStore orderStore = Provider.of<OrderStore>(context, listen: false);
    await createOrderStore.setCityToCityPrice();
    await userStore.loadUser();

    if (createOrderStore.city_to_city_coin == null) {
      showDialog(
          context: context, builder: (context) => const OrderNotPriceDialog());
      return;
    }

    if (userStore.user!.access_orders_ids
        .contains(createOrderStore.access_id!)) {
      await createOrderStore.create();
      if (createOrderStore.error == null) {
        createOrderStore.clear();
        await orderStore.loadLastOrder();
        if (mounted) {
          showSuccessSnackBar(context, 'Успешно создано');
        }
      } else {
        if (mounted) {
          showSnackBar(context, 'Что то пошло не так');
        }
      }
      return;
    }

    if (userStore.user!.coins! < createOrderStore.city_to_city_coin!) {
      showDialog(
          context: context,
          builder: (context) => const OrderNotBalanceDialog());
      return;
    }

    showDialog(
        context: context,
        builder: (context) {
          return const OrderConfirmDialog();
        });
  }

  void createPassengerOrder() async {
    CreateOrderStore createOrderStore =
        Provider.of<CreateOrderStore>(context, listen: false);

    OrderStore orderStore = Provider.of<OrderStore>(context, listen: false);
    await createOrderStore.create();
    if (createOrderStore.error == null) {
      createOrderStore.clear();
      await orderStore.loadLastOrder();
      if (mounted) {
        showSuccessSnackBar(context, 'Успешно создано');
      }
    } else {
      if (mounted) {
        showSnackBar(context, 'Что то пошло не так');
      }
    }
    return;
  }

  void navigateToFeedBackPage() {
    var route = CupertinoPageRoute(builder: (context) => const FeedBackPage());
    Navigator.of(context).push(route);
  }

  void onOrderCreateClicked() async {
    CreateOrderStore createOrderStore =
        Provider.of<CreateOrderStore>(context, listen: false);

    UserStore userStore = Provider.of<UserStore>(context, listen: false);

    if (createOrderStore.isCreate) {
      if (userStore.user?.type_user == 2) {
        createPassengerOrder();
      } else {
        createDriverOrder();
      }
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

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const BAppBar(
        title: 'Межгород',
      ),
      body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Select(
                iconData: Icons.directions,
                onPress: () {
                  openModal('from_city');
                },
                placeholder: 'Откуда',
                city_name: createOrderStore.from_city_name,
                address: createOrderStore.from_address,
              ),
              Select(
                iconData: Icons.place,
                onPress: () {
                  openModal('to_city');
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
                    DatePicker.showDatePicker(context, showTitleActions: true,
                        onConfirm: (date) {
                      createOrderStore.date = dateFormat.format(date);
                    },
                        currentTime: DateTime.now(),
                        locale: LocaleType.ru,
                        theme: DatePickerTheme(
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
                    DatePicker.showTimePicker(context, showTitleActions: true,
                        onConfirm: (date) {
                      createOrderStore.time = timeFormat.format(date);
                    },
                        currentTime: DateTime.now(),
                        locale: LocaleType.ru,
                        theme: DatePickerTheme(
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
