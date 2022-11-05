import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../widgets/cart_item_widget.dart';

class ShoppingCartScreen extends StatelessWidget {
  static const routeName = '/shopping-cart-screen';

  const ShoppingCartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(7),
        child: Container(
          child: Column(
            children: [

              CartItemWidget(),

            ],
          ),
        ),
      ),
    );
  }
}
