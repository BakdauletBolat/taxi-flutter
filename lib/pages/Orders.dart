import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:taxizakaz/components/BAppBar.dart';
import 'package:taxizakaz/components/OrderItem.dart';
import 'package:taxizakaz/dialogs/CancelDialog.dart';
import 'package:taxizakaz/models/order.dart';
import 'package:taxizakaz/stores/order-store.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({Key? key}) : super(key: key);

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  void onClickCancel() {
    showDialog(
        context: context, builder: (context) => const CancelOrderDialog());
  }

  @override
  void initState() {
    super.initState();
    OrderStore orderStore = Provider.of<OrderStore>(context, listen: false);
    orderStore.loadUserOrders();
  }

  final DateFormat formatter = DateFormat('yyyy-MM-dd');
  final DateFormat timeFormatter = DateFormat('HH:MM');

  Widget buildDateTime(DateTime dateTime) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Дата: ${formatter.format(dateTime)}'),
        Text('Время: ${timeFormatter.format(dateTime)}')
      ],
    );
  }

  Widget buildActiveOrder(Order? order) {
    if (order == null) {
      return const SizedBox.shrink();
    }
    return Column(children: [
      SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 50,
      ),
      Text(order.from_city.name,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
      Text(order.from_address ?? ''),
      Lottie.asset('assets/lottie/active-taxi.json', height: 200),
      Text(order.to_city.name,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
      Text(order.from_address ?? ''),
      const SizedBox(
        height: 20,
      ),
      buildDateTime(order.date_time),
      const SizedBox(
        height: 20,
      ),
      Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: CupertinoButton.filled(
                onPressed: onClickCancel,
                child: const Text('Отменить заказ'),
              ),
            ),
          )
        ],
      ),
      const SizedBox(
        height: 20,
      ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    OrderStore orderStore = Provider.of<OrderStore>(context, listen: false);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const BAppBar(title: 'Заказы'),
      body: RefreshIndicator(
        onRefresh: () async {
          orderStore.loadUserOrders();
        },
        child: SingleChildScrollView(child: Observer(builder: (context) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Observer(
                  builder: (context) => buildActiveOrder(orderStore.order)),
              const Row(
                children: [
                  Padding(padding: EdgeInsets.symmetric(horizontal: 20), child: Text('Все заказы', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),)),
                ],
              ),
              const SizedBox(height: 20,),
              Observer(builder: (context) {
                return ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    separatorBuilder: ((context, index) => const Divider(
                          height: 2,
                        )),
                    shrinkWrap: true,
                    itemCount: orderStore.user_orders.length,
                    itemBuilder: (context, int index) {
                      Order order = orderStore.user_orders[index];
                      return MyOrderItem(order: order);
                    });
              })
            ],
          );
        })),
      ),
    );
  }
}
