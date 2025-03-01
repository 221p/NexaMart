import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Widgets/empty_widget_bag.dart';
import 'package:flutter_application_1/Widgets/product/product_widgets.dart';
import 'package:flutter_application_1/Widgets/title_text.dart';
import 'package:flutter_application_1/providers/wishlist_provider.dart';
import 'package:flutter_application_1/services/assets_manager.dart';
import 'package:flutter_application_1/services/my_app_methods.dart';
import 'package:provider/provider.dart';


class WishlistScreen extends StatelessWidget {
  static const routName = "/WishlistScreen";
  const WishlistScreen({super.key});
  final bool isEmpty = true;
  @override
  Widget build(BuildContext context) {
    final wishlistProvider = Provider.of<WishlistProvider>(context);

    return wishlistProvider.getWishlistItems.isEmpty
        ? Scaffold(
            body: EmptyWidgetBag(
              imagePath: AssetsManager.shoppingBasket,
              title: "Nothing in ur wishlist yet",
              subtitle:
                  "Looks like your cart is empty add something and make me happy",
              buttonText: "Shop now",
            ),
          )
        : Scaffold(
            appBar: AppBar(
               title: TitleTextWidgets(
                  label: "Wishlist (${wishlistProvider.getWishlistItems.length})"),
              leading: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  AssetsManager.shoppingCart,
                ),
              ),
             
              actions: [
                IconButton(
                  onPressed: () {
                    MyAppMethods.showErrorWarningDialog(
                      IsError: false,
                      context: context,
                      subtitle: "Clear Wishlist?",
                      fct: () {
                        wishlistProvider.clearLocalWishlist();
                      },
                    );
                  },
                  icon: const Icon(
                    Icons.delete_forever_rounded,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
            body: DynamicHeightGridView(
              // mainAxisSpacing: 12,
              // crossAxisSpacing: 12,
              itemCount: wishlistProvider.getWishlistItems.length,
              builder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ProductWidgets(
                    productId: wishlistProvider.getWishlistItems.values
                        .toList()[index]
                        .productId,
                  ),
                );
              },
              crossAxisCount: 2,
            ),
          );
  }
}