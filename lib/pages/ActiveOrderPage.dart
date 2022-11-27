import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:taxizakaz/components/BAppBar.dart';
import 'package:taxizakaz/dialogs/CancelDialog.dart';
import 'package:taxizakaz/stores/order-store.dart';

class ActiveOrderPage extends StatefulWidget {
  const ActiveOrderPage({Key? key}) : super(key: key);

  @override
  State<ActiveOrderPage> createState() => _ActiveOrderPageState();
}

class _ActiveOrderPageState extends State<ActiveOrderPage> {
  void onClickCancel() {
    showDialog(
        context: context, builder: (context) => const CancelOrderDialog());
  }

  @override
  Widget build(BuildContext context) {
    OrderStore orderStore = Provider.of<OrderStore>(context, listen: false);
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final DateFormat timeFormatter = DateFormat('HH:MM');
    Widget buildDateTime() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Дата: ${formatter.format(orderStore.order!.date_time)}'),
          Text('Время: ${timeFormatter.format(orderStore.order!.date_time)}')
        ],
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const BAppBar(title: 'Активный заказ'),
      body: RefreshIndicator(
        onRefresh: () async {
          orderStore.loadLastOrder();
        },
        child: SingleChildScrollView(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 50,
            ),
            Text(orderStore.order?.from_city.name ?? 'Город не указан',
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            Text(orderStore.order?.from_address ?? ''),
            Lottie.asset('assets/lottie/active-taxi.json', height: 200),
            Text(orderStore.order?.to_city.name ?? 'Город не указан',
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            Text(orderStore.order?.from_address ?? ''),
            const SizedBox(
              height: 20,
            ),
            buildDateTime(),
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
            )
          ],
        )),
      ),
    );
  }
}
