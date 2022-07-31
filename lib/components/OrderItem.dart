import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:taxiflutter/models/order.dart';
import 'package:taxiflutter/stores/user-store.dart';

class OrderItem extends StatelessWidget {
  OrderItem({Key? key, required this.order}) : super(key: key);

  final Order order;
  final DateFormat dateFormat = DateFormat("dd MMMM yyyy, HH:mm");

  @override
  Widget build(BuildContext context) {
    UserStore userStore = Provider.of<UserStore>(context, listen: false);
    Widget renderPhoto() {
      if (order.user.profile_info?.avatar != null) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: ExtendedImage.network(order.user.profile_info!.avatar!,
              fit: BoxFit.cover, width: 56, height: 56),
        );
      }
      return Image.asset('assets/profile-photo.png', width: 56, height: 56);
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
                renderPhoto(),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                    width: 80,
                    child: Text(
                      order.user.profile_info?.first_name != null
                          ? order.user.profile_info!.first_name!
                          : '',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 12),
                      overflow: TextOverflow.ellipsis,
                    )),
                SizedBox(
                    width: 80,
                    child: Text(
                      order.user.profile_info?.last_name != null
                          ? order.user.profile_info!.last_name!
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
                const SizedBox(
                  height: 10,
                ),
                RatingBarIndicator(
                  rating: 4,
                  itemBuilder: (context, index) => const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  itemCount: 5,
                  itemSize: 14,
                ),
                const SizedBox(
                  height: 10,
                ),
                Builder(builder: (context) {
                  if (order.comment != null) {
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
        GestureDetector(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Container(
              color: Colors.green,
              padding: const EdgeInsets.all(7),
              child: const Icon(
                Icons.phone,
                color: Colors.white,
              ),
            ),
          ),
        )
      ],
    );
  }
}
