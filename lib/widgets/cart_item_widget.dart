import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fruit_shop/resources/ccolor_manager.dart';

import '../providers/cart_provider.dart';
import '../widgets/cart_inc_dec_widget.dart';

//final counter = Provider<CartIncDec>((ref)=> CartIncDec());

class CartItemWidget extends ConsumerWidget {
  final int count = 1;
  const CartItemWidget();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loadedData = ref.watch(cartProvider);
   // final countp = ref.watch(countProvider);


    return SizedBox(
      height: 500,
      width: double.infinity,
      child: ListView.builder(
        itemBuilder: (context, i) {
          final title = loadedData.cartItems.values.toList()[i].title;
          final price = loadedData.cartItems.values.toList()[i].price;
          final image = loadedData.cartItems.values.toList()[i].image;
          final quantity = loadedData.cartItems.values.toList()[i].qunatity;
          final id = loadedData.cartItems.values.toList()[i].idForCart;
          final productid = loadedData.cartItems.values.toList()[i].productId;

          // print('idOfCart ${id}');
          // print('id ${productid}');
          return SizedBox(
            height: 135,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  children: [
                    imageWidget(image),
                    const SizedBox(
                      width: 10,
                    ),
                    titleOfItem(title, price,quantity, context,count),
                    cartInc(productid, quantity, ref),
                  ],
                ),
                const Divider(color: ColorManager.lightGrey),
              ],
            ),
          );
        },
        itemCount: ref.watch(cartProvider).ItemCount,
      ),
    );
  }
}

Widget imageWidget(String image) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(5),
    child: Image.asset(
      image,
      width: 90,
      height: 100,
      fit: BoxFit.cover,
    ),
  );
}

Widget titleOfItem(String title, double price,int quantity, BuildContext context,int count) {
  return SizedBox(
    width: 145,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          children: [
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                color: ColorManager.black,
                fontSize: 17,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
          ],
        ),
        const SizedBox(
          height: 12,
        ),
        Text('Rs.${price} per/kg',
            style: Theme.of(context).textTheme.bodySmall),
        const SizedBox(
          height: 10,
        ),
        Text('${quantity * price} per/kg',
            style: const TextStyle(
              color: ColorManager.black,
              fontWeight: FontWeight.w500,
            )),
      ],
    ),
  );
}

Widget cartInc( String productId, int quantity, WidgetRef ref) {
  print('cartInc ${productId}');
  return Container(
    margin: const EdgeInsets.only(top: 16),
    child: Column(
      children: [
        // Text(
        //   'Rs.20 saved',
        //   style: Theme.of(context)
        //       .textTheme
        //       .bodySmall
        //       ?.copyWith(color: ColorManager.lightGreen),
        // ),
        //SizedBox(height: 10,),
         CartIncDec(productId, quantity),
        const SizedBox(
          height: 20,
        ),
        TextButton.icon(
          icon: const Icon(
            Icons.delete,
            color: Colors.red,
          ),
          label: const Text(
            'Remove',
            style: TextStyle(
              color: Colors.red,
            ),
          ),
          onPressed: () => ref.watch(cartProvider).removeItem(productId),
        ),
      ],
    ),
  );
}

void getIndex(CartProvier loadedData){


}
