import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

void showCustomDialog(BuildContext context, widget) {
  showDialog(
      context: context,
      builder: (context) {
        return widget;
      });
}
