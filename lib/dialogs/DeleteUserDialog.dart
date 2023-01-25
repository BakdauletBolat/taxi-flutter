import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:taxizakaz/hooks/showSnackBar.dart';
import 'package:taxizakaz/stores/create-order-store.dart';
import 'package:taxizakaz/stores/order-store.dart';
import 'package:taxizakaz/stores/user-store.dart';

class DeleteUserDialog extends StatefulWidget {
  const DeleteUserDialog({Key? key}) : super(key: key);

  @override
  State<DeleteUserDialog> createState() => _ErrorDialogState();
}

class _ErrorDialogState extends State<DeleteUserDialog> {
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
      userStore.deleteUser();
      showSuccessSnackBar(context, 'Аккаунт успешно удален');
      Navigator.of(context).pop();
    } catch (e) {
      showSnackBar(context, 'Что то пошло не так');
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: const Text(
          'Вы хотите удалить приложение ?, (Будет удалено история заказов, платежи, информация о водителе)'),
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
                child: const Text('Да удалить', style: TextStyle(fontSize: 14)),
              ));
            })
          ],
        )
      ],
    );
  }
}
