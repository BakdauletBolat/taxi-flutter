import 'package:flutter/cupertino.dart';
import 'package:lottie/lottie.dart';

class ErrorDialog extends StatefulWidget {
  const ErrorDialog({Key? key}) : super(key: key);

  @override
  State<ErrorDialog> createState() => _ErrorDialogState();
}

class _ErrorDialogState extends State<ErrorDialog>
    with TickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Column(
        children: [
          Lottie.asset(
            'assets/lottie/info-animation.json',
            height: 60,
            controller: _controller,
            onLoaded: (composition) {
              // composition.
              _controller
                ..duration = composition.duration
                ..reset();
            },
          ),
          const Text("Пожалуйста запоните все поля "),
        ],
      ),
    );
  }
}
