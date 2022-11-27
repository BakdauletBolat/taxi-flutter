import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:taxizakaz/pages/ActiveOrderPage.dart';
import 'package:taxizakaz/pages/CreateOrderPage.dart';
import 'package:taxizakaz/stores/order-store.dart';

class StartPage extends StatefulWidget {
  const StartPage({Key? key}) : super(key: key);

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  @override
  void initState() {
    super.initState();
    OrderStore orderStore = Provider.of<OrderStore>(context, listen: false);
    orderStore.loadLastOrder();
  }

  @override
  Widget build(BuildContext context) {
    OrderStore orderStore = Provider.of<OrderStore>(context, listen: false);

    return Observer(builder: (context) {
      if (orderStore.order != null) {
        return const ActiveOrderPage();
      } else {
        return const CreateOrderPage();
      }
    });
  }
}
