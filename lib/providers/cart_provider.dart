import 'dart:collection';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

final cartProvider =
    ChangeNotifierProvider<CartProvier>((ref) => CartProvier());

class CartItemModel {
  final String idForCart;
  final String productId;
  final String title;
   int qunatity;
  final double price;
  final String image;

  CartItemModel(
      {required this.idForCart,
        required this.productId,
      required this.title,
      required this.qunatity,
      required this.price,
      required this.image});
}

class CartProvier extends ChangeNotifier {
   Map<String, CartItemModel> _cartItems = {};

  //
  // Map<String, CartItemModel> get cartItems {
  //   return {..._cartItems};
  // }
  UnmodifiableMapView<String, CartItemModel> get cartItems {
    return UnmodifiableMapView(_cartItems);
  }

  int get ItemCount {
    var count = _cartItems == null ? 0 : _cartItems.length;
    //notifyListeners();
    return count;
  }

  double get totalAmount {
    double total = 0.0;
    _cartItems.forEach((key, cartItem) {
      total += cartItem.price * cartItem.qunatity;
    });
    return total;
  }

  void addItem(String productId, String title, double price, String image, int quantity) {
    if (_cartItems.containsKey(productId)) {
      _cartItems.update(
        productId,
            (exixtingCartItem) => CartItemModel(
          idForCart: exixtingCartItem.idForCart,
          productId: exixtingCartItem.productId,
          title: exixtingCartItem.title,
          qunatity: exixtingCartItem.qunatity = quantity,
          price: exixtingCartItem.price,
          image: exixtingCartItem.image,
        ),
      );
      print('quantity 5');
    }
    else {
      _cartItems.putIfAbsent(
        productId,
            () =>
            CartItemModel(
              idForCart: DateTime.now().toString(),
              productId: productId,
              title: title,
              price: price,
              qunatity: 1,
              image: image,
            ),
      );
    }
    print('id = ${productId}');
    print(title);
    print(price);
    print(image);
    display();
    notifyListeners();
  }

  void display() {
    print(cartItems.values.toList()[0].title);
  }

  void updateItem(String productId, int quantity1) {
    if (_cartItems.containsKey(productId)) {
      _cartItems.update(
        productId,
        (exixtingCartItem) => CartItemModel(
          idForCart: exixtingCartItem.idForCart,
          productId: exixtingCartItem.productId,
          title: exixtingCartItem.title,
          qunatity: exixtingCartItem.qunatity = quantity1,
          price: exixtingCartItem.price,
          image: exixtingCartItem.image,
        ),
      );
      print('quantityCartProvider ${quantity1}');
    }

    notifyListeners();
  }

  void removeItem(String id){
    _cartItems.remove(id);
    notifyListeners();
  }

}
