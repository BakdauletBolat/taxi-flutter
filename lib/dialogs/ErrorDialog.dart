import 'package:flutter/cupertino.dart';

class ErrorDialog extends StatefulWidget {
  const ErrorDialog({Key? key}) : super(key: key);

  @override
  State<ErrorDialog> createState() => _ErrorDialogState();
}

class _ErrorDialogState extends State<ErrorDialog>
    with TickerProviderStateMixin {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const CupertinoAlertDialog(
      title: Column(
        children: [
          Text("Пожалуйста, заполните все поля "),
        ],
      ),
    );
  }
}
