import 'package:flutter/cupertino.dart';
import 'package:lottie/lottie.dart';

class OrderNotPriceDialog extends StatefulWidget {
  const OrderNotPriceDialog({Key? key}) : super(key: key);

  @override
  State<OrderNotPriceDialog> createState() => _ErrorDialogState();
}

class _ErrorDialogState extends State<OrderNotPriceDialog>
    with TickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return const CupertinoAlertDialog(
        title: Text('К сожелению нет для этих направлений'));
  }
}
