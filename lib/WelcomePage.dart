import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:taxiflutter/components/BAppBar.dart';
import 'package:taxiflutter/components/StickyErrorHeader.dart';
import 'package:taxiflutter/stores/user-store.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  int sliderIndex = 0;
  PageController pageController = PageController();
  var maskFormatter = MaskTextInputFormatter(
      mask: '(###) ###-##-##',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);

  void _showAlertDialog(BuildContext context) {
    showCupertinoModalPopup<void>(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
          title: CupertinoActivityIndicator(
        color: Theme.of(context).primaryColor,
      )),
    );
  }

  void register() async {
    UserStore userStore = Provider.of<UserStore>(context, listen: false);
    await userStore.register();
    if (userStore.isCanRegister) {
      Navigator.pushNamed(context, '/verify-user');
    }
  }

  @override
  Widget build(BuildContext context) {
    UserStore userStore = Provider.of<UserStore>(context, listen: false);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 600,
                child: PageView(
                    onPageChanged: (int value) {
                      setState(() {
                        sliderIndex = value;
                      });
                    },
                    controller: pageController,
                    pageSnapping: true,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: Column(
                          children: [
                            Image.asset(
                              'assets/welcome-screen/first.png',
                              width: 257,
                              height: 257,
                              fit: BoxFit.cover,
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            const Text(
                              'Заказать такси между городами стало удобнее',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            const Text(
                              'Сервис предзначен для удобного поиска, такси для поездки между городами и асболютно бесплатно для использование',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 14, color: Color(0xFF929292)),
                            ),
                            const SizedBox(
                              height: 45,
                            ),
                            CupertinoButton(
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: const [
                                      Text('Дальше'),
                                      Icon(
                                        CupertinoIcons.chevron_right,
                                        size: 20,
                                      )
                                    ]),
                                onPressed: () {
                                  pageController.nextPage(
                                      duration:
                                          const Duration(milliseconds: 400),
                                      curve: Curves.easeOutQuad);
                                })
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: Column(
                          children: [
                            Image.asset(
                              'assets/welcome-screen/second.png',
                              width: 257,
                              height: 257,
                              fit: BoxFit.cover,
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            const Text(
                              'Полностью отечественный проект',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            const Text(
                              'Сервис создан с нуля чтобы предоставить все возможности для водителя и для пассажира ',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 14, color: Color(0xFF929292)),
                            ),
                            const SizedBox(
                              height: 45,
                            ),
                            CupertinoButton(
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: const [
                                      Text('Дальше'),
                                      Icon(
                                        CupertinoIcons.chevron_right,
                                        size: 20,
                                      )
                                    ]),
                                onPressed: () {
                                  pageController.nextPage(
                                      duration:
                                          const Duration(milliseconds: 400),
                                      curve: Curves.easeOutQuad);
                                })
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(25),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Observer(builder: (context) {
                                return StickyErrorHeader(
                                    error: userStore.errorRegister);
                              }),
                              const SizedBox(
                                width: 240,
                                child: Text(
                                  'Введите ваш номер телефона для входа',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              const SizedBox(
                                height: 25,
                              ),
                              CupertinoTextFormFieldRow(
                                padding: const EdgeInsets.all(0),
                                prefix: Row(
                                  children: const [
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text('+7'),
                                  ],
                                ),
                                onChanged: userStore.onChangePhone,
                                inputFormatters: [maskFormatter],
                                placeholder: '747 005 66 89',
                                validator: (String? value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter a value';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(
                                height: 25,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: CupertinoButton.filled(
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Observer(builder: (context) {
                                                if (userStore
                                                    .isLoadingRegister) {
                                                  return const CupertinoActivityIndicator(
                                                    color: Colors.white,
                                                  );
                                                }
                                                return const SizedBox.shrink();
                                              }),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Text('Поехали'),
                                              const SizedBox(
                                                width: 20,
                                              ),
                                            ]),
                                        onPressed: () {
                                          register();
                                        }),
                                  )
                                ],
                              )
                            ]),
                      )
                    ]),
              ),
              AnimatedSmoothIndicator(
                activeIndex: sliderIndex,
                count: 3,
                effect: ExpandingDotsEffect(
                    dotWidth: 10,
                    dotHeight: 10,
                    activeDotColor: CupertinoTheme.of(context).primaryColor),
              )
            ],
          ),
        ),
      ),
    );
  }
}
