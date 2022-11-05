import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fruit_shop/resources/ccolor_manager.dart';

import '../providers/fruit_provider.dart';
import '../widgets/app_bar_custom.dart';
import '../widgets/product_category_widget.dart';
import '../providers/product_category_provider.dart';

class ProductDisplayScreen extends ConsumerStatefulWidget {
  ProductDisplayScreen();

  @override
  _ProductDisplayScreenState createState() => _ProductDisplayScreenState();
}

class _ProductDisplayScreenState extends ConsumerState<ProductDisplayScreen> {
  final item = FruitProvider().items;

  //final catItem = ProductCategoryProvider().items;
  var _isInit = true;
  var _isLoading = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });

      ref.watch(productCategory).getCategories().then(
        (_) {
          setState(() {
            _isLoading = false;
          });
        },
      );
      ref.watch(fruitProductProvider).fetchProducts();

    }
  }

  @override
  Widget build(BuildContext context) {
    var catItem = ref.watch(productCategory).items;
    return Scaffold(
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.only(top: 5),
              child: ListView.builder(
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.only(
                    top: 15,
                    right: 8,
                    left: 8,
                    bottom: 10,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            catItem[index].title.toString(),
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          Text(
                            '\(${catItem[index].offer.toString()}\)',
                            style: const TextStyle(
                              color: ColorManager.lightGreen,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),

                      Text(catItem[index].subTitle.toString()),

                      const SizedBox(
                          height: 200, child: ProductCategoryWidget()),
                      // ListView.builder(itemBuilder: (context, index) => ,
                      // itemCount: item.length,)
                    ],
                  ),
                ),
                itemCount: catItem.length,
              ),
            ),
    );
  }
}
