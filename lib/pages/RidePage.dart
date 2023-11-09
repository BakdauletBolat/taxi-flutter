// ignore_for_file: file_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart'
    as PluginDatetimePicker;
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:lottie/lottie.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:taxizakaz/components/BAppBar.dart';
import 'package:taxizakaz/components/NotFoundOrder.dart';
import 'package:taxizakaz/components/OrderItem.dart';
import 'package:taxizakaz/components/Select.dart';
import 'package:taxizakaz/hooks/showModal.dart';
import 'package:taxizakaz/modals/ListModal.dart';
import 'package:taxizakaz/models/order.dart';
import 'package:taxizakaz/stores/order-store.dart';
import 'package:intl/intl.dart';
import 'package:taxizakaz/stores/region-store.dart';
import 'package:taxizakaz/stores/user-store.dart';

enum TypeOrder { driver, passenger }

class RidePage extends StatefulWidget {
  const RidePage({Key? key}) : super(key: key);

  @override
  State<RidePage> createState() => _RidePageState();
}

class _RidePageState extends State<RidePage> {
  Map<TypeOrder, int> typeOrder = <TypeOrder, int>{
    TypeOrder.driver: 1,
    TypeOrder.passenger: 2
  };


  TypeOrder selectedType = TypeOrder.driver;

  @override
  void initState() {
    OrderStore orderStore = Provider.of<OrderStore>(context, listen: false);
    UserStore userStore = Provider.of<UserStore>(context, listen: false);
    if (userStore.user!.type_user == 1) {
        selectedType = TypeOrder.passenger;
    }
    orderStore.loadOrders(type_order: typeOrder[selectedType]);
    super.initState();
  }

  

  DateFormat dateFormat = DateFormat("yyyy-MM-dd");


  @override
  Widget build(BuildContext context) {
    OrderStore orderStore = Provider.of<OrderStore>(context, listen: false);
    RegionStore regionStore = Provider.of<RegionStore>(context, listen: false);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const BAppBar(title: 'Попутки'),
      body: RefreshIndicator(
        onRefresh: () async {
          orderStore.loadOrders(type_order: typeOrder[selectedType]);
        },
        child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            physics: const AlwaysScrollableScrollPhysics(),
            child: Observer(builder: (context) {
              return Column(
                children: [
                  Select(
                    iconData: Icons.directions,
                    onPress: () {
                      showModal(
                          context,
                          ListModal(
                            withPlace: false,
                              items: regionStore.regions,
                              onClick: (item) {
                                orderStore.from_city_id = item.id;
                                orderStore.from_city_name = item.name;
                                orderStore.loadOrders(
                                    type_order: typeOrder[selectedType]);
                              }));
                    },
                    city_name: orderStore.from_city_name,
                  ),
                  Select(
                    iconData: Icons.place,
                    onPress: () {
                      showModal(
                          context,
                          ListModal(
                            withPlace: false,
                              items: regionStore.regions,
                              onClick: (item) {
                                orderStore.to_city_id = item.id;
                                orderStore.to_city_name = item.name;
                                orderStore.loadOrders(
                                    type_order: typeOrder[selectedType]);
                              }));
                    },
                    placeholder: 'Туда',
                    city_name: orderStore.to_city_name,
                  ),
                  Select(
                    iconData: Icons.calendar_month,
                    placeholder: 'Выезд',
                    value: orderStore.date,
                    onPress: () {
                      PluginDatetimePicker.DatePicker.showDatePicker(context,
                          showTitleActions: true, onConfirm: (date) {
                        orderStore.date = dateFormat.format(date);

                        orderStore.loadOrders(
                            type_order: typeOrder[selectedType]);
                      },
                          currentTime: DateTime.now(),
                          locale: PluginDatetimePicker.LocaleType.ru);
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  
                  Observer(builder: (context) {
                    if (orderStore.isLoadingOrders == true) {
                      return SizedBox(
                        height: 300,
                        child: Center(
                            child:
                                Lottie.asset('assets/lottie/loading_car.json')),
                      );
                    }
                    if (orderStore.orders.isEmpty) {
                      return const NotFoundOrder();
                    }
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
      ),
    );
  }
}
