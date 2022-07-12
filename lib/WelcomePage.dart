import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
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

  void handleLogin() {
    UserStore userStore = Provider.of<UserStore>(context, listen: false);
    userStore.changeIsAuth();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
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
                          style:
                              TextStyle(fontSize: 14, color: Color(0xFF929292)),
                        ),
                        const SizedBox(
                          height: 45,
                        ),
                        CupertinoButton(
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: const [
                                  Text('Дальше'),
                                  Icon(
                                    CupertinoIcons.chevron_right,
                                    size: 20,
                                  )
                                ]),
                            onPressed: () {
                              pageController.nextPage(
                                  duration: const Duration(milliseconds: 400),
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
                          style:
                              TextStyle(fontSize: 14, color: Color(0xFF929292)),
                        ),
                        const SizedBox(
                          height: 45,
                        ),
                        CupertinoButton(
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: const [
                                  Text('Дальше'),
                                  Icon(
                                    CupertinoIcons.chevron_right,
                                    size: 20,
                                  )
                                ]),
                            onPressed: () {
                              pageController.nextPage(
                                  duration: const Duration(milliseconds: 400),
                                  curve: Curves.easeOutQuad);
                            })
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(25),
                    child: Column(children: [
                      const SizedBox(
                        width: 200,
                        child: Text(
                          'Введите ваш номер телефона для входа',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      CupertinoTextFormFieldRow(
                        padding: const EdgeInsets.all(0),
                        prefix: Row(
                          children: const [
                            // ClipRRect(
                            //     borderRadius: BorderRadius.circular(5),
                            //     child: Image.asset(
                            //         'assets/welcome-screen/kaz.png')),
                            SizedBox(
                              width: 10,
                            ),
                            Text('+7'),
                          ],
                        ),
                        inputFormatters: [maskFormatter],
                        placeholder: '700 000 00 00',
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
                                child: const Text('Поехали'),
                                onPressed: handleLogin),
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
    );
  }
}
