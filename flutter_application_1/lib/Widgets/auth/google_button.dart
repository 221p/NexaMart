import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/root_screen.dart';
import 'package:flutter_application_1/services/my_app_methods.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:ionicons/ionicons.dart';

class GoogleButton extends StatelessWidget {
  const GoogleButton({super.key});


  Future<void> _googleSignIn({required BuildContext context}) async{
    final googleSignIn = GoogleSignIn();
    final googleAccount = await googleSignIn.signIn();
    if(googleAccount != null){
      final googleAuth = await googleAccount.authentication;
       if(googleAuth.accessToken != null && googleAuth.idToken != null){
         try{
          final authResult = await FirebaseAuth.instance.signInWithCredential(GoogleAuthProvider.credential(
            accessToken: googleAuth.accessToken,
            idToken: googleAuth.idToken
          ));
          if(authResult.additionalUserInfo!.isNewUser){
          
        await FirebaseFirestore.instance.collection("users").doc(authResult.user!.uid).set(
          {
          "userId": authResult.user!.uid,
          "userName": authResult.user!.displayName,
          "userEmail": authResult.user!.email,
          "userImage": authResult.user!.photoURL,
          "createdAt": Timestamp.now(),
          "userCart": [],
          "userWish": [],
        },
        );

          }
          WidgetsBinding.instance.addPostFrameCallback((_) async{
            Navigator.pushReplacementNamed(context, RootScreen.routeName);
          });

         } on FirebaseException catch(error){
           WidgetsBinding.instance.addPostFrameCallback((_) async{
            Navigator.pushReplacementNamed(context, RootScreen.routeName);
         await MyAppMethods.showErrorWarningDialog(
          context: context,
          subtitle: "An error has been Occured ${error.message}",
          fct: (){});
          });
         }catch(error){
             WidgetsBinding.instance.addPostFrameCallback((_) async{
            Navigator.pushReplacementNamed(context, RootScreen.routeName);
         await MyAppMethods.showErrorWarningDialog(
          context: context,
          subtitle: "An error has been Occured $error",
          fct: (){});
          });
       }
    }
  }
  }
  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style:ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(12),
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        )
      ),
      onPressed: (){
        _googleSignIn(context: context);
      },
       icon: const Icon(Ionicons.logo_google,
       color: Colors.red,
       ) ,
        label: Text("Sign in with Google" , style: TextStyle(color: Colors.black),),
        );
  }
}