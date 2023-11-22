import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:taxizakaz/components/BAppBar.dart';
import 'package:taxizakaz/components/NotFoundOrder.dart';
import 'package:taxizakaz/components/OrderItem.dart';
import 'package:taxizakaz/models/order.dart';
import 'package:taxizakaz/stores/order-store.dart';

class UserOrdersPage extends StatefulWidget {
  const UserOrdersPage({Key? key}) : super(key: key);

  @override
  State<UserOrdersPage> createState() => _UserOrdersPageState();
}

class _UserOrdersPageState extends State<UserOrdersPage> {
  @override
  void initState() {
    OrderStore orderStore = Provider.of<OrderStore>(context, listen: false);
    orderStore.loadUserOrders();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    OrderStore orderStore = Provider.of<OrderStore>(context, listen: false);
    return Scaffold(
      appBar: const BAppBar(title: 'Заказы'),
      body: Observer(builder: (context) {
        // if (orderStore.isLoadingOrders == true) {
        //   return SizedBox(
        //     height: 300,
        //     child:
        //         Center(child: Lottie.asset('assets/lottie/loading_car.json')),
        //   );
        // }
        if (orderStore.orders.isEmpty) {
          return const Center(child: NotFoundOrder());
        }
        return ListView.separated(
            padding: const EdgeInsets.all(20),
            physics: const NeverScrollableScrollPhysics(),
            separatorBuilder: ((context, index) => const Divider(
                  height: 30,
                )),
            shrinkWrap: true,
            itemCount: orderStore.user_orders.length,
            itemBuilder: (context, int index) {
              Order order = orderStore.user_orders[index];
              return OrderItem(order: order, visiblePhone: true);
            });
      }),
    );
  }
}
