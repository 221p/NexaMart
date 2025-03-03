import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerWidget extends StatelessWidget {
  final XFile? pickedimage;
  final Function function;

  const ImagePickerWidget({super.key, this.pickedimage, required this.function});

  @override
  Widget build(BuildContext context) {

    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: pickedimage == null ? Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(
                  color: Colors.black,
                )
              ),
            ): Image.file(File(
              pickedimage!.path,
            ),
            fit: BoxFit.fill,
            ),
          ),
        ),
        Positioned(
          right: 0,
          bottom: 0,
          child: Material(
          borderRadius: BorderRadius.circular(16.0),
          color: const Color.fromARGB(255, 5, 5, 5),
          child: InkWell(
            splashColor: Colors.redAccent,
            borderRadius: BorderRadius.circular(16.0),
            onTap:() {
              function(); 
            },
            child: const Padding(
              padding:  EdgeInsets.all(8.0),
              child:  Icon(
              Icons.camera_alt,
              size: 20,
              color: Colors.white,
              ),
            ),
          ),
        ),
        ),
      ],
    );
  }
}