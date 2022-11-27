import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:taxizakaz/hooks/showSnackBar.dart';
import 'package:taxizakaz/stores/create-order-store.dart';
import 'package:taxizakaz/stores/order-store.dart';
import 'package:taxizakaz/stores/user-store.dart';

class OrderConfirmDialog extends StatefulWidget {
  const OrderConfirmDialog({Key? key}) : super(key: key);

  @override
  State<OrderConfirmDialog> createState() => _ErrorDialogState();
}

class _ErrorDialogState extends State<OrderConfirmDialog>
    with TickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  void onClickBack() {
    Navigator.of(context).pop();
  }

  void onClickCreate() async {
    CreateOrderStore createOrderStore =
        Provider.of<CreateOrderStore>(context, listen: false);

    OrderStore orderStore = Provider.of<OrderStore>(context, listen: false);

    await createOrderStore.create();
    if (createOrderStore.error == null) {
      createOrderStore.clear();
      await orderStore.loadLastOrder();
      if (mounted) {
        showSuccessSnackBar(context, 'Успешно создано');
        Navigator.of(context).pop();
      }
    } else {
      if (mounted) {
        showSnackBar(context, 'Что то пошло не так');
        Navigator.of(context).pop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    CreateOrderStore createOrderStore =
        Provider.of<CreateOrderStore>(context, listen: false);

    UserStore userStore = Provider.of<UserStore>(context, listen: false);

    return CupertinoAlertDialog(
      title: const Text('Создать заказ ?'),
      actions: [
        Row(
          children: [
            Expanded(
              child: CupertinoButton(
                onPressed: onClickBack,
                child: const Text(
                  'Нет, не сейчас',
                  style: TextStyle(fontSize: 14),
                ),
              ),
            ),
            Observer(builder: (context) {
              return Expanded(
                  child: CupertinoButton(
                padding: const EdgeInsets.all(20),
                onPressed: onClickCreate,
                child: createOrderStore.isLoadingCreate
                    ? CupertinoActivityIndicator(
                        color: Theme.of(context).primaryColor)
                    : const Text('Создать', style: TextStyle(fontSize: 14)),
              ));
            })
          ],
        )
      ],
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
      ]),
    );
  }
}
