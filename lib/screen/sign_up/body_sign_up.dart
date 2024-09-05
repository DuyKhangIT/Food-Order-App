import 'package:flutter/material.dart';
import 'package:food_app_project/screen/sign_up/sign_up_form.dart';

class BodySignUp extends StatelessWidget {
  const BodySignUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.fromLTRB(10, 70, 10, 0),
      child: const Column(
        children: [
          Text('Register Account',
              style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                  height: 1.5)),
          Text(
            'Complete your details or continue \nwith social media',
            style: TextStyle(
              color: Color(0xFF4caf50),
            ),
            textAlign: TextAlign.center,
          ),
          SignUpForm()
        ],
      ),
    ));
  }
}
