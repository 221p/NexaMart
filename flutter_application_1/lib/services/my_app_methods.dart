import 'package:flutter/material.dart';
import 'package:flutter_application_1/Widgets/subtitle_text.dart';
import 'package:flutter_application_1/Widgets/title_text.dart';
import 'package:flutter_application_1/services/assets_manager.dart';

class MyAppMethods {
  static Future<void> showErrorWarningDialog({
    required BuildContext context,
    required String subtitle,
    required Function fct,
    bool IsError = true,
  }) async {
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0)),
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
             
              Image.asset(
                IsError ? AssetsManager.error : AssetsManager.warning,
                height:  60,
                width: 60,
              ),
              const SizedBox(
                height: 16.0,
              ),
              SubtitleTextWidgets(
                label: subtitle,
                fontWeight: FontWeight.w600,
              ),
              const SizedBox(
                height: 16.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Visibility(
                    // visible: IsError,  //Commented because  we want to show cancel button in both cases
                    child: TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child:  SubtitleTextWidgets(
                        label: "Cancel",
                        color: Colors.green,
                      ),
                    ),
                  ),
                  TextButton(
                      onPressed: () {
                        fct();
                        Navigator.pop(context);
                      },
                      child: const SubtitleTextWidgets(
                        label: "ok",
                        color: Colors.redAccent,
                      ),
                      ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
  
  static Future<void> imagePickerDialog({
   required BuildContext context,
    required Function  cameraFCT,
    required Function galleryFCT ,
    required Function  removeFCT,
  })async{
      await showDialog(context: context, builder:(context) {
        return AlertDialog(
          title: const Center(child:  TitleTextWidgets(label: "Choose Option"
          ),
           ),
           content: SingleChildScrollView(
            child: ListBody(
              children: [
                TextButton.icon(
                  onPressed: (){
                    cameraFCT();
                    if(Navigator.canPop(context)){
                      Navigator.pop(context);
                    }
                  },
                   icon: const Icon(Icons.camera) ,
                    label:Text("Camera",
                    ),
                 ),
                TextButton.icon(
                  onPressed: (){
                    galleryFCT();
                    if(Navigator.canPop(context)){
                      Navigator.pop(context);
                    }
                  },
                   icon: const Icon(Icons.image) ,
                    label:Text(
                      "Gallery",
                    ),
                 ),
                TextButton.icon(
                  onPressed: (){
                    removeFCT();
                    if(Navigator.canPop(context)){
                      Navigator.pop(context);
                    }
                  },
                   icon: const Icon(Icons.remove) ,
                    label:Text(
                      "Remove",
                    ),
                 ),
              ],
            ),
           ),
        );
      },
      );
  }
}
