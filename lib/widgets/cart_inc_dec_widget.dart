import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fruit_shop/providers/product_category_provider.dart';

import '../resources/ccolor_manager.dart';
import '../providers/cart_provider.dart';

//final countProvider = Provider<CartIncDec>((ref) => CartIncDec());

class CartIncDec extends ConsumerStatefulWidget {
 final String productId;
 final int qunatity1;


   CartIncDec(this.productId, this.qunatity1);

  @override
  _CartIncDecState createState() => _CartIncDecState();
}

class _CartIncDecState extends ConsumerState<CartIncDec> {
  int count = 1;
  @override
  Widget build(BuildContext context) {

    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: ColorManager.black),
          ),
          height: 25,
          width: 25,
          child: InkWell(
            child: const Icon(Icons.add),
            onTap:()=> countUpdate(1,widget.productId,widget.qunatity1),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text('${widget.qunatity1}', style: Theme
              .of(context)
              .textTheme
              .titleMedium),
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: ColorManager.black),
          ),
          height: 25,
          width: 25,
          child: InkWell(
            child: const Icon(Icons.remove),
            onTap: () => countUpdate(-1,widget.productId,widget.qunatity1),
          ),
        ),
      ],
    );
  }


  void countUpdate(int i,String productId, int quantity1 ) {
    if (i < 1 && count <= 1) return;

    setState(() {
      //count += i;
      count += i;
    });
    print('getting id here ${productId}');
    ref.watch(cartProvider).updateItem(productId, count);
    ref.watch(productCategory).getCategories();
    ref.watch(productCategory).printData();



  }
  }

