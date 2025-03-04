import 'package:flutter/material.dart';
import 'package:flutter_application_1/Widgets/title_text.dart';
import 'package:shimmer/shimmer.dart';

class AppNameTextWidget extends StatelessWidget {
  final double fontsize;
  const AppNameTextWidget({super.key,  this.fontsize = 18,});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: Colors.purple,
        highlightColor: Colors.redAccent,
       
          child: TitleTextWidgets(label: "NexaMart", 
          fontSize: fontsize,
          ),
        );
  }
}
