// ignore_for_file: file_names

import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:taxizakaz/models/profile-model.dart';
import 'package:taxizakaz/stores/user-store.dart';
import 'package:url_launcher/url_launcher.dart';

class SuccessPaymentPage extends StatefulWidget {
  const SuccessPaymentPage({Key? key, required this.payment}) : super(key: key);

  final Payment payment;

  @override
  State<SuccessPaymentPage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<SuccessPaymentPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    UserStore userStore = Provider.of<UserStore>(context);

    return Scaffold(
        backgroundColor: Colors.white,
        // extendBodyBehindAppBar: true,

        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 90,
              ),
              Lottie.asset('assets/lottie/success.json', height: 200),
              const SizedBox(
                height: 30,
              ),
              const Text(
                'Платеж успешно создан',
                style: TextStyle(fontSize: 12),
              ),
              const SizedBox(
                height: 30,
              ),
              Text(
                '${widget.payment.coin} тг',
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 30,
              ),
              const SizedBox(
                width: 229,
                child: Text(
                  'Отправьте платеж через каспи переводы, в коментарий введите номер заказа внизу',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Color(0xFF8E8E8E)),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '#${widget.payment.gen_id}',
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  TextButton(
                      onPressed: () => {}, child: const Text('Копировать'))
                ],
              ),
              const SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CupertinoButton(
                      color: CupertinoColors.systemRed,
                      child: const Text('Перейти в Kaspi'),
                      onPressed: () async {
                        Uri url = Uri.parse('https://dz3a4.app.goo.gl/dNzt');
                        if (await canLaunchUrl(url)) {
                          await launchUrl(url);
                        } else
                          log('not open');
                      })
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CupertinoButton.filled(
                      child: const Text('К платежам'),
                      onPressed: () async {
                        userStore.loadUserPayments();
                        Navigator.of(context).pop();
                      })
                ],
              )
            ],
          ),
        ));
  }
}
