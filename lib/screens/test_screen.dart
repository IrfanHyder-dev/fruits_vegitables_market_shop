import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../widgets/app_bar_custom.dart';

import '../screens/add_product_screen.dart';

class TestScreen extends StatelessWidget {
  const TestScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: Center(
            child: ElevatedButton(
                child: Text("logout"),
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                }),
          ),
        ),
        Center(child: ElevatedButton(onPressed: (){
          Navigator.of(context).pushNamed(AddProductScreen.routeName);
        }, child: Text('Add product')),)
      ],
    );
  }
}
