import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/Const/app_const.dart';
import 'package:flutter_application_1/Const/theme_data.dart';
import 'package:flutter_application_1/Screens/auth/forgot_password.dart';
import 'package:flutter_application_1/Screens/auth/login.dart';
import 'package:flutter_application_1/Screens/auth/register.dart';
import 'package:flutter_application_1/Screens/inner_Screen.dart/product_details.dart';
import 'package:flutter_application_1/Screens/inner_Screen.dart/viewed_recently.dart';
import 'package:flutter_application_1/Screens/inner_Screen.dart/wishlist_screen.dart';
import 'package:flutter_application_1/Screens/orders/orders_screen.dart';
import 'package:flutter_application_1/Screens/search_screen.dart';
import 'package:flutter_application_1/providers/cart_provider.dart';
import 'package:flutter_application_1/providers/order_provider.dart';
import 'package:flutter_application_1/providers/product_provider.dart';
import 'package:flutter_application_1/providers/theme_provider.dart';
import 'package:flutter_application_1/providers/user_provider.dart';
import 'package:flutter_application_1/providers/viewed_prod_provider.dart';
import 'package:flutter_application_1/providers/wishlist_provider.dart';
import 'package:flutter_application_1/root_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<FirebaseApp>(
      future: Firebase.initializeApp(
        options: FirebaseOptions(
          apiKey: AppConst.apiKey,
          appId: AppConst.appId,
          messagingSenderId: AppConst.messagingSenderId,
          projectId: AppConst.projectId,
        ),
      ),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        } else if (snapshot.hasError) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              body: Center(
                child: SelectableText(snapshot.error.toString()),
              ),
            ),
          );
        }

        return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => ThemeProvider()),
            ChangeNotifierProvider(create: (_) => ProductProvider()),
            ChangeNotifierProvider(create: (_) => CartProvider()),
            ChangeNotifierProvider(create: (_) => WishlistProvider()),
            ChangeNotifierProvider(create: (_) => ViewedProdProvider()),
            ChangeNotifierProvider(create: (_) => OrderProvider()),
            ChangeNotifierProvider(create: (_) => UserProvider()),
          ],
          child: Consumer<ThemeProvider>(
            builder: (context, themeProvider, child) {
              return MaterialApp(
                title: 'Ecommerce',
                debugShowCheckedModeBanner: false,
                theme: Styles.themeData(
                  isDarkTheme: themeProvider.getIsDarkTheme,
                  context: context,
                ),
                home: const RootScreen(),
                routes: {
                  ProductDetails.routename: (context) => const ProductDetails(),
                  WishlistScreen.routName: (context) => const WishlistScreen(),
                  ViewedRecently.routename: (context) => const ViewedRecently(),
                  LoginScreen.routeName: (context) => const LoginScreen(),
                  RegisterScreen.routeName: (context) => const RegisterScreen(),
                  ForgotPasswordScreen.routeName: (context) =>
                      const ForgotPasswordScreen(),
                  SearchScreen.routename: (context) => const SearchScreen(),
                  RootScreen.routeName: (context) => const RootScreen(),
                  OrdersScreenFree.routeName: (context) =>
                      const OrdersScreenFree(),
                },
              );
            },
          ),
        );
      },
    );
  }
}
