import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fruit_shop/models/fruit_model.dart';

import '../providers/fruit_provider.dart';
import '../widgets/app_bar_custom.dart';
import '../resources/ccolor_manager.dart';
import '../providers/cart_provider.dart';

final fruitProvider = Provider<FruitProvider>((ref) => FruitProvider());
//final cart = ChangeNotifierProvider<CartProvier>((ref) {return CartProvier();});

class ProductDetailScreen extends ConsumerWidget {
  static const routeName = '/product-detail-screen';

  const ProductDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final id = ModalRoute.of(context)?.settings.arguments as String;
    final loadedData = ref.watch(fruitProductProvider).findById(id);
    return Scaffold(
      appBar: AppBarCustom(
              title: loadedData.name.toString(),
              notificationCount: 0,
              showNotification: false,
              onBack: () => Navigator.of(context).pop(),
              onNotify: () {})
          .appBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  loadedData.image.toString(),
                  height: 250,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                loadedData.name.toString(),
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 5),
                child: Text(
                  loadedData.description.toString(),
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Text(
                'Nutritions',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(
                height: 15,
              ),
              nutritionList(loadedData),
              const SizedBox(
                height: 30,
              ),
              priceBuyNow(loadedData, ref, context),
            ],
          ),
        ),
      ),
    );
  }

//Widget priceBuyNow() =>

}

Widget priceBuyNow(FruitModel loadedData, WidgetRef ref, BuildContext context) => Row(
      children: [
        Text('\$ ${loadedData.price} per/kg',
            style: Theme.of(context).textTheme.bodySmall),
        const Spacer(),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(180, 50),
            textStyle: const TextStyle(
              fontSize: 20,
            ),
          ),
          child: const Text('Buy now'),
          onPressed: () => {
            ref.read(cartProvider).addItem(
                  loadedData.id.toString(),
                  loadedData.name.toString(),
                  loadedData.price!,
                  loadedData.image.toString(),
              1,
                ),
          },
        ),
      ],
    );

Widget nutritionList(FruitModel loadedData) => Padding(
      padding: const EdgeInsets.all(15),
      child: Container(
        height: 200,
        width: 130,
        child: ListView.builder(
          itemBuilder: (context, ind) => Row(
            children: [
              const CircleAvatar(
                radius: 4,
                backgroundColor: ColorManager.lightGrey,
              ),
              const SizedBox(
                height: 20,
                width: 15,
              ),
              Text(loadedData.nutrition?[ind] ?? '',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: ColorManager.lightBlack, fontSize: 14)),
            ],
          ),
          itemCount: loadedData.nutrition?.length,
        ),
      ),
    );
