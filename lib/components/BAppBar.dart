import 'package:flutter/material.dart';

class BAppBar extends StatefulWidget implements PreferredSizeWidget {
  const BAppBar({Key? key, required this.title})
      : preferredSize = const Size.fromHeight(42),
        super(key: key);

  @override
  final Size preferredSize;

  final String title;

  @override
  _CustomAppBarState createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<BAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(widget.title,
          style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w600)),
      centerTitle: true,
      elevation: 0,
      foregroundColor: Colors.black,
      backgroundColor: Colors.white,
    );
  }
}
