import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Const/app_const.dart';
import 'package:flutter_application_1/Widgets/app_name_text.dart';
import 'package:flutter_application_1/Widgets/product/ctg_rounded_btn.dart';
import 'package:flutter_application_1/Widgets/product/latest_arrival_product_widgets.dart';
import 'package:flutter_application_1/Widgets/title_text.dart';
import 'package:flutter_application_1/providers/product_provider.dart';
import 'package:flutter_application_1/services/assets_manager.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: AppNameTextWidget(),
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(AssetsManager.shoppingCart),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: size.height * 0.24,
                child: Swiper(
                  itemBuilder: (context, index) {
                    return Image.asset(
                      AppConst.bannerImages[index],
                    );
                  },
                  itemCount: AppConst.bannerImages.length,
                  autoplay: true,
                  pagination: const SwiperPagination(
                    alignment: Alignment.bottomCenter,
                    builder: DotSwiperPaginationBuilder(
                      color: Colors.white,
                      activeColor: Colors.redAccent,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 18,
              ),
              const TitleTextWidgets(
                label: "Latest Arrival",
                fontSize: 22,
              ),
              const SizedBox(
                height: 18,
              ),
              SizedBox(
                height: size.height * 0.2,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return ChangeNotifierProvider.value(
                      value: productProvider.getProducts[index] ,
                      child: const LatestArrivalProductsWidgets());
                  },
                ),
              ),
              const SizedBox(
                height: 18,
              ),
              const TitleTextWidgets(label: "Categories", fontSize: 22,
              ),
              const SizedBox(
                height: 15,
              ),
              GridView.count(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                crossAxisCount: 4,
                children: 
                  List.generate(AppConst.categoryList.length, (index){
                    return CategoryRoundedWidgets(
                      image: AppConst.categoryList[index].image, 
                      name: AppConst.categoryList[index].name,
                      
                    );
                  }),
               
              ),
            ],
          ),
        ),
      ),
    );
  }
}
