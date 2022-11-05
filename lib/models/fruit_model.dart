import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class FruitModel extends ChangeNotifier {
  final String? name;
  final String? id;
  final String? description;
  final double? price;
  final String? image;
  final String? category;
  List<dynamic>? nutrition;
  bool isFavorite;

  FruitModel({
    this.name,
    this.description,
    this.id,
    this.image,
    this.price,
    this.nutrition,
    this.category,
    this.isFavorite = false,
  });

  void isFavoriteStatus(String userId) async {
    final oldStatus = isFavorite;
    isFavorite = !isFavorite;
    notifyListeners();
    // final data = <dynamic, dynamic>{
    //   id : isFavorite,
    // };
    // try {
    //   await FirebaseFirestore.instance
    //       .collection('userFavourite')
    //       .doc(userId)
    //       .set({id.toString(): isFavorite});
    // } catch (error) {
    //   print('mounim => ${error}');
    // }
  }
}
