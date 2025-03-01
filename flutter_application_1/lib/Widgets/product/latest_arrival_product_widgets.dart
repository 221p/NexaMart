import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Screens/inner_Screen.dart/product_details.dart';
import 'package:flutter_application_1/Widgets/product/heart_btn_widgets.dart';
import 'package:flutter_application_1/Widgets/subtitle_text.dart';
import 'package:flutter_application_1/model/products_model.dart';
import 'package:flutter_application_1/providers/viewed_prod_provider.dart';

import 'package:provider/provider.dart';

class LatestArrivalProductsWidgets extends StatelessWidget {
  const LatestArrivalProductsWidgets({super.key});

  @override
  Widget build(BuildContext context) {
    final productsModel =  Provider.of<ProductModel>(context);
    final viewedProvider = Provider.of<ViewedProdProvider>(context);
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () async {
          viewedProvider.addViewedProd(
            productId: productsModel.productId );
        
        await Navigator.pushNamed(context, ProductDetails.routename , arguments: productsModel.productId,
          );
        },
        child: SizedBox(
          width: size.width * 0.45,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: FancyShimmerImage(
                    imageUrl: productsModel.productImage,
                    width: size.width * 0.28,
                    height: size.width * 0.28,
                  ),
                ),
              ),
              const SizedBox(
                width: 7,
              ),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      productsModel.productTitle,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    FittedBox(
                      child: Row(
                        children:[
                          HeartBtnWidget(productId: productsModel.productId
                          ),
                        IconButton(
                        onPressed: () {}, 
                        icon: const Icon(
                        Icons.add_shopping_cart_rounded ,
                        size: 20,
                        ),
                        ),
                        ],
                      ),
                    ),
                     FittedBox(
                      child: SubtitleTextWidgets(
                        label:  "${productsModel.productPrice}₹",
                         color: Colors.blue,),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
