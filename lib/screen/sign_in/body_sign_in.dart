import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_app_project/screen/sign_in/signin_form.dart';

import '../../assets/images.dart';

class BodySignIn extends StatelessWidget {
  const BodySignIn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              headerScreen(context),
              const SignInForm(),
              const SizedBox(height: 60,),
              footerScreen(context)
            ],
          ),
        ));
  }

  Widget headerScreen(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 150,
      alignment: Alignment.topRight,
      child: Image.asset(ImageAssets.imgDash),
    );
  }

  Widget footerScreen(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 150,
      alignment: Alignment.bottomLeft,
      child: Image.asset(ImageAssets.imgDash),
    );
  }
}
