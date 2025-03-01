import 'package:flutter/material.dart';
import 'package:flutter_application_1/Screens/cart/cart_bottom_checkout.dart';
import 'package:flutter_application_1/Screens/cart/cart_widgets.dart';
import 'package:flutter_application_1/Widgets/empty_widget_bag.dart';
import 'package:flutter_application_1/Widgets/title_text.dart';
import 'package:flutter_application_1/providers/cart_provider.dart';
import 'package:flutter_application_1/services/assets_manager.dart';
import 'package:flutter_application_1/services/my_app_methods.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});
  final bool isEmpty = false;

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    return cartProvider.getCartitems.isEmpty
        ? Scaffold(
            body: EmptyWidgetBag(
              imagePath: AssetsManager.shoppingBasket,
              title: "Your Cart is Empty",
              subtitle:
                  "Looks like your cart is empty. \n Add Something and make me happy.",
              buttonText: "Shop Now",
            ),
          )
        : Scaffold(
            appBar: AppBar(
              actions: [
                IconButton(
                  onPressed: () {
                    MyAppMethods.showErrorWarningDialog(
                      IsError: false ,
                        context: context,
                        subtitle: "Remove Items",
                        fct: () {
                          cartProvider.clearlocalCart();
                        });
                  },
                  icon: const Icon(
                    IconlyLight.delete,
                    color: Colors.redAccent,
                  ),
                )
              ],
              title: TitleTextWidgets(
                  label: "Cart(${cartProvider.getCartitems.length})"),
              leading: Image.asset(AssetsManager.shoppingCart),
            ),
            body: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cartProvider.getCartitems.length,
                    itemBuilder: (context, index) {
                      return ChangeNotifierProvider.value(
                        value: cartProvider.getCartitems.values
                            .toList()
                            .reversed
                            .toList()[index],
                        child: const CartWidget(),
                      );
                    },
                  ),
                ),
              ],
            ),
            bottomSheet: const CartBottomCheckout(),
          );
  }
}
