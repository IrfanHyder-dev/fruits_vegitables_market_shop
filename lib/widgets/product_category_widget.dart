import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/fruit_provider.dart';
import '../widgets/fruit_card_widget.dart';

class ProductCategoryWidget extends ConsumerStatefulWidget {
  const ProductCategoryWidget();

  @override
  _ProductCategoryWidgetState createState() => _ProductCategoryWidgetState();
}

class _ProductCategoryWidgetState extends ConsumerState<ProductCategoryWidget> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    //ref.watch(fruitProductProvider).fetchProducts();
    //ref.watch(fruitProductProvider).display();

    //ref.watch(fruitProvider)
  }

  @override
  Widget build(BuildContext context) {
    final item = ref.watch(fruitProductProvider).items;
    return SizedBox(
      height: 250,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(top: 10, right: 16),
            //height: ,
            child: FruitCard(
              item[index].id!,
            ),
          );
        },
        itemCount: item.length,
      ),
    );
  }
}
