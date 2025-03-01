import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/cart_model.dart';
import 'package:flutter_application_1/model/products_model.dart';
import 'package:flutter_application_1/providers/product_provider.dart';
import 'package:uuid/uuid.dart';

class CartProvider with ChangeNotifier {
  final Map<String, CartModel> _cartItems = {};
  Map<String, CartModel> get getCartitems {
    return _cartItems;
  }

  bool isProductInCart({required String productId}) {
    return _cartItems.containsKey(productId);
  }

  void addProductToCart({required String productId}) {
    _cartItems.putIfAbsent(
      productId,
      () => CartModel(
          cartId: const Uuid().v4(), productId: productId, quantity: 1),
    );
    notifyListeners();
  }

  void updateQuantity({required String productId, required int quality}) {
    _cartItems.update(
      productId,
      (item) => CartModel(
          cartId: item.cartId,
           productId: productId,
            quantity: quality
            ),
    );
    notifyListeners();
  }

  double getTotal({required ProductProvider productProvider}){
    double total  = 0.0;
    _cartItems.forEach((Key , value) {
      final ProductModel ? getCurrentProduct = productProvider.findByProdId(value.productId);
      if(getCurrentProduct == null ){
        total += 0;

      }else{
        total += double.parse(getCurrentProduct.productPrice)* value.quantity;
      }
    });
    return total;
  }

  int getQty(){
    int total = 0 ;
    _cartItems.forEach((Key , value){
      total += value.quantity;
    });
    return total;
  }
  
  void removeOneItem({required String productId}){
    _cartItems.remove(productId);
    notifyListeners();
  }

  void clearlocalCart(){
    _cartItems.clear();
    notifyListeners();
  }
}
