import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fruit_shop/providers/fruit_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../resources/ccolor_manager.dart';
import '../models/fruit_model.dart';
import '../screens/product_detail_screen.dart';

final fruitProvider = ChangeNotifierProvider<FruitModel>((ref) => FruitModel());
//final itemDataProvider = Provider<FruitProvider>((ref) => FruitProvider());

class FruitCard extends ConsumerWidget {

final String id;
final user = FirebaseAuth.instance.currentUser;
//final userId = FirebaseAuth

FruitCard(this.id);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fruitData = ref.watch(fruitProvider);
    //final itemData = ref.watch(itemDataProvider).findById(id);
    final itemData = ref.watch(fruitProductProvider).findById(id);
    return InkWell(
      onTap: () => Navigator.of(context).pushNamed(ProductDetailScreen.routeName, arguments: id),
      child: SizedBox(
        width: 120,
        height: 210,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Stack(
                children: [
                  Image.network(
                    itemData.image.toString(),
                    height: 140,
                    width: 120,
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    right: 5,
                    top: 5,
                    child: InkWell(
                      onTap: () => fruitData.isFavoriteStatus(user!.uid),
                      child: CircleAvatar(
                        radius: 16,
                        backgroundColor: ColorManager.white,
                        child: Icon(
                          fruitData.isFavorite
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: ColorManager.orange,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 5,),
            Text(itemData.name.toString(), style: Theme.of(context).textTheme.titleMedium,),
            const SizedBox(height: 5,),
            Text('\$ ${itemData.price.toString()} per/kg', style: Theme.of(context).textTheme.titleSmall,),
          ],
        ),
      ),
    );
  }
}
