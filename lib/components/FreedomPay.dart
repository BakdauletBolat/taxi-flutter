import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taxizakaz/api/user-service.dart';
import 'package:taxizakaz/components/BAppBar.dart';
import 'package:taxizakaz/models/profile-model.dart';
import 'package:taxizakaz/stores/user-store.dart';
import 'package:webview_flutter/webview_flutter.dart';

class FreedomPay extends StatefulWidget {
  const FreedomPay({Key? key, required this.url, required this.order_id})
      : super(key: key);

  final String url;
  final int order_id;

  @override
  State<FreedomPay> createState() => _FreedomPayState();
}

class _FreedomPayState extends State<FreedomPay> {
  late final WebViewController controller;

  Timer? periodicTimer;

  Future<bool> getResult() async {
    UserService userService = UserService();
    Payment? payment = await userService.getPayment(widget.order_id);
    if (payment != null && payment.is_confirmed) {
      return true;
    }
    return false;
  }

  bool is_confirmed = false;

  @override
  void initState() {
    super.initState();
    periodicTimer = Timer.periodic(const Duration(seconds: 3), (timer) async {
      bool is_confirmed = await getResult();
      setState(() {
        this.is_confirmed = is_confirmed;
      });
      if (is_confirmed) {
        timer.cancel();
      }
    });
    controller = WebViewController()
      ..loadRequest(
        Uri.parse(widget.url),
      );
  }

  @override
  void dispose() {
    if (periodicTimer != null) {
      periodicTimer!.cancel();
    }
    super.dispose();
  }

  Widget renderButton() {
    return CupertinoButton(
        onPressed: () async {
          Navigator.of(context).pop();
          UserStore userStore = Provider.of<UserStore>(context, listen: false);
          await userStore.loadUser();
        },
        child: const Text('Закрыть'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: BAppBar(
          title:
              is_confirmed ? 'Успешно оплачен' : 'Подождите происходит оплата',
          leading: is_confirmed ? renderButton() : const SizedBox.shrink(),
        ),
        body: WebViewWidget(
          controller: controller,
        ));
  }
}
