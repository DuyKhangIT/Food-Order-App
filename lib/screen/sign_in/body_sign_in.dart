import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_app_project/screen/sign_in/signin_form.dart';

import '../../assets/images.dart';

class BodySignIn extends StatelessWidget {
  const BodySignIn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            customizeLogo(context, true),
            const SignInForm(),
            const SizedBox(height: 40),
            customizeLogo(context, false),
          ],
        ),
      ),
    );
  }

  Widget customizeLogo(BuildContext context, bool isHeader) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 130,
      alignment: isHeader ? Alignment.topRight : Alignment.bottomLeft,
      child: Image.asset(ImageAssets.imgDash),
    );
  }
}
