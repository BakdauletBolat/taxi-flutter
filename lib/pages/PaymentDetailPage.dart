// ignore_for_file: file_names

import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:taxizakaz/api/user-service.dart';
import 'package:taxizakaz/components/BAppBar.dart';
import 'package:taxizakaz/components/FreedomPay.dart';
import 'package:taxizakaz/models/profile-model.dart';
import 'package:taxizakaz/stores/user-store.dart';
import 'package:url_launcher/url_launcher.dart';

class PaymentDetailPage extends StatefulWidget {
  PaymentDetailPage({Key? key, required this.payment}) : super(key: key);

  Payment payment;

  @override
  State<PaymentDetailPage> createState() => _PaymentDetailPageState();
}

class _PaymentDetailPageState extends State<PaymentDetailPage> {
  @override
  void initState() {
    super.initState();
  }

  Future<String> openSecondModal(String url, int order_id) async {
    var res = await showCupertinoModalBottomSheet(
      context: context,
      expand: false,
      builder: (context) => FreedomPay(url: url, order_id: order_id),
    );
    // var route = CupertinoPageRoute(
    //           builder: (context) => SuccessPaymentPage(payment: payment));
    //       await Navigator.of(context).push(route);
    return res.toString();
  }

  Future<void> updatePayment() async {
    Payment? newPayment = await UserService().getPayment(widget.payment.id);
    if (newPayment == null) {
      return;
    }
    setState(() {
      widget.payment = newPayment;
    });
  }

  @override
  Widget build(BuildContext context) {
    UserStore userStore = Provider.of<UserStore>(context);

    Future openNewPaymentModal() async {
      String? url = await userStore.updatePayment(widget.payment.gen_id);
      if (url != null && mounted) {
        openSecondModal(url, widget.payment.id);
      }
    }

    return Scaffold(
        appBar: BAppBar(title: "Платеж #${widget.payment.gen_id}"),
        backgroundColor: Colors.white,
        // extendBodyBehindAppBar: true,
        body: RefreshIndicator(
          onRefresh: updatePayment,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              children: [
                const SizedBox(
                  height: 90,
                ),
                widget.payment.is_confirmed
                    ? Lottie.asset('assets/lottie/success.json',
                        height: 200, animate: true)
                    : Lottie.asset('assets/lottie/warning.json', height: 200),
                const SizedBox(
                  height: 30,
                ),
                Text(
                  widget.payment.is_confirmed
                      ? 'Успешно оплачено'
                      : 'Ожидает оплаты',
                  style: const TextStyle(fontSize: 12),
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
                const SizedBox(
                  height: 20,
                ),
                !widget.payment.is_confirmed
                    ? Padding(
                        padding: const EdgeInsets.all(20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: CupertinoButton.filled(
                                  child: const Text('Оплатить'),
                                  onPressed: () async {
                                    openNewPaymentModal();
                                  }),
                            )
                          ],
                        ),
                      )
                    : const SizedBox.shrink(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CupertinoButton(
                        child: const Text('К платежам'),
                        onPressed: () async {
                          userStore.loadUserPayments();
                          Navigator.of(context).pop();
                        })
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
