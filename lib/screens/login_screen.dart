import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../widgets/auth_form_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;

  void _authSubmitForm(
    String email,
    String password1,
    String userName,
    bool isLogin,
  ) async {
    var authResult;
    try {
      if (isLogin) {
        authResult = await _auth.signInWithEmailAndPassword(
            email: email, password: password1);
      } else {
        authResult = await _auth.createUserWithEmailAndPassword(
            email: email, password: password1);

        await FirebaseFirestore.instance
            .collection('users')
            .doc(authResult.user.uid)
            .set(
          {
            'userName': userName,
            'email': email,
          },
        );
      }
    } catch (error) {
      print('mounim => ${error}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: 60,
                ),
                image(),
                SizedBox(
                  height: 20,
                ),
                title(),
                SizedBox(
                  height: 20,
                ),
                AuthForm(_authSubmitForm),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget image() {
    return Image.asset("assets/images/Fruit_Market.png");
  }

  Widget title() {
    return Text(
      'Fruit Shop',
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Theme.of(context).colorScheme.primary,
        fontWeight: FontWeight.bold,
        fontSize: 45,
      ),
    );
  }
}
