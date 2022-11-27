import 'package:flutter/cupertino.dart';
import 'package:lottie/lottie.dart';

class SuccessDialog extends StatelessWidget {
  const SuccessDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Column(
        children: [
          Lottie.asset('assets/lottie/success.json'),
          const Text("Заказ успешно создан "),
        ],
      ),
      content: const Text("Посмотреть заказ ?"),
      actions: [
        CupertinoDialogAction(
            child: const Text("Да"),
            onPressed: () {
              Navigator.of(context).pop();
            }),
        CupertinoDialogAction(
          child: const Text("Нет"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        )
      ],
    );
  }
}
