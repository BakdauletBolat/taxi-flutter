// ignore_for_file: file_names, non_constant_identifier_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart'
    show
        BoxDecoration,
        BuildContext,
        Color,
        Colors,
        Column,
        Container,
        CrossAxisAlignment,
        FontWeight,
        GestureDetector,
        Icon,
        IconData,
        Key,
        MainAxisAlignment,
        MediaQuery,
        Row,
        SizedBox,
        StatelessWidget,
        Text,
        TextStyle,
        Theme,
        Widget;

class Select extends StatelessWidget {
  const Select(
      {Key? key,
      this.city_name,
      this.address,
      this.onPress,
      this.placeholder,
      this.value,
      this.onRemove,
      this.iconData})
      : super(key: key);

  final String? city_name;
  final IconData? iconData;
  final String? value;
  final String? address;
  final Function()? onPress;
  final Function()? onRemove;
  final String? placeholder;

  Widget renderText() {
    if (value != null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(value!,
              style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w500))
        ],
      );
    }
    if (city_name != null && address != null && address!.isNotEmpty) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(city_name!,
              style:
                  const TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
          Text(address!)
        ],
      );
    } else if (city_name != null && city_name!.isNotEmpty) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(city_name!,
              style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w500))
        ],
      );
    } else if (address != null && address!.isNotEmpty) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(address!,
              style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w500))
        ],
      );
    }

    return Text(
      placeholder != null ? placeholder! : 'Куда',
      style: const TextStyle(
          color: Color(0xFFC6C6C8), fontSize: 17, fontWeight: FontWeight.w300),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        height: 44,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(iconData, color: Theme.of(context).primaryColor),
                  const SizedBox(
                    width: 5,
                  ),
                  renderText()
                ],
              ),
              Row(children: [
                city_name != null || value != null ? GestureDetector(
                  onTap: onRemove,
                  child: const Icon(
                  CupertinoIcons.xmark_circle,
                  size: 20,
                                ),
                ) : const SizedBox.shrink(),
                const Icon(
                CupertinoIcons.chevron_right,
                size: 20,
              )
              ],)
              
            ]),
      ),
    );
  }
}
