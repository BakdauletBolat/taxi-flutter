import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:taxizakaz/components/BAppBar.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SupportPage extends StatefulWidget {
  const SupportPage({Key? key}) : super(key: key);

  @override
  State<SupportPage> createState() => _SupportPageState();
}

class _SupportPageState extends State<SupportPage> {
  late final WebViewController controller;

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..loadRequest(
        Uri.parse('https://zakaz-taxi.kz/documents/'),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const BAppBar(title: 'Документы'),
        body: WebViewWidget(
          controller: controller,
        ));
  }
}
