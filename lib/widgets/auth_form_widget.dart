import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {

  final void Function(
      String email,
      String password1,
      String userName,
      bool isLogin,
      ) submitForm;
  const AuthForm(this.submitForm);

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';
  String _userName = '';
  var _isLogin = true;

  void _trySubmit() {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();

    if (isValid) {
      _formKey.currentState!.save();
      widget.submitForm(
        _email.trim(),
        _password.trim(),
        _userName.trim(),
        _isLogin,
      );


      print(_email);
      print(_userName);
      print(_password);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 30),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              if (!_isLogin)
                TextFormField(
                  key: ValueKey('username'),
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person),
                    hintText: 'UserName',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 0.0, 15.0),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please Enter username';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _userName = value!;
                  },
                ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                key: ValueKey('email'),
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.email),
                  hintText: 'Email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 0.0, 15.0),
                ),
                validator: (value) {
                  if (value!.isEmpty || !value.contains('@')) {
                    return 'Please Enter Correct Email';
                  }
                  return null;
                },
                onSaved: (value) {
                  _email = value!;
                },
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                key: ValueKey('password'),
                obscureText: true,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.remove_red_eye),
                  hintText: 'Password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 0.0, 15.0),
                ),
                validator: (value) {
                  if (value!.isEmpty || value.length < 4) {
                    return 'Please Enter at least 4 character';
                  }
                  return null;
                },
                onSaved: (value) {
                  _password = value!;
                },
              ),
              SizedBox(
                height: 15,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                child: Text(_isLogin ? 'Login' : 'SignUp'),
                onPressed: _trySubmit,
              ),
              //SizedBox(height: 0,),
              TextButton(
                child: Text(_isLogin
                    ? 'Not a member? Sign up now'
                    : 'I already have an account'),
                onPressed: () {
                  setState(() {
                    _isLogin = !_isLogin;
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
