import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Widgets/product/product_widgets.dart';
import 'package:flutter_application_1/Widgets/title_text.dart';
import 'package:flutter_application_1/model/products_model.dart';
import 'package:flutter_application_1/providers/product_provider.dart';
import 'package:flutter_application_1/services/assets_manager.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  static const routename = "/SearchScreen";
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  // ignore: non_constant_identifier_names
  late TextEditingController SearchTextController;
  List<ProductModel> productListSearch = [];
  @override
  void initState() {
    SearchTextController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    String? passedCategory =
        ModalRoute.of(context)!.settings.arguments as String?;
    final List<ProductModel> productList = passedCategory == null
        ? productProvider.getProducts
        : productProvider.findByCategory(ctgName: passedCategory);
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: TitleTextWidgets(
            label: passedCategory ?? "Search",
          ),
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(AssetsManager.shoppingCart),
          ),
        ),
        body: productList.isEmpty
            ? const Center(
                child: TitleTextWidgets(label: "No Produucts Found"),
              )
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    TextFormField(
                      controller: SearchTextController,
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          IconlyLight.search,
                        ),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              SearchTextController.clear();
                              FocusScope.of(context).unfocus();
                            });
                          },
                          icon: const Icon(
                            IconlyLight.closeSquare,
                            color: Colors.redAccent,
                          ),
                        ),
                      ),
                      onFieldSubmitted: (value) {
                        setState(() {
                          productListSearch = productProvider.searchQuery(
                              searchText: SearchTextController.text,
                              passedList: productList);
                        });
                      },
                      onChanged:(value) {
                          setState(() {
                          productListSearch = productProvider.searchQuery(
                              searchText: SearchTextController.text,
                              passedList: productList);
                        });
                      },
                    ),
                    if (SearchTextController.text.isNotEmpty &&
                        productListSearch.isEmpty) ...[
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: const Center(
                          child: TitleTextWidgets(
                            label: "No Result Found",
                            fontSize: 30,
                          ),
                        ),
                      ),
                    ],
                    Expanded(
                      child: DynamicHeightGridView(
                        builder: (context, index) {
                          return ProductWidgets(
                            productId: SearchTextController.text.isNotEmpty
                                ? productListSearch[index].productId
                                : productList[index].productId,
                          );
                        },
                        itemCount: SearchTextController.text.isNotEmpty
                            ? productListSearch.length
                            : productList.length,
                        crossAxisCount: 2,
                      ),
                    )
                  ],
                ),
              ),
      ),
    );
  }
}
