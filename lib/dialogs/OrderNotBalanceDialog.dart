import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:taxizakaz/pages/PaymentPage.dart';
import 'package:taxizakaz/stores/user-store.dart';

class OrderNotBalanceDialog extends StatefulWidget {
  const OrderNotBalanceDialog({Key? key,required this.errorsData}) : super(key: key);

  final dynamic errorsData;

  @override
  State<OrderNotBalanceDialog> createState() => _ErrorDialogState();
}

class _ErrorDialogState extends State<OrderNotBalanceDialog> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

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
                  text: widget.errorsData['from_city'],
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              const TextSpan(text: ' до '),
              TextSpan(
                  text: widget.errorsData['to_city'],
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              const TextSpan(text: ' стоит '),
              TextSpan(
                  text: widget.errorsData['coin'].toString(),
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
                      PaymentPage(coin: widget.errorsData['coind']));
              Navigator.of(context).push(route);
            })
      ]),
    );
  }
}
