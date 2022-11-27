import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:taxizakaz/hooks/showSnackBar.dart';
import 'package:taxizakaz/stores/create-order-store.dart';
import 'package:taxizakaz/stores/order-store.dart';
import 'package:taxizakaz/stores/user-store.dart';

class ExitDialog extends StatefulWidget {
  const ExitDialog({Key? key}) : super(key: key);

  @override
  State<ExitDialog> createState() => _ErrorDialogState();
}

class _ErrorDialogState extends State<ExitDialog> {
  @override
  void initState() {
    super.initState();
  }

  void onClickBack() {
    Navigator.of(context).pop();
  }

  void onClickCancel() async {
    UserStore userStore = Provider.of<UserStore>(context, listen: false);
    try {
      userStore.logout();
      showSuccessSnackBar(context, 'Успешно вышли из аккаунта');
      Navigator.of(context).pop();
    } catch (e) {
      showSnackBar(context, 'Что то пошло не так');
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: const Text('Выйти из аккаунта ?'),
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
                child: const Text('Да выйти', style: TextStyle(fontSize: 14)),
              ));
            })
          ],
        )
      ],
    );
  }
}
