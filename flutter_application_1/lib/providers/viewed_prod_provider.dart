import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/viewd_prod_model.dart';
import 'package:uuid/uuid.dart';



class ViewedProdProvider with ChangeNotifier {
  final Map<String, ViewdProdModel> _viewedProdItems = {};

  Map<String, ViewdProdModel> get getViewedProds {
    return _viewedProdItems;
  }

  void addViewedProd({required String productId}) {
    _viewedProdItems.putIfAbsent(
      productId,
      () => ViewdProdModel(id: Uuid().v4(), productId: productId)
    );

    notifyListeners();
  }
}