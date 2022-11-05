import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryScreen extends StatefulWidget {
  static const routeName = '/category-screen';

  const CategoryScreen({Key? key}) : super(key: key);

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final _formKey = GlobalKey<FormState>();

  String _categoryName = '';
  String _subTitle = '';
  String _offer = '';

  void _trySubmit() async {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (isValid) {
      _formKey.currentState!.save();
      await FirebaseFirestore.instance.collection('categories').add({
        'title': _categoryName,
        'subTitle': _subTitle,
        'offer': _offer,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Category'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Form(
          key: _formKey,
          child: Column(children: [
            categoryName(),
            const SizedBox(
              height: 15,
            ),
            subTitle(),
            const SizedBox(
              height: 15,
            ),
            offer(),
            const SizedBox(height: 15,),
            ElevatedButton(
              onPressed: _trySubmit,
              child: const Text('Add Category'),
            ),
          ]),
        ),
      ),
    );
  }

  Widget categoryName() {
    return TextFormField(
      key: ValueKey('categoryName'),
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.category_rounded),
        hintText: 'Category Name',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 0.0, 15.0),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please Enter Category Name';
        }
        return null;
      },
      onSaved: (value) {
        _categoryName = value!;
      },
    );
  }

  Widget subTitle() {
    return TextFormField(
      key: ValueKey('subTitle'),
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.title),
        hintText: 'Sub Title',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 0.0, 15.0),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please Enter Sub Title';
        }
        return null;
      },
      onSaved: (value) {
        _subTitle = value!;
      },
    );
  }

  Widget offer() {
    return TextFormField(
      key: ValueKey('offer'),
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.local_offer),
        hintText: 'Offer',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 0.0, 15.0),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please Enter offer / or just 0';
        }
        return null;
      },
      onSaved: (value) {
        _offer = value!;
      },
    );
  }
}
