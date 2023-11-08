import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:taxizakaz/components/BAppBar.dart';
import 'package:webview_flutter/webview_flutter.dart';

class FeedBackPage extends StatefulWidget {
  const FeedBackPage({Key? key}) : super(key: key);

  @override
  State<FeedBackPage> createState() => _FeedBackPageState();
}

class _FeedBackPageState extends State<FeedBackPage> {
  late final WebViewController controller;

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..loadRequest(
        Uri.parse('http://213.171.4.132/feedback/'),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const BAppBar(title: 'Отзыв'),
        body: WebViewWidget(
          controller: controller,
        ));
  }
}
