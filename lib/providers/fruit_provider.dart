import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fruit_shop/screens/product_detail_screen.dart';

import '../models/fruit_model.dart';

final fruitProductProvider =
    ChangeNotifierProvider<FruitProvider>((ref) => FruitProvider());

class FruitProvider extends ChangeNotifier {
  // final List<FruitModel> _items = [
  //   FruitModel(
  //       id: '1',
  //       name: 'strawberry',
  //       description:
  //           'It is a small, low-lying, spreading shrub. It bears small white flowers, which eventually develop into small conical, light green, immature fruits. They turn red upon maturity, with each berry featuring red pulp and tiny, yellow seeds piercing from within through its surface. Its stem end carries a green leafy cap (calyx with peduncle) that is adorning as a crown.',
  //       price: 50.0,
  //       nutrition: [
  //         "Potassium",
  //         "Sodium",
  //         "Carb",
  //         "Sugars",
  //         "Protein",
  //         "Vitamin (A)",
  //         "Vitamin (c)",
  //         "Vitamin (d)",
  //         "Calcium",
  //         "Iron",
  //         "Phosphorous",
  //         "Magnesium"
  //       ],
  //       image: "assets/images/fruits/apricot.jpg"),
  //   FruitModel(
  //       id: '2',
  //       name: 'Banana',
  //       description:
  //           'It is a small, low-lying, spreading shrub. It bears small white flowers, which eventually develop into small conical, light green, immature fruits. They turn red upon maturity, with each berry featuring red pulp and tiny, yellow seeds piercing from within through its surface. Its stem end carries a green leafy cap (calyx with peduncle) that is adorning as a crown.',
  //       price: 40.0,
  //       nutrition: [
  //         "Potassium",
  //         "Sodium",
  //         "Carb",
  //         "Sugars",
  //         "Protein",
  //         "Vitamin (A)",
  //         "Vitamin (c)",
  //         "Vitamin (d)",
  //         "Calcium",
  //         "Iron",
  //         "Phosphorous",
  //         "Magnesium"
  //       ],
  //       image: 'assets/images/fruits/banana.jpg'),
  //   FruitModel(
  //       id: '3',
  //       name: 'Cherry',
  //       description:
  //           'It is a small, low-lying, spreading shrub. It bears small white flowers, which eventually develop into small conical, light green, immature fruits. They turn red upon maturity, with each berry featuring red pulp and tiny, yellow seeds piercing from within through its surface. Its stem end carries a green leafy cap (calyx with peduncle) that is adorning as a crown.',
  //       price: 90.0,
  //       nutrition: ["vitamin2"],
  //       image: 'assets/images/fruits/cherry.jpg'),
  //   FruitModel(
  //       id: '4',
  //       name: 'Cherry',
  //       description:
  //           'It is a small, low-lying, spreading shrub. It bears small white flowers, which eventually develop into small conical, light green, immature fruits. They turn red upon maturity, with each berry featuring red pulp and tiny, yellow seeds piercing from within through its surface. Its stem end carries a green leafy cap (calyx with peduncle) that is adorning as a crown.',
  //       price: 90.0,
  //       nutrition: [
  //         "Potassium",
  //         "Sodium",
  //         "Carb",
  //         "Sugars",
  //         "Protein",
  //         "Vitamin (A)",
  //         "Vitamin (c)",
  //         "Vitamin (d)",
  //         "Calcium",
  //         "Iron",
  //         "Phosphorous",
  //         "Magnesium"
  //       ],
  //       image: 'assets/images/fruits/cherry.jpg'),
  //   FruitModel(
  //       id: '5',
  //       name: 'Cherry',
  //       description:
  //           'It is a small, low-lying, spreading shrub. It bears small white flowers, which eventually develop into small conical, light green, immature fruits. They turn red upon maturity, with each berry featuring red pulp and tiny, yellow seeds piercing from within through its surface. Its stem end carries a green leafy cap (calyx with peduncle) that is adorning as a crown.',
  //       price: 90.0,
  //       nutrition: [
  //         "Potassium",
  //         "Sodium",
  //         "Carb",
  //         "Sugars",
  //         "Protein",
  //         "Vitamin (A)",
  //         "Vitamin (c)",
  //         "Vitamin (d)",
  //         "Calcium",
  //         "Iron",
  //         "Phosphorous",
  //         "Magnesium"
  //       ],
  //       image: 'assets/images/fruits/cherry.jpg'),
  //   FruitModel(
  //       id: '6',
  //       name: 'Cherry',
  //       description:
  //           'It is a small, low-lying, spreading shrub. It bears small white flowers, which eventually develop into small conical, light green, immature fruits. They turn red upon maturity, with each berry featuring red pulp and tiny, yellow seeds piercing from within through its surface. Its stem end carries a green leafy cap (calyx with peduncle) that is adorning as a crown.',
  //       price: 90.0,
  //       nutrition: [
  //         "Potassium",
  //         "Sodium",
  //         "Carb",
  //         "Sugars",
  //         "Protein",
  //         "Vitamin (A)",
  //         "Vitamin (c)",
  //         "Vitamin (d)",
  //         "Calcium",
  //         "Iron",
  //         "Phosphorous",
  //         "Magnesium"
  //       ],
  //       image: 'assets/images/fruits/cherry.jpg'),
  // ];

  List<FruitModel> _items = [];

  List<FruitModel> get items {
    return [..._items];
  }

  FruitModel findById(String id) {
    var iD = _items.firstWhere((prod) => id == prod.id);
    return _items.firstWhere((prod) => id == prod.id);
  }

  Future<void> fetchProducts() async {
    List<FruitModel> loadedData = [];

    FirebaseFirestore.instance.collection('products').get().then((value) {
      value.docs.forEach(
        (element) {
          // print('mounim id ${element.id}');
          // print('mounim id ${element.data()['productName']}');
          // print('mounim id ${element.data()['productPrice']}');
          // print('mounim id ${element.data()['nutritionList']}');
          loadedData.add(
              FruitModel(
                id: element.id,
                name: element.data()['productName'],
                price: element.data()['productPrice'],
                image: element.data()['productImageUrl'],
                description: element.data()['productDescription'],
                nutrition: element.data()['nutritionList'],
                category: element.data()['categoryOfProduct'],
              ),);
          _items = loadedData;
        },
      );
    });
    notifyListeners();
    display();
  }

  void display() {
    for (int i = 0; i < _items.length; i++) {
      print('list${_items[i].name}');
      print('list${_items[i].price}');
      print('list${_items[i].category}');
    }
  }
}
