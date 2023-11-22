import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:taxizakaz/hooks/showSnackBar.dart';
import 'package:taxizakaz/stores/order-store.dart';

class CancelOrderDialog extends StatefulWidget {
  const CancelOrderDialog({Key? key}) : super(key: key);

  @override
  State<CancelOrderDialog> createState() => _ErrorDialogState();
}

class _ErrorDialogState extends State<CancelOrderDialog> {
  @override
  void initState() {
    super.initState();
  }

  void onClickBack() {
    Navigator.of(context).pop();
  }

  void onClickCancel() async {
    OrderStore orderStore = Provider.of<OrderStore>(context, listen: false);
    try {
      orderStore.cancelOrder();
      orderStore.loadUserOrders();
      Navigator.of(context).pop();
    } catch (e) {
      showSnackBar(context, 'Ошибка при отмений');
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: const Text('Отменить заказ ?'),
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
                onPressed: onClickCancel,
                child: const Text('Отменить', style: TextStyle(fontSize: 14)),
              ));
            })
          ],
        )
      ],
    );
  }
}
