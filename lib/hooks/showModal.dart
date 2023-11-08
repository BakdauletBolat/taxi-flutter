import 'package:flutter/cupertino.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

Future showModal(BuildContext context, Widget modalWidget) async {
     return await showCupertinoModalBottomSheet(
      context: context,
      expand: false,
      builder: (context) => modalWidget,
    );
  }