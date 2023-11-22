// ignore_for_file: file_names

import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:taxizakaz/api/order-service.dart';
import 'package:taxizakaz/dialogs/NotAcceptableDialog.dart';
import 'package:taxizakaz/hooks/showSnackBar.dart';
import 'package:taxizakaz/models/order.dart';
import 'package:taxizakaz/pages/OrderDetailPage.dart';
import 'package:taxizakaz/stores/user-store.dart';
import 'package:url_launcher/url_launcher_string.dart';

class OrderItem extends StatelessWidget {
  OrderItem({Key? key, required this.order, this.visiblePhone = false})
      : super(key: key);

  final Order order;
  final bool visiblePhone;
  final DateFormat dateFormat = DateFormat("dd.MM.yyyy, HH:mm");

  @override
  Widget build(BuildContext context) {
    UserStore userStore = Provider.of<UserStore>(context, listen: false);
    void callToPhone() async {
      userStore.setIsCallToPhone(true);
      OrderService orderService = OrderService();

      bool status = await orderService.getStatusToPhone(
          from_city_id: order.from_city.id!, to_city_id: order.to_city.id!);

      if (status || userStore.user?.type_user == 2) {
        try {
          launchUrlString('tel:${order.user.phone}');
        } catch (e) {
          showSnackBar(context, 'Не верный телефон');
        }
        userStore.setIsCallToPhone(false);
      } else {
        showDialog(
            context: context,
            builder: (context) => NotAcceptableDialog(order: order));
        userStore.setIsCallToPhone(false);
      }
    }

    Widget renderPhone() {
      if (visiblePhone) {
        return const SizedBox.shrink();
      }
      return GestureDetector(
        onTap: callToPhone,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: Container(
            color: Colors.green,
            height: 40,
            width: 40,
            padding: const EdgeInsets.all(7),
            child: Observer(builder: (context) {
              if (userStore.isLoadingCallToPhone) {
                return const CupertinoActivityIndicator(
                  color: Colors.white,
                );
              }
              return const Icon(
                Icons.phone,
                color: Colors.white,
              );
            }),
          ),
        ),
      );
    }

    Widget renderPhoto() {
      if (order.user.user_info?.avatar != null) {
        return Hero(
          transitionOnUserGestures: true,
          tag: order.id,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: ExtendedImage.network(order.user.user_info!.avatar!,
                fit: BoxFit.cover, width: 56, height: 56),
          ),
        );
      }
      return Image.asset('assets/not-found.png', width: 56, height: 56);
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                    onTap: () {
                      var route = MaterialPageRoute(
                          builder: (context) => OrderDetailPage(order: order));
                      Navigator.of(context).push(route);
                    },
                    child: renderPhoto()),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                    width: 80,
                    child: Text(
                      order.user.user_info?.first_name != null
                          ? order.user.user_info!.first_name!
                          : '',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 12),
                      overflow: TextOverflow.ellipsis,
                    )),
                SizedBox(
                    width: 80,
                    child: Text(
                      order.user.user_info?.last_name != null
                          ? order.user.user_info!.last_name!
                          : '',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 12),
                      overflow: TextOverflow.ellipsis,
                    ))
              ],
            ),
            const SizedBox(
              width: 10,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  order.from_city.name,
                  style: const TextStyle(
                      fontSize: 17, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "${order.price.toString()} т",
                  style: const TextStyle(
                      fontSize: 17, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  order.to_city.name,
                ),

                // RatingBarIndicator(
                //   rating: 4,
                //   itemBuilder: (context, index) => const Icon(
                //     Icons.star,
                //     color: Colors.amber,
                //   ),
                //   itemCount: 5,
                //   itemSize: 14,
                // ),
                const SizedBox(
                  height: 10,
                ),
                Builder(builder: (context) {
                  if (order.comment != null && order.comment != '') {
                    return Column(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 1.9,
                          child: Text(order.comment ?? ''),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    );
                  }
                  return const SizedBox.shrink();
                }),
                Text(dateFormat.format(order.date_time)),
              ],
            ),
          ],
        ),
        renderPhone()
      ],
    );
  }
}



class MyOrderItem extends StatelessWidget {
  MyOrderItem({Key? key, required this.order})
      : super(key: key);

  final Order order;
  final DateFormat dateFormat = DateFormat("dd.MM.yyyy, HH:mm");

  @override
  Widget build(BuildContext context) {

    return Container(
      padding: const EdgeInsets.all(20),
      color: order.is_active ? const Color.fromRGBO(91, 73, 151, .3) : const Color.fromRGBO(207,33, 33, 0.3),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            order.from_city.name,
            style: const TextStyle(
                fontSize: 17, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            "${order.price.toString()} т",
            style: const TextStyle(
                fontSize: 17, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            order.to_city.name,
          ),
          const SizedBox(
            height: 10,
          ),
          Builder(builder: (context) {
            if (order.comment != null && order.comment != '') {
              return Column(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 1.9,
                    child: Text(order.comment ?? ''),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              );
            }
            return const SizedBox.shrink();
          }),
          Text(dateFormat.format(order.date_time)),
        ],
      ),
    );
  }
}
