import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:taxiflutter/components/BAppBar.dart';
import 'package:taxiflutter/components/ListTile.dart';
import 'package:taxiflutter/components/Select.dart';
import 'package:taxiflutter/stores/user-store.dart';

class CreateOrderPage extends StatefulWidget {
  const CreateOrderPage({Key? key}) : super(key: key);

  @override
  State<CreateOrderPage> createState() => _CreateOrderPageState();
}

class _CreateOrderPageState extends State<CreateOrderPage> {
  void openSecondModal() {
    showCupertinoModalBottomSheet(
      context: context,
      expand: false,
      builder: (context) => Scaffold(
          backgroundColor: Colors.white,
          appBar: const BAppBar(title: 'Напишите место откуда вас забрать'),
          body: SingleChildScrollView(
            child: Column(children: [
              const Padding(
                padding: EdgeInsets.all(20),
                child: CupertinoTextField(
                  placeholder: 'Айбергенова 5А',
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: CupertinoButton.filled(
                    child: const Text('Подтвердить'), onPressed: () {}),
              )
            ]),
          )),
    );
  }

  void openModal() {
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
              ListView.builder(
                  itemCount: 100,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: openSecondModal,
                      child: const BListTile(
                        city_name: 'Шымкент',
                      ),
                    );
                  })
            ]),
          )),
    );
  }

  String? city_name_from = 'Шымкент';
  String? address_from = 'Aibergenova 5A';

  String? city_name_to = 'Аламаты';
  String? address_to = 'Бейбитшилик';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const BAppBar(
        title: 'Межгород',
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          Select(
            iconData: Icons.directions,
            onPress: openModal,
            city_name: city_name_from,
            address: address_from,
          ),
          Select(
            iconData: Icons.place,
            onPress: openModal,
            placeholder: 'Туда',
            city_name: city_name_to,
            address: address_to,
          ),
          CupertinoTextFormFieldRow(
            placeholder: 'Цена',
            decoration: const BoxDecoration(),
            prefix: Icon(Icons.wallet, color: Theme.of(context).primaryColor),
          ),
          CupertinoTextFormFieldRow(
            placeholder: 'Комментарий',
            decoration: const BoxDecoration(),
            prefix: Icon(Icons.chat_bubble_rounded,
                color: Theme.of(context).primaryColor),
          ),
          Select(
            iconData: Icons.calendar_month,
            placeholder: 'Выезд',
            onPress: () {
              DatePicker.showDatePicker(context, showTitleActions: true,
                  onChanged: (date) {
                print('change $date');
              }, onConfirm: (date) {
                print('confirm $date');
              }, currentTime: DateTime.now(), locale: LocaleType.ru);
            },
          ),
          Select(
            iconData: Icons.timer,
            placeholder: 'Дата выезда',
            onPress: () {
              DatePicker.showTimePicker(context, showTitleActions: true,
                  onChanged: (date) {
                print('change $date in time zone ' +
                    date.timeZoneOffset.inHours.toString());
              }, onConfirm: (date) {
                print('confirm $date');
              }, currentTime: DateTime.now());
            },
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Expanded(
                    child: CupertinoButton.filled(
                        child: const Text('Заказать'), onPressed: () {}))
              ],
            ),
          )
        ],
      )),
    );
  }
}
