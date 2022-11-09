// ignore_for_file: file_names

import 'package:flutter/material.dart';

class BAppBar extends StatefulWidget implements PreferredSizeWidget {
  const BAppBar(
      {Key? key, required this.title, this.type, this.leading, this.actions})
      : preferredSize = const Size.fromHeight(42),
        super(key: key);

  final String? type;

  @override
  final Size preferredSize;

  final String title;
  final Widget? leading;
  final List<Widget>? actions;

  @override
  CustomAppBarState createState() => CustomAppBarState();
}

class CustomAppBarState extends State<BAppBar> {
  @override
  Widget build(BuildContext context) {
    Color foregroundColor = Colors.black;
    Color backgroundColor = Colors.white;

    if (widget.type == 'transparent') {
      backgroundColor = Theme.of(context).primaryColor;
      foregroundColor = Colors.white;
    }
    return AppBar(
      actions: widget.actions,
      leading: widget.leading,
      title: Text(widget.title,
          style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w600)),
      centerTitle: true,
      elevation: 0,
      foregroundColor: foregroundColor,
      backgroundColor: backgroundColor,
    );
  }
}
