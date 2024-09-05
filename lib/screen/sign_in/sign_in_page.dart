import 'package:flutter/material.dart';

import 'body_sign_in.dart';

class SignInPage extends StatelessWidget {
  static String routeName = "/sign_in";

  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      resizeToAvoidBottomInset: false,
      body: BodySignIn(),
    );
  }
}
