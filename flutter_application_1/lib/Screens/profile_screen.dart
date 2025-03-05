import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Screens/auth/login.dart';
import 'package:flutter_application_1/Screens/inner_Screen.dart/viewed_recently.dart';
import 'package:flutter_application_1/Screens/inner_Screen.dart/wishlist_screen.dart';
import 'package:flutter_application_1/Screens/loading_manager.dart';
import 'package:flutter_application_1/Screens/orders/orders_screen.dart';
import 'package:flutter_application_1/Widgets/app_name_text.dart';
import 'package:flutter_application_1/Widgets/custom_list.dart';
import 'package:flutter_application_1/Widgets/subtitle_text.dart';
import 'package:flutter_application_1/Widgets/title_text.dart';
import 'package:flutter_application_1/model/user_model.dart';
import 'package:flutter_application_1/providers/theme_provider.dart';
import 'package:flutter_application_1/providers/user_provider.dart';
import 'package:flutter_application_1/services/assets_manager.dart';
import 'package:flutter_application_1/services/my_app_methods.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
User ? user = FirebaseAuth.instance.currentUser;
bool _isLoading = false; 
UserModel? userModel;

    Future<void> fetchUserInfo() async {
      if(user == null){
        setState(() {
          _isLoading = false;
        });
        return;
      }
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      try{
        userModel = await userProvider.fetchUserInfo();
      }catch(error){
        await MyAppMethods.showErrorWarningDialog(
          context: context,
          subtitle: "an error has been occured $error",
          IsError: true,
          fct: (){},
        );
      }finally{
        setState(() {
          _isLoading = false;
        });
      }
    }

    @override
  void initState() {
   fetchUserInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
        appBar: AppBar(
          // backgroundColor: Colors.blueAccent,
          title: AppNameTextWidget(),
          leading: Image.asset(AssetsManager.shoppingCart),
        ),
        body: LoadingManager(
          isLoading: _isLoading,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Visibility(
                  visible: user == null ? true : false,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: TitleTextWidgets(
                        label: "Please Login to have Ultimate Experience",),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                userModel == null
                 ? const SizedBox.shrink() 
                 : Padding(
                 padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Row(
                    children: [
                      Container(
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Theme.of(context).cardColor,
                          border: Border.all(
                            color: Theme.of(context).colorScheme.background,
                            width: 3,
                          ),
                          image:  DecorationImage(
                            image: NetworkImage(
                             userModel!.userImage,
                            ),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                       Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:[
                          TitleTextWidgets(label: userModel!.userName),
                          SubtitleTextWidgets(label: userModel!.userEmail),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12.0, vertical: 24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TitleTextWidgets(label: "General"),
                      CustomListTile(
                          imagePath: AssetsManager.orderSvg,
                          text: "All Orders",
                          function: () {
                            Navigator.pushNamed(context, OrdersScreenFree.routeName);
                          }),
                      CustomListTile(
                          imagePath: AssetsManager.wishlistSvg,
                          text: "Wishlist",
                          function: () {
                              Navigator.pushNamed(context, WishlistScreen.routName);
                          },
                          ),
                      CustomListTile(
                          imagePath: AssetsManager.recent,
                          text: "Viewed Recently",
                          function: () {
                             Navigator.pushNamed(context, ViewedRecently.routename);
                          },),
                      CustomListTile(
                          imagePath: AssetsManager.address,
                          text: "Address",
                          function: () {}),
                      Divider(
                        thickness: 1,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TitleTextWidgets(label: "Settings"),
                      SwitchListTile(
                        title: Text(themeProvider.getIsDarkTheme
                            ? "Dark Mode"
                            : "Light Mode"),
                        value: themeProvider.getIsDarkTheme,
                        onChanged: (value) {
                          themeProvider.setDarkTheme(themevalue: value);
                        },
                      ),
                      Divider(
                        thickness: 1,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Center(
                        child: ElevatedButton.icon(
                          style:ElevatedButton.styleFrom(
                            backgroundColor: Colors.redAccent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ) ) ,
                          onPressed: () async{
                           if(user == null){
                             Navigator.pushNamed(context, LoginScreen.routeName);
                          }else{
                            await MyAppMethods.showErrorWarningDialog(
                            context: context, 
                            subtitle: "Are You Sure?",
                            
                            IsError: false,
                             fct: () async{
                              await FirebaseAuth.instance.signOut();
                              if(!mounted) return;
                              Navigator.pushNamed(context, LoginScreen.routeName);
                            });
                          }
                          },
            
                         icon: Icon( user == null ? Icons.login : Icons.logout), 
                         label: Text( user == null ? "Login" : "Logout" , ),
                         ),
                         ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
