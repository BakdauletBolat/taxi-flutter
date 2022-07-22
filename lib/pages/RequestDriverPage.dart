import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:taxiflutter/components/BAppBar.dart';
import 'package:taxiflutter/pages/ProfileEditPage.dart';
import 'package:taxiflutter/pages/UploadDocumentsPage.dart';
import 'package:taxiflutter/stores/user-store.dart';

class RequestDriverPage extends StatefulWidget {
  const RequestDriverPage({Key? key}) : super(key: key);

  @override
  State<RequestDriverPage> createState() => _RequestDriverPageState();
}

class _RequestDriverPageState extends State<RequestDriverPage> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    UserStore userStore = Provider.of<UserStore>(context, listen: false);

    Widget renderVerificationStep() {
      return Observer(builder: ((context) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Загрузите документы для верификацию водителя'),
            const SizedBox(
              height: 20,
            ),
            CupertinoButton.filled(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: const Text('Перейти'),
                onPressed: () {
                  var route = CupertinoPageRoute(builder: (context) {
                    return const UploadDocumentsPage();
                  });
                  Navigator.of(context).push(route);
                })
          ],
        );
      }));
    }

    Widget renderProfileInfoStep() {
      return Observer(
        builder: (context) {
          if (userStore.profileNotNull) {
            return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Профиль пользователя успешно заполнен'),
                  const SizedBox(
                    height: 10,
                  ),
                  CupertinoButton.filled(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: const Text('Перейти на следющий шаг'),
                      onPressed: () {
                        setState(() {
                          _index += 1;
                        });
                      })
                ]);
          }

          return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Пожалуйста заполните страницу профиля'),
                const SizedBox(
                  height: 10,
                ),
                CupertinoButton.filled(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: const Text('Заполнить'),
                    onPressed: () {
                      var route = CupertinoPageRoute(builder: (context) {
                        return const ProfileEditPage();
                      });

                      Navigator.of(context).push(route);
                    })
              ]);
        },
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const BAppBar(title: 'Заявка на водителя'),
      body: Stepper(
        type: StepperType.vertical,
        controlsBuilder: (context, details) {
          return const SizedBox.shrink();
        },
        currentStep: _index,
        onStepCancel: () {
          if (_index > 0) {
            setState(() {
              _index -= 1;
            });
          }
        },
        onStepTapped: (int index) {
          if (index == 0 && userStore.profileNotNull) {
            setState(() {
              _index = index;
            });
          }
        },
        onStepContinue: () {
          if (_index <= 0) {
            setState(() {
              _index += 1;
            });
          }
        },
        steps: <Step>[
          Step(
            isActive: _index == 0,
            state: userStore.profileNotNull
                ? StepState.complete
                : StepState.indexed,
            title: const Text('Информация о пользователя'),
            content: Container(
                alignment: Alignment.centerLeft,
                child: renderProfileInfoStep()),
          ),
          Step(
            title: const Text('Верификация авто и водителя'),
            content: Container(
                alignment: Alignment.centerLeft,
                child: renderVerificationStep()),
          ),
        ],
      ),
    );
  }
}
