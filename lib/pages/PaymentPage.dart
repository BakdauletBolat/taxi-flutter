// ignore_for_file: file_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:taxizakaz/components/BAppBar.dart';
import 'package:taxizakaz/components/FreedomPay.dart';
import 'package:taxizakaz/components/NotFoundOrder.dart';
import 'package:taxizakaz/models/profile-model.dart';
import 'package:taxizakaz/pages/MessagePage.dart';
import 'package:taxizakaz/pages/Paymants/ListPaymantsPage.dart';
import 'package:taxizakaz/pages/Profile/UserOrdersPage.dart';
import 'package:taxizakaz/pages/PaymentDetailPage.dart';
import 'package:taxizakaz/stores/user-store.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({Key? key, this.coin}) : super(key: key);

  final int? coin;

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

  void routeToMessagePage() {
    var route = CupertinoPageRoute(builder: (context) => const MessagePage());
    Navigator.of(context).push(route);
  }

  bool isLoading = false;

  Future<String> openSecondModal(String url, int order_id) async {
    var res = await showCupertinoModalBottomSheet(
      enableDrag: false,
      context: context,
      useRootNavigator: true,
      expand: false,
      builder: (context) => FreedomPay(url: url, order_id: order_id),
    );
    // var route = CupertinoPageRoute(
    //           builder: (context) => SuccessPaymentPage(payment: payment));
    //       await Navigator.of(context).push(route);
    return res.toString();
  }

  @override
  Widget build(BuildContext context) {
    UserStore userStore = Provider.of<UserStore>(context);

    TextEditingController coinController = TextEditingController(
        text: widget.coin != null ? widget.coin.toString() : '');
    final _formKey = GlobalKey<FormState>();

    Future submitCreatePayment() async {
      if (_formKey.currentState!.validate()) {
        dynamic payment = await userStore.createPayment(
            userStore.user!.id!, coinController.text);
        if (payment != null && mounted) {
          openSecondModal(payment['link'],payment['payment_order_id']);
          coinController.text = '0';
        }
      }
    }

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: BAppBar(
          title: 'Кабинет',
          actions: [
            IconButton(
                onPressed: routeToMessagePage, icon: const Icon(Icons.send))
          ],
        ),
        body: RefreshIndicator(
          onRefresh: userStore.loadUser,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 30,
                ),
                userStore.user?.type_user == 1 ? Observer(builder: (context) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Icon(
                            Icons.attach_money_rounded,
                            size: 30,
                            color: Theme.of(context).primaryColor,
                          ),
                          Text(
                            "${userStore.user?.coins!.toString() ?? '0'}₸",
                            style: const TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
                          ),
                          const Text('Баланс')
                        ],
                      ),
                      const SizedBox(
                        width: 50,
                      ),
                      Column(
                        children: [
                          Icon(
                            Icons.watch_later_outlined,
                            size: 30,
                            color: Theme.of(context).primaryColor,
                          ),
                          Text(
                            "${userStore.user?.coins_expected!.toString() ?? '0'}₸",
                            style: const TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
                          ),
                          const Text('Ожидается')
                        ],
                      ),
                    ],
                  );
                }) : const SizedBox.shrink(),
                const SizedBox(
                  height: 30,
                ),
                userStore.user?.type_user == 1 ? Form(
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
                    prefix: Icon(Icons.wallet,
                        color: Theme.of(context).primaryColor),
                  ),
                ) : const SizedBox.shrink(),
                const SizedBox(
                  height: 25,
                ),
                userStore.user?.type_user == 1 ? Row(
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
                ) : const SizedBox.shrink(),
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
                Column(
                  children: [
                    ListTile(
                      onTap: () {
                        var route = CupertinoPageRoute(
                            builder: (context) => const UserOrdersPage());
                        Navigator.of(context).push(route);
                      },
                      enableFeedback: true,
                      visualDensity: VisualDensity.comfortable,
                      trailing: const Icon(Icons.keyboard_arrow_right_rounded),
                      title: const Text('Заказы',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                    ),
                    userStore.user?.type_user == 1 ? ListTile(
                      onTap: () {
                        var route = CupertinoPageRoute(
                            builder: (context) => const ListPaymentsPage());
                        Navigator.of(context).push(route);
                      },
                      enableFeedback: true,
                      visualDensity: VisualDensity.comfortable,
                      trailing: const Icon(Icons.keyboard_arrow_right_rounded),
                      title: const Text('Покупки',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                    ) : const SizedBox.shrink(),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
