import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class FilePicker extends StatelessWidget {
  FilePicker(
      {Key? key,
      required this.title,
      required this.subtitle,
      this.onPress,
      required this.photo})
      : super(key: key);

  void Function()? onPress;

  XFile? photo;
  String title;
  String subtitle;

  @override
  Widget build(BuildContext context) {
    Widget renderPicker() {
      if (photo != null) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              subtitle,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            ExtendedImage.file(
              File(photo!.path),
              width: MediaQuery.of(context).size.width,
              height: 200,
              borderRadius: BorderRadius.circular(5),
              fit: BoxFit.cover,
            ),
            const SizedBox(
              height: 10,
            ),
            Text('Имя файла: ${photo!.name}')
          ],
        );
      }

      return SizedBox(
        height: 200,
        child: DottedBorder(
          dashPattern: const [6],
          borderType: BorderType.RRect,
          color: Theme.of(context).primaryColor,
          radius: const Radius.circular(5),
          padding: const EdgeInsets.all(10),
          strokeWidth: 1,
          child: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.add_a_photo,
                color: Theme.of(context).primaryColor,
                size: 40,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(title)
            ],
          )),
        ),
      );
    }

    return GestureDetector(
      onTap: onPress,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child:
            Padding(padding: const EdgeInsets.all(10), child: renderPicker()),
      ),
    );
  }
}
