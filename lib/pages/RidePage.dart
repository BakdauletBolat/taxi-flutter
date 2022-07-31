import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:taxiflutter/components/BAppBar.dart';
import 'package:taxiflutter/components/ListTile.dart';
import 'package:taxiflutter/components/OrderItem.dart';
import 'package:taxiflutter/components/Select.dart';
import 'package:taxiflutter/models/order.dart';
import 'package:taxiflutter/stores/order-store.dart';
import 'package:taxiflutter/stores/region-store.dart';
import 'package:taxiflutter/stores/user-store.dart';
import 'package:intl/intl.dart';

enum TypeOrder { driver, passenger }

Map<TypeOrder, int> skyColors = <TypeOrder, int>{
  TypeOrder.driver: 1,
  TypeOrder.passenger: 2
};

class RidePage extends StatefulWidget {
  const RidePage({Key? key}) : super(key: key);

  @override
  State<RidePage> createState() => _RidePageState();
}

class _RidePageState extends State<RidePage> {
  void openModal(type) {
    OrderStore orderStore = Provider.of<OrderStore>(context, listen: false);
    RegionStore regionStore = Provider.of<RegionStore>(context, listen: false);
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
                            orderStore.from_city_id =
                                regionStore.cities[index].id;
                            orderStore.from_city_name =
                                regionStore.cities[index].name;
                          }
                          if (type == 'to_city') {
                            orderStore.to_city_id =
                                regionStore.cities[index].id;
                            orderStore.to_city_name =
                                regionStore.cities[index].name;
                          }

                          orderStore.loadOrders();

                          Navigator.of(context).pop();
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

  @override
  void initState() {
    OrderStore orderStore = Provider.of<OrderStore>(context, listen: false);
    orderStore.loadOrders();
    super.initState();
  }

  TypeOrder _selectedSegment = TypeOrder.driver;

  DateFormat dateFormat = DateFormat("yyyy-MM-dd");

  @override
  Widget build(BuildContext context) {
    OrderStore orderStore = Provider.of<OrderStore>(context, listen: false);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const BAppBar(title: 'Попутки'),
      body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Observer(builder: (context) {
            return Column(
              children: [
                Select(
                  iconData: Icons.directions,
                  onPress: () {
                    openModal('from_city');
                  },
                  city_name: orderStore.from_city_name,
                ),
                Select(
                  iconData: Icons.place,
                  onPress: () {
                    openModal('to_city');
                  },
                  placeholder: 'Туда',
                  city_name: orderStore.to_city_name,
                ),
                Select(
                  iconData: Icons.calendar_month,
                  placeholder: 'Выезд',
                  value: orderStore.date,
                  onPress: () {
                    DatePicker.showDatePicker(context, showTitleActions: true,
                        onConfirm: (date) {
                      orderStore.date = dateFormat.format(date);
                      orderStore.loadOrders();
                    }, currentTime: DateTime.now(), locale: LocaleType.ru);
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                CupertinoSlidingSegmentedControl<TypeOrder>(
                  backgroundColor: Theme.of(context).primaryColor,
                  thumbColor: Colors.white,
                  groupValue: _selectedSegment,
                  onValueChanged: (TypeOrder? value) {
                    if (value != null) {
                      if (value == TypeOrder.driver) {
                        orderStore.loadOrders(type_order: 1);
                      }

                      if (value == TypeOrder.passenger) {
                        orderStore.loadOrders(type_order: 2);
                      }

                      setState(() {
                        _selectedSegment = value;
                      });
                    }
                  },
                  children: <TypeOrder, Widget>{
                    TypeOrder.driver: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        'Водителские',
                        style: TextStyle(
                            color: _selectedSegment == TypeOrder.driver
                                ? Theme.of(context).primaryColor
                                : Colors.white),
                      ),
                    ),
                    TypeOrder.passenger: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        'Пассажирские',
                        style: TextStyle(
                            color: _selectedSegment == TypeOrder.passenger
                                ? Theme.of(context).primaryColor
                                : Colors.white),
                      ),
                    ),
                  },
                ),
                const SizedBox(
                  height: 30,
                ),
                Observer(builder: (context) {
                  return ListView.separated(
                      physics: const NeverScrollableScrollPhysics(),
                      separatorBuilder: ((context, index) => const Divider(
                            height: 30,
                          )),
                      shrinkWrap: true,
                      itemCount: orderStore.orders.length,
                      itemBuilder: (context, int index) {
                        Order order = orderStore.orders[index];

                        return OrderItem(order: order);
                      });
                }),
              ],
            );
          })),
    );
  }
}
