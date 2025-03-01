
import 'package:flutter_application_1/model/category_models.dart';
import 'package:flutter_application_1/services/assets_manager.dart';

class AppConst {
  static String productimageurl =
      "https://i.postimg.cc/qBGg9MHy/ebb77f6e-24cc-47ef-b381-a60a7f213508.webp";

  static List<String> bannerImages = [
    AssetsManager.banner1,
    AssetsManager.banner2,
    AssetsManager.banner1,
    AssetsManager.banner2,
  ];

  static List<String> latest = [
    AssetsManager.iphone,
  ];

  static List<CategoryModels> categoryList = [
    CategoryModels(id: "Phones", image: AssetsManager.pc, name: "Laptops",),
    CategoryModels(id: "Laptops", image: AssetsManager.mobiles, name: "Phones",),
    CategoryModels(id: "Electronics", image: AssetsManager.electronics, name: "Electronics",),
    CategoryModels(id: "Watches", image: AssetsManager.watch, name: "Watches",),
    CategoryModels(id: "Shoes", image: AssetsManager.shoes, name: "Shoes",),
    CategoryModels(id: "Books", image: AssetsManager.book, name: "Books",),
    CategoryModels(id: "Cosmatics", image: AssetsManager.cosmetics, name: "Cosmetics",),
    // CategoryModels(id: "Shoes", image: AssetsManager.shoes, name: "Shoes",),

  ];
static String apiKey = "AIzaSyC-B7Y9V7oB8ughNFr95M3T8RU80Npsonk" ;
static String appId = "1:468032481787:android:839eab1b61a8b9f48ac35e" ;
static String messagingSenderId ="468032481787" ;
static String projectId = "nexamart-2ce57" ;
static String storageBucket = "nexamart-2ce57.appspot.com" ;


}
