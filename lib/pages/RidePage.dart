// ignore_for_file: file_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_datetime_picker/flutter_datetime_picker.dart' as PluginDatetimePicker;
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:lottie/lottie.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:taxizakaz/components/BAppBar.dart';
import 'package:taxizakaz/components/NotFoundOrder.dart';
import 'package:taxizakaz/components/OrderItem.dart';
import 'package:taxizakaz/components/Select.dart';
import 'package:taxizakaz/modals/RidePageCityList.dart';
import 'package:taxizakaz/models/order.dart';
import 'package:taxizakaz/stores/order-store.dart';
import 'package:intl/intl.dart';
import 'package:taxizakaz/stores/user-store.dart';

enum TypeOrder { driver, passenger }

class RidePage extends StatefulWidget {
  const RidePage({Key? key}) : super(key: key);

  @override
  State<RidePage> createState() => _RidePageState();
}

class _RidePageState extends State<RidePage> {
  Map<TypeOrder, int> skyColors = <TypeOrder, int>{
    TypeOrder.driver: 1,
    TypeOrder.passenger: 2
  };

  void openModal(type, {int? type_order_id}) {
    showCupertinoModalBottomSheet(
        context: context,
        expand: false,
        builder: (context) => RidePageCityList(
              type: type,
              type_order_id: type_order_id,
            ));
  }

  @override
  void initState() {
    OrderStore orderStore = Provider.of<OrderStore>(context, listen: false);
    orderStore.loadOrders(type_order: 1);
    super.initState();
  }

  TypeOrder _selectedSegment = TypeOrder.driver;

  DateFormat dateFormat = DateFormat("yyyy-MM-dd");

  Map<TypeOrder, Widget> buildChildrens() {
    return <TypeOrder, Widget>{
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
    };
  }

  @override
  Widget build(BuildContext context) {
    OrderStore orderStore = Provider.of<OrderStore>(context, listen: false);
    UserStore userStore = Provider.of<UserStore>(context, listen: false);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const BAppBar(title: 'Попутки'),
      body: RefreshIndicator(
        onRefresh: () async {
          orderStore.loadOrders(type_order: skyColors[_selectedSegment]);
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
                      openModal('from_city',
                          type_order_id: skyColors[_selectedSegment]!);
                    },
                    city_name: orderStore.from_city_name,
                  ),
                  Select(
                    iconData: Icons.place,
                    onPress: () {
                      openModal('to_city',
                          type_order_id: skyColors[_selectedSegment]!);
                    },
                    placeholder: 'Туда',
                    city_name: orderStore.to_city_name,
                  ),
                  Select(
                    iconData: Icons.calendar_month,
                    placeholder: 'Выезд',
                    value: orderStore.date,
                    onPress: () {
                      PluginDatetimePicker.DatePicker.showDatePicker(context, showTitleActions: true,
                          onConfirm: (date) {
                        orderStore.date = dateFormat.format(date);

                        orderStore.loadOrders(
                            type_order: skyColors[_selectedSegment]);
                      }, currentTime: DateTime.now(), locale: PluginDatetimePicker.LocaleType.ru);
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  if (userStore.user?.type_user == 1)
                    CupertinoSlidingSegmentedControl<TypeOrder>(
                        backgroundColor: Theme.of(context).primaryColor,
                        thumbColor: Colors.white,
                        groupValue: _selectedSegment,
                        onValueChanged: (TypeOrder? value) {
                          if (value != null) {
                            orderStore.loadOrders(type_order: skyColors[value]);

                            setState(() {
                              _selectedSegment = value;
                            });
                          }
                        },
                        children: buildChildrens()),
                  const SizedBox(
                    height: 30,
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
