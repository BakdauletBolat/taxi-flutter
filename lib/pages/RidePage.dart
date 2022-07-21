import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:taxiflutter/components/BAppBar.dart';
import 'package:taxiflutter/components/ListTile.dart';
import 'package:taxiflutter/components/Select.dart';

class RidePage extends StatefulWidget {
  const RidePage({Key? key}) : super(key: key);

  @override
  State<RidePage> createState() => _RidePageState();
}

class _RidePageState extends State<RidePage> {
  void openSecondModal() {
    showCupertinoModalBottomSheet(
      context: context,
      expand: false,
      builder: (context) => Scaffold(
          backgroundColor: Colors.white,
          appBar: const BAppBar(title: 'Напишите место откуда вас забрать'),
          body: SingleChildScrollView(
            child: Column(children: [
              const Padding(
                padding: EdgeInsets.all(20),
                child: CupertinoTextField(
                  placeholder: 'Айбергенова 5А',
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: CupertinoButton.filled(
                    child: const Text('Подтвердить'), onPressed: () {}),
              )
            ]),
          )),
    );
  }

  void openModal() {
    showCupertinoModalBottomSheet(
      context: context,
      expand: false,
      builder: (context) => Scaffold(
          backgroundColor: Colors.white,
          appBar: const BAppBar(title: 'Выберите город'),
          body: SingleChildScrollView(
            child: Column(children: [
              const Padding(
                padding: EdgeInsets.all(20),
                child: CupertinoSearchTextField(
                  placeholder: 'Искать',
                ),
              ),
              ListView.builder(
                  itemCount: 100,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: openSecondModal,
                      child: const BListTile(
                        region_name: 'Межгород',
                        city_name: 'Шымкент',
                      ),
                    );
                  })
            ]),
          )),
    );
  }

  String? city_name_from = 'Шымкент';
  String? address_from = 'Aibergenova 5A';

  String? city_name_to = 'Аламаты';
  String? address_to = 'Бейбитшилик';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: BAppBar(title: 'Попутки'),
      body: SingleChildScrollView(
          child: Column(
        children: [
          Select(
            iconData: Icons.directions,
            onPress: openModal,
            city_name: city_name_from,
            address: address_from,
          ),
          Select(
            iconData: Icons.place,
            onPress: openModal,
            placeholder: 'Туда',
            city_name: city_name_to,
            address: address_to,
          ),
          Select(
            iconData: Icons.calendar_month,
            placeholder: 'Выезд',
            onPress: () {
              DatePicker.showDatePicker(context, showTitleActions: true,
                  onChanged: (date) {
                print('change $date');
              }, onConfirm: (date) {
                print('confirm $date');
              }, currentTime: DateTime.now(), locale: LocaleType.ru);
            },
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset('assets/profile-photo.png'),
                    const SizedBox(
                      width: 15,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Шымкент',
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text('Алматы'),
                        const SizedBox(
                          height: 10,
                        ),
                        RatingBarIndicator(
                          rating: 4,
                          itemBuilder: (context, index) => const Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          itemCount: 5,
                          itemSize: 14,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text('Комментарий'),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text('12 июля 2022, 15:40'),
                      ],
                    ),
                  ],
                ),
                GestureDetector(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Container(
                      color: Colors.green,
                      padding: const EdgeInsets.all(10),
                      child: const Icon(
                        Icons.phone,
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset('assets/profile-photo.png'),
                    const SizedBox(
                      width: 15,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Шымкент',
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text('Алматы'),
                        const SizedBox(
                          height: 10,
                        ),
                        RatingBarIndicator(
                          rating: 4,
                          itemBuilder: (context, index) => const Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          itemCount: 5,
                          itemSize: 14,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text('Комментарий'),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text('12 июля 2022, 15:40'),
                      ],
                    ),
                  ],
                ),
                GestureDetector(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Container(
                      color: Colors.green,
                      padding: const EdgeInsets.all(10),
                      child: const Icon(
                        Icons.phone,
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset('assets/profile-photo.png'),
                    const SizedBox(
                      width: 15,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Шымкент',
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text('Алматы'),
                        const SizedBox(
                          height: 10,
                        ),
                        RatingBarIndicator(
                          rating: 4,
                          itemBuilder: (context, index) => const Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          itemCount: 5,
                          itemSize: 14,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text('Комментарий'),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text('12 июля 2022, 15:40'),
                      ],
                    ),
                  ],
                ),
                GestureDetector(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Container(
                      color: Colors.green,
                      padding: const EdgeInsets.all(10),
                      child: const Icon(
                        Icons.phone,
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset('assets/profile-photo.png'),
                    const SizedBox(
                      width: 15,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Шымкент',
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text('Алматы'),
                        const SizedBox(
                          height: 10,
                        ),
                        RatingBarIndicator(
                          rating: 4,
                          itemBuilder: (context, index) => const Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          itemCount: 5,
                          itemSize: 14,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text('Комментарий'),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text('12 июля 2022, 15:40'),
                      ],
                    ),
                  ],
                ),
                GestureDetector(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Container(
                      color: Colors.green,
                      padding: const EdgeInsets.all(10),
                      child: const Icon(
                        Icons.phone,
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset('assets/profile-photo.png'),
                    const SizedBox(
                      width: 15,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Шымкент',
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text('Алматы'),
                        const SizedBox(
                          height: 10,
                        ),
                        RatingBarIndicator(
                          rating: 4,
                          itemBuilder: (context, index) => const Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          itemCount: 5,
                          itemSize: 14,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text('Комментарий'),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text('12 июля 2022, 15:40'),
                      ],
                    ),
                  ],
                ),
                GestureDetector(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Container(
                      color: Colors.green,
                      padding: const EdgeInsets.all(10),
                      child: const Icon(
                        Icons.phone,
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      )),
    );
  }
}
