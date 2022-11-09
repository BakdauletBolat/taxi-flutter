// ignore_for_file: file_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:taxizakaz/components/BAppBar.dart';
import 'package:taxizakaz/models/profile-model.dart';
import 'package:taxizakaz/pages/SuccessPaymentPage.dart';
import 'package:taxizakaz/stores/user-store.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({Key? key}) : super(key: key);

  @override
  State<PaymentPage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<PaymentPage> {
  @override
  void initState() {
    UserStore userStore = Provider.of<UserStore>(context, listen: false);
    userStore.loadUserPayments();
    super.initState();
  }

  Widget renderPaymentItem(Payment paymentItem) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 11),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
                color: paymentItem.is_confirmed
                    ? Colors.green
                    : const Color.fromARGB(255, 253, 238, 101),
                borderRadius: BorderRadius.circular(10)),
            child: Icon(
              paymentItem.is_confirmed ? Icons.check : Icons.timelapse,
              color: Colors.white,
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Expanded(
            child: Column(mainAxisSize: MainAxisSize.max, children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '#${paymentItem.gen_id.toString()}',
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(DateFormat('yyyy.MM.d').format(paymentItem.created_at))
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('${paymentItem.coin.toString()} тг'),
                  Text(paymentItem.is_confirmed
                      ? 'Подвержден'
                      : 'На рассмотрений')
                ],
              ),
            ]),
          ),
        ],
      ),
    );
  }

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    UserStore userStore = Provider.of<UserStore>(context);

    TextEditingController coinController = TextEditingController();
    final _formKey = GlobalKey<FormState>();

    Future submitCreatePayment() async {
      if (_formKey.currentState!.validate()) {
        Payment? payment = await userStore.createPayment(
            userStore.profile!.id!, coinController.text);

        if (payment != null && mounted) {
          var route = CupertinoPageRoute(
              builder: (context) => SuccessPaymentPage(payment: payment));
          await Navigator.of(context).push(route);
          coinController.text = '0';
        }
      }
    }

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: const BAppBar(
          title: 'Платежи',
          type: 'transparent',
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              Form(
                key: _formKey,
                child: CupertinoTextFormFieldRow(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  placeholder: 'Сумма',
                  controller: coinController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Обязтельно';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.number,
                  prefix:
                      Icon(Icons.wallet, color: Theme.of(context).primaryColor),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Observer(builder: (context) {
                if (userStore.error != null) {
                  return Column(
                    children: [
                      Text(userStore.error.toString()),
                      const SizedBox(
                        height: 25,
                      ),
                    ],
                  );
                }
                return const SizedBox.shrink();
              }),
              Row(
                children: [
                  Expanded(
                    child: Observer(builder: (context) {
                      return CupertinoButton.filled(
                          onPressed: submitCreatePayment,
                          child: Text(userStore.isLoadingCreatePayment == true
                              ? 'Загрузка'
                              : 'Оплатить'));
                    }),
                  ),
                ],
              ),
              const SizedBox(
                height: 35,
              ),
              const Text(
                'История заказов',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Observer(builder: (context) {
                if (userStore.isLoadingPayments) {
                  return const SizedBox(
                    height: 200,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
                return ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: userStore.userPayments.length,
                    itemBuilder: (_, index) =>
                        renderPaymentItem(userStore.userPayments[index]));
              })
            ],
          ),
        ));
  }
}
