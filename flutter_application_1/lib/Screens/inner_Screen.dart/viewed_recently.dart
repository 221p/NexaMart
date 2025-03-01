// ignore_for_file: non_constant_identifier_names

import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Widgets/empty_widget_bag.dart';
import 'package:flutter_application_1/Widgets/product/product_widgets.dart';
import 'package:flutter_application_1/Widgets/title_text.dart';
import 'package:flutter_application_1/providers/viewed_prod_provider.dart';
import 'package:flutter_application_1/services/assets_manager.dart';
import 'package:provider/provider.dart';


class ViewedRecently extends StatelessWidget {
  static const routename = '/RecentlyViwedScreen';
  const ViewedRecently({super.key});
  final bool isEmpty = false;

  @override
  Widget build(BuildContext context) {
    final viewProProvider = Provider.of<ViewedProdProvider>(context);
    return viewProProvider.getViewedProds.isEmpty
     ? Scaffold(
      body: EmptyWidgetBag(
        imagePath: AssetsManager.shoppingBasket, 
        title: "Your Recently View is Empty",
         subtitle: "Look like you didn't  add anything to your cart ",
          buttonText: "Shop Now"
          ),
    )
      : Scaffold(
        appBar: AppBar(
          title:  TitleTextWidgets(
            label: "Recent Viewed (${viewProProvider.getViewedProds.length})",
          ),
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(AssetsManager.shoppingCart),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Expanded(
                child: DynamicHeightGridView(
                  builder: (context, index) {
                    return  ProductWidgets(
                      productId: viewProProvider.getViewedProds.values
                      .toList()[index]
                      .productId,
                      );
                  },
                  itemCount: viewProProvider.getViewedProds.length,
                  crossAxisCount: 2,
                ),
              )
            ],
          ),
        ),
    );
  }
}
