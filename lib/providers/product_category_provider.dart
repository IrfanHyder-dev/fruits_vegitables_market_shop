import 'package:flutter/foundation.dart';

import '../models/product_category_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final productCategory = ChangeNotifierProvider<ProductCategoryProvider>(
    (ref) => ProductCategoryProvider());

class ProductCategoryProvider extends ChangeNotifier {
  // List<ProductCategoryModel> _items = [
  //   ProductCategoryModel(
  //     title: 'Organic Fruits',
  //     subTitle: 'Pick up from organic farms',
  //     offer: '20% Off',
  //   ),
  //   ProductCategoryModel(
  //     title: 'Organic Vegs',
  //     subTitle: 'Pick up from organic farms',
  //     offer: '20% Off',
  //   ),
  //   ProductCategoryModel(
  //     title: 'Dry Fruits',
  //     subTitle: 'Pick up from organic farms',
  //     offer: '20% Off',
  //   ),
  //   ProductCategoryModel(
  //     title: 'Farm Fruits',
  //     subTitle: 'Pick up from organic farms',
  //     offer: '20% Off',
  //   ),
  //   ProductCategoryModel(
  //     title: 'Fresh Mrket Fruits',
  //     subTitle: 'Pick up from organic farms',
  //     offer: '20% Off',
  //   ),
  // ];

  List<ProductCategoryModel> _items = [];

  List<ProductCategoryModel> get items {
    return [..._items];
  }

  var productCategoryModel;

  Future<void> getCategories() async {
    List<ProductCategoryModel> loadedList = [];
    FirebaseFirestore.instance.collection('categories').get().then(
      (value) {
        value.docs.forEach(
          (element) {
            print('mounim2${element.data()['title']}');
            loadedList.add(
              ProductCategoryModel(
                title: element.data()['title'],
                subTitle: element.data()['subTitle'],
                offer: element.data()['offer'],
              ),
            );
            _items = loadedList;
            print('list${items}');

          },
        );
      },
    );
    notifyListeners();
  }

  void printData(){
    for(int i = 0; i< _items.length; i++) {
      print('list${items[i].title}');
      print('list${items[i].offer}');
      print('list${items[i].subTitle}');
    }
  }
}
