import 'package:flutter/material.dart';

class BAppBar extends StatefulWidget implements PreferredSizeWidget {
  const BAppBar({Key? key, required this.title, this.type})
      : preferredSize = const Size.fromHeight(42),
        super(key: key);

  final String? type;

  @override
  final Size preferredSize;

  final String title;

  @override
  _CustomAppBarState createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<BAppBar> {
  @override
  Widget build(BuildContext context) {
    Color foregroundColor = Colors.black;
    Color backgroundColor = Colors.white;

    if (widget.type == 'transparent') {
      backgroundColor = Colors.transparent;
      foregroundColor = Colors.white;
    }
    return AppBar(
      title: Text(widget.title,
          style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w600)),
      centerTitle: true,
      elevation: 0,
      foregroundColor: foregroundColor,
      backgroundColor: backgroundColor,
    );
  }
}
