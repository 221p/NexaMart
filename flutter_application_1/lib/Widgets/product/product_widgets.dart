import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Screens/inner_Screen.dart/product_details.dart';
import 'package:flutter_application_1/Widgets/product/heart_btn_widgets.dart';
import 'package:flutter_application_1/Widgets/subtitle_text.dart';
import 'package:flutter_application_1/Widgets/title_text.dart';

import 'package:flutter_application_1/providers/cart_provider.dart';
import 'package:flutter_application_1/providers/product_provider.dart';

import 'package:provider/provider.dart';

class ProductWidgets extends StatefulWidget {
  final String productId;
  const ProductWidgets({super.key, required this.productId});

  @override
  State<ProductWidgets> createState() => _ProductWidgetsState();
}

class _ProductWidgetsState extends State<ProductWidgets> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final productProvider = Provider.of<ProductProvider>(context);
    final getCurrentProduct = productProvider.findByProdId(widget.productId);
    final cartProvider = Provider.of<CartProvider>(context);
    return getCurrentProduct == null
        ? SizedBox.shrink()
        : Padding(
            padding: const EdgeInsets.all(3.0),
            child: GestureDetector(
              onTap: () async {
                await Navigator.pushNamed(
                  context,
                  ProductDetails.routename,
                  arguments: getCurrentProduct.productId,
                );
              },
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(30.0),
                    child: FancyShimmerImage(
                      imageUrl: getCurrentProduct.productImage,
                      height: size.height * 0.2,
                      width: double.infinity,
                    ),
                  ),
                  Row(
                    children: [
                      Flexible(
                        flex: 5,
                        child: TitleTextWidgets(
                          label: getCurrentProduct.productTitle,
                        ),
                      ),
                      Flexible(flex: 2, child: HeartBtnWidget(
                        productId: getCurrentProduct.productId,
                      )),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SubtitleTextWidgets(
                          label: "${getCurrentProduct.productPrice}₹"),
                      Flexible(
                        child: Material(
                            borderRadius: BorderRadius.circular(16.0),
                            // color: Colors.lightBlue,
                            child: InkWell(
                              splashColor: Colors.blue,
                              borderRadius: BorderRadius.circular(16.0),
                              onTap: () {
                                if (cartProvider.isProductInCart(
                                    productId: getCurrentProduct.productId)) {
                                  return;
                                }
                                cartProvider.addProductToCart(
                                    productId: getCurrentProduct.productId);
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(
                                  cartProvider.isProductInCart(
                                          productId:
                                              getCurrentProduct.productId)
                                      ? Icons.check
                                      : Icons.add_shopping_cart_rounded,
                                  size: 20,
                                ),
                              ),
                            )),
                      )
                    ],
                  )
                ],
              ),
            ),
          );
  }
}
