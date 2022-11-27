import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taxizakaz/components/BAppBar.dart';
import 'package:taxizakaz/stores/create-order-store.dart';

class PlaceInputModal extends StatefulWidget {
  const PlaceInputModal({Key? key, required this.type}) : super(key: key);

  final String type;

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
                placeholder: 'Айбергенова 5А',
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: CupertinoButton.filled(
                  child: const Text('Подтвердить'),
                  onPressed: () {
                    if (widget.type == 'from_city') {
                      if (textEditingController.text.isEmpty) {
                        createOrderStore.from_address = null;
                      } else {
                        createOrderStore.from_address =
                            textEditingController.text;
                      }
                    }
                    if (widget.type == 'to_city') {
                      if (textEditingController.text.isEmpty) {
                        createOrderStore.to_address = null;
                      } else {
                        createOrderStore.to_address =
                            textEditingController.text;
                      }
                    }

                    textEditingController.text = '';
                    Navigator.pop(context, 'exit');
                  }),
            )
          ]),
        ));
  }
}
