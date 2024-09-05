import 'package:flutter/material.dart';

import 'body_sign_up.dart';

class SignUpPage extends StatelessWidget {
  static String routeName = "/sign_up";
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.green,
        leading: IconButton(
          color: Colors.white,
          icon: const Icon(Icons.arrow_back),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: const Text('Sign Up', style: TextStyle(color: Colors.white)),
      ),
      body: const BodySignUp(),
    );
  }
}
