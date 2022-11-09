// ignore_for_file: file_names

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';
import 'package:taxizakaz/MainPage.dart';
import 'package:taxizakaz/components/BAppBar.dart';
import 'package:taxizakaz/components/StickyErrorHeader.dart';
import 'package:taxizakaz/stores/user-store.dart';

import '../models/profile-model.dart';

class VerifyPage extends StatefulWidget {
  const VerifyPage({Key? key}) : super(key: key);

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
    const String assetName = 'assets/svg/smart-phone-sms.svg';
    final Widget svgIcon =
        SvgPicture.asset(assetName, width: 100, semanticsLabel: 'Sms');

    UserStore userStore = Provider.of<UserStore>(context, listen: false);

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: const BAppBar(title: 'Верификация'),
        body: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Observer(builder: (context) {
              return StickyErrorHeader(
                error: userStore.errorVerify,
              );
            }),
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
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: CupertinoButton.filled(
                      onPressed: () async {
                       Profile? profile = await userStore.verifyUser();

                        if (profile != null) {
                          var route = CupertinoPageRoute(
                              builder: (context) => const MainPage());
                          if (!mounted) return;
                          Navigator.of(context)
                              .pushAndRemoveUntil(route, (route) => false);
                        }
                      },
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Observer(builder: (context) {
                              if (userStore.isLoadingVerify) {
                                return const CupertinoActivityIndicator(
                                  color: Colors.white,
                                );
                              }
                              return const SizedBox.shrink();
                            }),
                            const SizedBox(
                              width: 10,
                            ),
                            const Text('Отправить')
                          ]),
                    ),
                  ),
                ],
              ),
            )
          ]),
        ));
  }
}
