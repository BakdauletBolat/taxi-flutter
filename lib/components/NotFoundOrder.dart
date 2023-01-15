import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/svg.dart';

class NotFoundOrder extends StatelessWidget {
  const NotFoundOrder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(
          height: 50,
        ),
        SvgPicture.asset('assets/svg/order.svg'),
        const SizedBox(
          height: 30,
        ),
        const SizedBox(
            width: 200,
            child: Text(
              'К сожалению по этим направлением нету заказов',
              textAlign: TextAlign.center,
            )),
        const SizedBox(
          height: 50,
        ),
      ],
    );
  }
}
