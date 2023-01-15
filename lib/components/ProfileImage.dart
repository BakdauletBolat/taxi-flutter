import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:taxizakaz/stores/user-store.dart';

class ProfileImage extends StatelessWidget {
  const ProfileImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserStore userStore = Provider.of<UserStore>(context, listen: false);
    return ClipRRect(
      borderRadius: BorderRadius.circular(142),
      child: Observer(builder: (context) {
        if (userStore.user?.user_info?.avatar == null) {
          return Image.asset(
            'assets/not-found.png',
            width: 142,
            height: 142,
            fit: BoxFit.cover,
          );
        }
        return ExtendedImage.network(
          userStore.user?.user_info?.avatar ??
              'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8bWVufGVufDB8fDB8fA%3D%3D&w=1000&q=80',
          width: 142,
          height: 142,
          fit: BoxFit.cover,
        );
      }),
    );
  }
}
