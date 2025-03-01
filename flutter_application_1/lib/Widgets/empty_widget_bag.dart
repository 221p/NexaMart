import 'package:flutter/material.dart';
import 'package:flutter_application_1/Widgets/subtitle_text.dart';
import 'package:flutter_application_1/Widgets/title_text.dart';



class EmptyWidgetBag extends StatelessWidget {
  final String imagePath, title, subtitle, buttonText;
  const EmptyWidgetBag({super.key, 
  required this.imagePath,
  required this.title,
  required this.subtitle, 
  required this.buttonText});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 50),
        child: Column(
          children: [
            Image.asset(
              imagePath,
              height: size.height * 0.35,
              width: double.infinity,
            ),
            TitleTextWidgets(
              label: "Whoops",
              fontSize: 40,
              color: Colors.redAccent,
            ),
            SizedBox(
              height: 20,
            ),
            SubtitleTextWidgets(
              label: title,
              fontWeight: FontWeight.w600,
              fontSize: 25,
            ),
            SizedBox(
              height: 20,
            ),
            SubtitleTextWidgets(
              label:subtitle,
              fontWeight: FontWeight.w400,
              fontSize: 20,
            ),
            SizedBox(
              height: 30,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.all(20),
              ),
              onPressed: () {
                // Navigator.pushNamed(context, RootScreen.routeName);
              },
              child: Text(
                buttonText,
                style: TextStyle(fontSize: 22),
              ),
            )
          ],
        ),
      ),
    );
  }
}
