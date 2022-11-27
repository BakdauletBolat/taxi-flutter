import 'dart:ui';

import 'package:flutter/material.dart';

class NotificationComponent extends StatelessWidget {
  const NotificationComponent(
      {Key? key, this.leftIcon, required this.title, this.description})
      : super(key: key);

  final String title;
  final String? description;
  final Widget? leftIcon;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 0, right: 20, left: 20),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: const Color.fromRGBO(245, 245, 245, 0.8),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
                color: Colors.green, borderRadius: BorderRadius.circular(10)),
            child: const Icon(
              Icons.check,
              color: Colors.white,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
              Builder(builder: (context) {
                if (description != null) {
                  return SizedBox(
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: Text(description!));
                }
                return const SizedBox.shrink();
              }),
            ],
          )
        ],
      ),
    );
  }
}
