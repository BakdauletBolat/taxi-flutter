import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:taxizakaz/components/BAppBar.dart';
import 'package:taxizakaz/components/NotFoundOrder.dart';
import 'package:taxizakaz/models/profile-model.dart';
import 'package:taxizakaz/stores/user-store.dart';

class ListPaymentsPage extends StatefulWidget {
  const ListPaymentsPage({Key? key}) : super(key: key);

  @override
  State<ListPaymentsPage> createState() => _ListPaymentsPageState();
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
                Text(
                    paymentItem.is_confirmed ? 'Подвержден' : 'На рассмотрений')
              ],
            ),
          ]),
        ),
      ],
    ),
  );
}

class _ListPaymentsPageState extends State<ListPaymentsPage> {
  @override
  void initState() {
    UserStore userStore = Provider.of<UserStore>(context, listen: false);
    userStore.loadUserPayments();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    UserStore userStore = Provider.of<UserStore>(context, listen: false);

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: const BAppBar(title: 'Покупки'),
        body: Observer(builder: (context) {
          if (userStore.userPayments.isEmpty) {
            return const NotFoundOrder();
          }
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
        }));
  }
}
