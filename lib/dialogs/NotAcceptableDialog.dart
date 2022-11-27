import 'package:flutter/cupertino.dart';
import 'package:lottie/lottie.dart';
import 'package:taxizakaz/models/order.dart';

class NotAcceptableDialog extends StatefulWidget {
  const NotAcceptableDialog({Key? key, required this.order}) : super(key: key);

  final Order order;

  @override
  State<NotAcceptableDialog> createState() => _NotAcceptableDialogState();
}

class _NotAcceptableDialogState extends State<NotAcceptableDialog> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: const Text("Не доступно"),
      content: RichText(
        text: TextSpan(
          text: 'Нужно создать заказ по направлению с',
          style: DefaultTextStyle.of(context).style,
          children: <TextSpan>[
            TextSpan(
                text: widget.order.from_city.name,
                style: const TextStyle(fontWeight: FontWeight.bold)),
            const TextSpan(text: ' до '),
            TextSpan(
                text: widget.order.to_city.name,
                style: const TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
