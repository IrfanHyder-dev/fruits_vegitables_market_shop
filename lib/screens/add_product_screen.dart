import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../screens/category_screen.dart';
import '../screens/add_new_product_screen.dart';

class AddProductScreen extends StatelessWidget {
  static const routeName = '/add-product-screen';

  const AddProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Product'),
      ),
      body: Container(
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 100,
              width: 100,
              child: InkWell(
                onTap: () => Navigator.of(context).pushNamed(AddNewProductScreen.routeName),
                child: Card(
                    elevation: 5,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          'Add New Product',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Icon(Icons.add)
                      ],
                    )),
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            SizedBox(
              height: 100,
              width: 100,
              child: InkWell(
                onTap: () => Navigator.of(context).pushNamed(CategoryScreen.routeName),
                child: Card(
                    elevation: 5,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          'Add New Category',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Icon(Icons.category),
                      ],
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
