import 'package:flutter/material.dart';
import 'package:flutter_application_1/Screens/search_screen.dart';
import 'package:flutter_application_1/Widgets/subtitle_text.dart';

class CategoryRoundedWidgets extends StatelessWidget {
  final String name, image;
  const CategoryRoundedWidgets(
      {super.key, required this.name, required this.image});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context, SearchScreen.routename,
           arguments: name,
           );
      },
      child: Column(
        children: [
          Image.asset(
            image,
            height: 50,
            width: 52,
          ),
          SubtitleTextWidgets(
            label: name,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ],
      ),
    );
  }
}
