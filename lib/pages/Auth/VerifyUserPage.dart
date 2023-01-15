// ignore_for_file: file_names

import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';
import 'package:taxizakaz/MainPage.dart';
import 'package:taxizakaz/components/BAppBar.dart';
import 'package:taxizakaz/components/StickyErrorHeader.dart';
import 'package:taxizakaz/hooks/showSnackBar.dart';
import 'package:taxizakaz/stores/user-store.dart';

import '../../models/profile-model.dart';

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

  bool validatePinCode({String? otp}) {
    if (otp == null || otp.isEmpty || otp.length != 4) {
      showSnackBar(context, 'Введите код сверху');
      return false;
    }
    return true;
  }

  void navigateToMainPage() {
    if (!mounted) return;
    Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
  }

  void onVerifyClicked() async {
    UserStore userStore = Provider.of<UserStore>(context, listen: false);
    bool status = validatePinCode(otp: userStore.otp);
    if (!status) return;
    try {
      await userStore.verifyUser();
      navigateToMainPage();
    } on DioError catch (e) {
      if (e.response != null) {
        showSnackBar(context, 'Код неверный');
      }
    } catch (e) {
      showSnackBar(context, e.toString());
    }
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
                onChanged: userStore.onChangeOtp,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: CupertinoButton.filled(
                      onPressed: onVerifyClicked,
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
