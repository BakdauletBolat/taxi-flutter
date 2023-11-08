import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taxizakaz/components/BAppBar.dart';
import 'package:taxizakaz/stores/create-order-store.dart';

class PlaceInputModal extends StatefulWidget {
  const PlaceInputModal({Key? key, required this.onClick}) : super(key: key);

  final Function onClick;
  @override
  State<PlaceInputModal> createState() => _PlaceInputModalState();
}

class _PlaceInputModalState extends State<PlaceInputModal> {
  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    CreateOrderStore createOrderStore =
        Provider.of<CreateOrderStore>(context, listen: false);

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: const BAppBar(title: 'Напишите место откуда вас забрать'),
        body: SingleChildScrollView(
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: CupertinoTextField(
                controller: textEditingController,
                placeholder: 'Улица, дом, квартира',
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: CupertinoButton.filled(
                  child: const Text('Подтвердить'),
                  onPressed: () {
                    widget.onClick(textEditingController.text);
                    textEditingController.text = '';
                    Navigator.pop(context, 'exit');
                  }),
            )
          ]),
        ));
  }
}
