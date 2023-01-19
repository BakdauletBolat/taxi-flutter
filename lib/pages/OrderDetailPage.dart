import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/svg.dart';
import 'package:taxizakaz/components/ListTile.dart';
import 'package:taxizakaz/components/OrderItem.dart';
import 'package:taxizakaz/models/order.dart';

class OrderDetailPage extends StatefulWidget {
  const OrderDetailPage({Key? key, required this.order}) : super(key: key);

  final Order order;
  @override
  State<OrderDetailPage> createState() => _OrderDetailPageState();
}

class _OrderDetailPageState extends State<OrderDetailPage> {
  Widget renderCar() {
    return Text(
        '${widget.order.user.user_document?.car?.car.name ?? ''}: ${widget.order.user.user_document?.car?.model.name ?? ''}');
  }

  Widget renderCarNumber() {
    return Text('${widget.order.user.user_document?.car?.number}');
  }

  @override
  Widget build(BuildContext context) {
    final svgIcon = Image.asset('assets/icons/car.png');
    return Scaffold(
        body: Stack(
      children: [
        Hero(
          transitionOnUserGestures: true,
          tag: widget.order.id,
          child: ExtendedImage.network(
            widget.order.user.user_info!.avatar!,
            height: 310,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
          ),
        ),
        SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 300,
              ),
              Container(
                height: 1000,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 10, color: Colors.black.withOpacity(0.3))
                    ],
                    borderRadius: BorderRadius.circular(15)),
                child: Column(children: [
                  Container(
                    height: 60,
                    width: 60,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(60)),
                    child: svgIcon,
                  ),
                  ListTile(
                      title: const Text('ФИО'),
                      subtitle: Text(
                          '${widget.order.user.user_info?.first_name ?? ''} ${widget.order.user.user_info?.last_name ?? ''}')),
                  ListTile(title: const Text('Машина'), subtitle: renderCar()),
                  ListTile(
                      title: const Text('Номер машины'),
                      subtitle: renderCarNumber()),
                  ListTile(
                      title: const Text('От'),
                      subtitle: Text(
                          '${widget.order.from_city.name} ${widget.order.from_address ?? ''}')),
                  ListTile(
                      title: const Text('До'),
                      subtitle: Text(
                          '${widget.order.to_city.name} ${widget.order.to_address ?? ''}'))
                ]),
              )
            ],
          ),
        )
      ],
    ));
  }
}
