import 'package:flutter/cupertino.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:taxizakaz/pages/PaymentPage.dart';
import 'package:taxizakaz/stores/create-order-store.dart';
import 'package:taxizakaz/stores/user-store.dart';

class OrderNotBalanceDialog extends StatefulWidget {
  const OrderNotBalanceDialog({Key? key}) : super(key: key);

  @override
  State<OrderNotBalanceDialog> createState() => _ErrorDialogState();
}

class _ErrorDialogState extends State<OrderNotBalanceDialog>
    with TickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    CreateOrderStore createOrderStore =
        Provider.of<CreateOrderStore>(context, listen: false);

    UserStore userStore = Provider.of<UserStore>(context, listen: false);

    return CupertinoAlertDialog(
      title: const Text('Не хватает баланса'),
      content: Column(children: [
        const SizedBox(
          height: 20,
        ),
        RichText(
          text: TextSpan(
            text: 'Направление с ',
            style: DefaultTextStyle.of(context).style,
            children: <TextSpan>[
              TextSpan(
                  text: createOrderStore.city_to_city_price!.from_city.name,
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              const TextSpan(text: ' до '),
              TextSpan(
                  text: createOrderStore.city_to_city_price!.to_city.name,
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              const TextSpan(text: ' стоит '),
              TextSpan(
                  text: createOrderStore.city_to_city_coin.toString(),
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              const TextSpan(text: ' монет'),
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          children: [
            const Text('Текущий баланс: '),
            Text(userStore.user!.coins.toString(),
                style: const TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        CupertinoButton.filled(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: const Text('Пополнить баланс ?'),
            onPressed: () {
              var route = CupertinoPageRoute(
                  builder: (context) =>
                      PaymentPage(coin: createOrderStore.city_to_city_coin));
              Navigator.of(context).push(route);
            })
      ]),
    );
  }
}
