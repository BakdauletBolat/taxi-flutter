import 'package:flutter/material.dart';

SnackBar buildErrorSnackBar({String? message}) {
  return SnackBar(backgroundColor: Colors.red, content: Text(message ?? ''));
}

SnackBar buildSuccessSnackBar({String? message}) {
  return SnackBar(content: Text(message ?? ''));
}

void showSnackBar(BuildContext context, String? message) {
  ScaffoldMessenger.of(context)
      .showSnackBar(buildErrorSnackBar(message: message));
}

void showSuccessSnackBar(BuildContext context, String? message) {
  ScaffoldMessenger.of(context)
      .showSnackBar(buildSuccessSnackBar(message: message));
}
