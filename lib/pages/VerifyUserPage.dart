import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';
import 'package:taxiflutter/components/BAppBar.dart';
import 'package:taxiflutter/stores/user-store.dart';

class VerifyPage extends StatefulWidget {
  VerifyPage({Key? key}) : super(key: key);

  @override
  State<VerifyPage> createState() => _VerifyPageState();
}

class _VerifyPageState extends State<VerifyPage> {
  TextEditingController textEditingController = TextEditingController();
  String currentText = "";

  StreamController<ErrorAnimationType>? errorController;

  @override
  void initState() {
    errorController = StreamController<ErrorAnimationType>();
    super.initState();
  }

  @override
  void dispose() {
    errorController!.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final String asset_name = 'assets/svg/smart-phone-sms.svg';
    final Widget svgIcon = SvgPicture.asset(asset_name,
        width: 100, semanticsLabel: 'A red up arrow');

    UserStore userStore = Provider.of<UserStore>(context, listen: false);

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: const BAppBar(title: 'Верификация'),
        body: SingleChildScrollView(
          child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 50),
              child: svgIcon,
            ),
            const Padding(
              padding: EdgeInsets.all(20),
              child: Text('Вам сейчас придет сообщение введите их ниже'),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
              child: PinCodeTextField(
                appContext: context,
                length: 4,
                obscureText: true,
                obscuringCharacter: '*',
                blinkWhenObscuring: true,
                animationType: AnimationType.scale,

                pinTheme: PinTheme(
                  selectedColor: Theme.of(context).primaryColor,
                  activeColor: Theme.of(context).primaryColor,
                  inactiveColor: Colors.grey,
                  shape: PinCodeFieldShape.underline,
                  borderRadius: BorderRadius.circular(5),
                  inactiveFillColor: Colors.white,
                  fieldWidth: MediaQuery.of(context).size.width / 6,
                  selectedFillColor: Colors.white,
                  activeFillColor: Colors.white,
                ),
                cursorColor: Colors.black,
                animationDuration: const Duration(milliseconds: 300),
                enableActiveFill: true,
                errorAnimationController: errorController,
                controller: textEditingController,
                keyboardType: TextInputType.number,
                boxShadows: const [
                  BoxShadow(
                    offset: Offset(0, 1),
                    color: Colors.transparent,
                    blurRadius: 10,
                  )
                ],
                onCompleted: userStore.onChangeOtp,
                // onTap: () {
                //   print("Pressed");
                // },
                onChanged: (value) {
                  debugPrint(value);
                  setState(() {
                    currentText = value;
                  });
                },
                beforeTextPaste: (text) {
                  debugPrint("Allowing to paste $text");
                  //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                  //but you can show anything you want here, like your pop up saying wrong paste format or etc
                  return true;
                },
              ),
            ),
            Observer(
              builder: (context) {
                if (userStore.error != null) {
                  return Text(userStore.error!);
                }
                return const SizedBox.shrink();
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Expanded(
                    child: CupertinoButton.filled(
                        child: const Text('Отправить'),
                        onPressed: userStore.verifyUser),
                  ),
                ],
              ),
            )
          ]),
        ));
  }
}
