import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../assets/images.dart';
import '../../handle_api/handle_api.dart';
import '../../model/error_response.dart';
import '../../model/login/login_request.dart';
import '../../model/login/login_response.dart';
import '../../util/global.dart';
import '../../util/share_preferences.dart';
import '../../util/show_loading_dialog.dart';
import '../home/home_page.dart';
import '../sign_up/sign_up_page.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({Key? key}) : super(key: key);

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String username = "";
  String password = "";
  bool isShowPassword = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  /// call api login
  Future<void> loginApi(LoginRequest loginRequest) async {
    setState(() {
      isLoading = true;
      if (isLoading) {
        IsShowDialog().showLoadingDialog(context);
      } else {
        Navigator.of(context).pop();
      }
    });
    LoginResponse loginResponse;
    ErrorResponse? errorResponse;
    Map<String, dynamic>? body;
    try {
      body = await HttpHelper.invokeHttp(
        Uri.parse("http://10.0.2.2:5000/api/auth/login"),
        RequestType.post,
        headers: null,
        body: const JsonEncoder().convert(loginRequest.toBodyRequest()),
      );
      if (body == null) return;
      setState(() {
        isLoading = false;
        if (isLoading) {
          IsShowDialog().showLoadingDialog(context);
        } else {
          Navigator.of(context).pop();
        }
      });
      if (body.containsKey('statusCode')) {
        errorResponse = ErrorResponse.fromJson(body);
      } else {
        loginResponse = LoginResponse.fromJson(body);
        ConfigSharedPreferences().setStringValue(
          SharedData.TOKEN.toString(),
          loginResponse.token!,
        );
        ConfigSharedPreferences().setStringValue(
          SharedData.USERNAME.toString(),
          loginResponse.userResponse!.email,
        );
        ConfigSharedPreferences().setStringValue(
          SharedData.ID.toString(),
          loginResponse.userResponse!.id,
        );
        if (context.mounted) {
          Navigator.of(context).pop();
          Fluttertoast.showToast(
              msg: "Login Successfully",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16);
          Navigator.pushNamedAndRemoveUntil(
              context, HomePage.routeName, (Route<dynamic> route) => false);
        }
      }
    } catch (error) {
      debugPrint("Fail to login $error");
      setState(() {
        isLoading = false;
        if (isLoading) {
          IsShowDialog().showLoadingDialog(context);
        } else {
          Navigator.of(context).pop();
        }
      });
      Fluttertoast.showToast(
        msg: "Username or password is not correct. Please try again!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 3,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16,
      );
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.all(8),
            margin: const EdgeInsets.only(top: 20),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Food Now',
                  style: TextStyle(
                    fontSize: 32,
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Sign in with email and password \nor continue with social media',
                  style: TextStyle(color: Colors.green),
                  textAlign: TextAlign.center,
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                /// text field user name
                Container(
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  margin: const EdgeInsets.symmetric(vertical: 15),
                  padding: const EdgeInsets.only(left: 16, right: 10),
                  child: TextField(
                    controller: usernameController,
                    keyboardType: TextInputType.emailAddress,
                    cursorColor: Colors.grey,
                    decoration: const InputDecoration(
                      hintText: 'User Name',
                      hintStyle: TextStyle(
                        fontFamily: 'NunitoSans',
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                      ),
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      counterText: '',
                      prefixIcon: Icon(Icons.email_outlined),
                    ),
                    onChanged: (value) {
                      setState(() {
                        username = value;
                      });
                    },
                    style: const TextStyle(
                        color: Colors.black,
                        fontFamily: 'NunitoSans',
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        height: 1.9),
                  ),
                ),

                /// text field password login
                Container(
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  padding: const EdgeInsets.only(left: 16, right: 10),
                  child: TextField(
                    obscureText: !isShowPassword,
                    controller: passwordController,
                    keyboardType: TextInputType.text,
                    cursorColor: Colors.grey,
                    decoration: InputDecoration(
                      hintText: 'Password',
                      hintStyle: const TextStyle(
                        fontFamily: 'NunitoSans',
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                      ),
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      counterText: '',
                      prefixIcon: const Icon(Icons.lock_clock),
                      suffixIcon: GestureDetector(
                        onTap: () {
                          setState(() {
                            isShowPassword = !isShowPassword;
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          child: (isShowPassword == true)
                              ? const Icon(Icons.visibility,
                                  color: Colors.green)
                              : const Icon(
                                  Icons.visibility_off,
                                  color: Colors.green,
                                ),
                        ),
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        password = value;
                      });
                    },
                    style: const TextStyle(
                      color: Colors.black,
                      fontFamily: 'NunitoSans',
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      height: 1.9,
                    ),
                  ),
                ),

                /// button
                GestureDetector(
                  onTap: () {
                    if (Global.isAvailableToClick()) {
                      LoginRequest loginRequest = LoginRequest(
                          usernameController.text, passwordController.text);
                      if (loginRequest.email.isNotEmpty &&
                          loginRequest.password.isNotEmpty) {
                        if (Global().checkEmailAddress(loginRequest.email) ==
                            true) {
                          loginApi(loginRequest);
                        } else {
                          Fluttertoast.showToast(
                            msg: "Invalid email.Please try again!!",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 3,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16,
                          );
                        }
                      } else {
                        Fluttertoast.showToast(
                          msg: "Please enter username and password!!",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 3,
                          backgroundColor: Colors.orange,
                          textColor: Colors.white,
                          fontSize: 16,
                        );
                      }
                    }
                  },
                  child: Container(
                    margin: const EdgeInsets.only(top: 20),
                    height: 50,
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.green,
                    child: const Text(
                      'Continue',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),

                /// social media
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 40,
                        width: 40,
                        padding: const EdgeInsets.all(10),
                        margin: const EdgeInsets.all(15),
                        decoration: const BoxDecoration(
                          color: Color(0xFFF5F6F9),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.facebook_outlined,
                          color: Colors.blue,
                        ),
                      ),
                      Container(
                        height: 40,
                        width: 40,
                        padding: const EdgeInsets.all(10),
                        margin: const EdgeInsets.only(right: 15),
                        decoration: const BoxDecoration(
                          color: Color(0xFFF5F6F9),
                          shape: BoxShape.circle,
                        ),
                        child: Image.asset(ImageAssets.icGoogle),
                      ),
                      Container(
                        height: 40,
                        width: 40,
                        padding: const EdgeInsets.all(10),
                        decoration: const BoxDecoration(
                          color: Color(0xFFF5F6F9),
                          shape: BoxShape.circle,
                        ),
                        child: Image.asset(ImageAssets.icTwitter),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Dont have an account?',
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SignUpPage(),
                          ),
                        );
                      },
                      child: const Text(
                        "Sign up",
                        style: TextStyle(
                          color: Colors.redAccent,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
