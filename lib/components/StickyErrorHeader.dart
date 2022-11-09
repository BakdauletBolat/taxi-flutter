// ignore_for_file: file_names

import 'package:flutter/material.dart';

class StickyErrorHeader extends StatelessWidget {
  const StickyErrorHeader({Key? key, this.error}) : super(key: key);

  final String? error;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Builder(builder: (context) {
        return error != null
            ? Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    const Icon(Icons.warning_amber, color: Colors.red),
                    const SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                        width: MediaQuery.of(context).size.width - 150,
                        child: Text(error!)),
                  ],
                ),
              )
            : const SizedBox.shrink();
      }),
    );
  }
}
