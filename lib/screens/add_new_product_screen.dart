import 'dart:io';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fruit_shop/providers/product_category_provider.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../widgets/product_image_picker.dart';
import '../widgets/nutrition_text_field.dart';

class AddNewProductScreen extends ConsumerStatefulWidget {
  static const routeName = '/add-new-product-screen';

  const AddNewProductScreen({Key? key}) : super(key: key);

  @override
  _AddNewProductScreenState createState() => _AddNewProductScreenState();
}

class _AddNewProductScreenState extends ConsumerState<AddNewProductScreen> {
  final _formKey = GlobalKey<FormState>();
  String chosenValue = 'mounim';
  String dropdownValue = 'vegetables';
  String productName = '';
  double productPrice = 0;
  String productDescription = '';
  late File productImage;
  String categoryOfProduct = '';
  static List<String> nutritionList = [];

  @override
  void initState() {
    super.initState();
     nutritionList.add("");
    // nutritionList.add("");
  }

  void _imageFile(File image) {
    productImage = image;
    print('mounimimage${productImage}');
  }

  void _trySubmit() async {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();

    if (isValid) {
      _formKey.currentState!.save();
      print('list of ${nutritionList}');

      _imageFile;

      final ref = FirebaseStorage.instance.ref().child(
            "product_image/$productName",
          );

      try {
        await ref.putFile(
            productImage, SettableMetadata(contentType: 'image/jpg'));
      } catch (e) {
        print('mounimerror ${e}');
      }
      final imageUrl = await ref.getDownloadURL();

      await FirebaseFirestore.instance.collection('products').add({
        'productName': productName,
        'productPrice': productPrice,
        'productDescription': productDescription,
        'productImageUrl': imageUrl,
        'categoryOfProduct': dropdownValue,
        'nutritionList' : nutritionList,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Product'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ProductImagePicker(_imageFile),
                const SizedBox(
                  height: 15,
                ),
                productNameField(),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    price(),
                    const SizedBox(
                      width: 10,
                    ),
                    dropdownButton(),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                description(),
                const SizedBox(
                  height: 15,
                ),
                nutritionsContainer(),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    onPressed: _trySubmit, child: const Text('Add New Product'))
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget productNameField() {
    return TextFormField(
      key: ValueKey('productName'),
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        hintText: 'Product Name',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 0.0, 15.0),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please Enter Product Name';
        }
        return null;
      },
      onSaved: (value) {
        productName = value!;
      },
    );
  }

  Widget price() {
    return SizedBox(
      width: 150,
      child: TextFormField(
        key: ValueKey('price'),
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          hintText: 'Price',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 0.0, 15.0),
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return 'Please Enter Price';
          }
          return null;
        },
        onSaved: (value) {
          productPrice = double.parse(value!);
        },
      ),
    );
  }

  Widget description() {
    return TextFormField(
      key: ValueKey('discription'),
      keyboardType: TextInputType.multiline,
      maxLines: 6,
      decoration: InputDecoration(
        hintText: 'Product Name',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 0.0, 15.0),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please Enter Description';
        }
        return null;
      },
      onSaved: (value) {
        productDescription = value!;
      },
    );
  }

  Widget dropdownButton() {
    final categoryList = ref.watch(productCategory).items;
    return SizedBox(
      width: 150,
      child: DropdownButton<String>(
        value: dropdownValue,
        isExpanded: true,
        hint: Text(
          "Please choose a langauage",
          style: TextStyle(
              color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600),
        ),
        //icon: const Icon(Icons.arrow_downward),
        elevation: 16,
        //style: const TextStyle(color: Colors.deepPurple),
        underline: Container(
          height: 2,
          color: Colors.green,
        ),
        onChanged: (String? value) {
          print('mounim${value}');
          // This is called when the user selects an item.
          setState(() {
            this.dropdownValue = value!;
          });
        },
        items: categoryList.map<DropdownMenuItem<String>>((value) {
          return DropdownMenuItem<String>(
            value: value.title,
            child: Text(value.title.toString()),
          );
        }).toList(),
      ),
    );
  }

  Widget nutritionsContainer() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const Text(
          'Add Nutritios',
          textAlign: TextAlign.left,
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        ListView.separated(
          shrinkWrap: true,
          physics: const ScrollPhysics(),
          itemBuilder: (context, index) {
            return Column(children: [
              nutritionsUi(index),
            ],);
          },
          separatorBuilder: (context, index) => const Divider(),
          itemCount: nutritionList.length,
        ),
      ],
    );
  }

  Widget nutritionsUi(index) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          Flexible(
            child: TextFormField(
              key: ValueKey('nutrition'),
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                hintText: 'Nutrition $index',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 0.0, 15.0),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Nutrition ${index + 1} can`t be emplty';
                }
                return null;
              },
              onSaved: (value) {
                nutritionList[index] = value!;
              },
            ),
          ),
          Visibility(
            visible: index == nutritionList.length - 1,
            child: SizedBox(
              width: 35,
              child: IconButton(
                  icon: const Icon(
                    Icons.add_circle,
                    color: Colors.green,
                  ),
                  onPressed: () {
                    addNutritionField();
                  }),
            ),
          ),
          Visibility(
            visible: index > 0,
            child: SizedBox(
              width: 35,
              child: IconButton(
                  icon: const Icon(
                    Icons.remove_circle,
                    color: Colors.red,
                  ),
                  onPressed: (){
                    removeNutritionField(index);
                  }),
            ),
          )
        ],
      ),
    );
  }

  void addNutritionField(){
    setState(() {
      nutritionList.add('');
    });
  }

  void removeNutritionField(index){
    setState(() {
      if(nutritionList.length > 1){
      nutritionList.removeAt(index);
      }
    });
  }
}
