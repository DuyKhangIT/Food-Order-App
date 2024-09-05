import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../assets/images.dart';
import '../../handle_api/handle_api.dart';
import '../../model/register/register_request.dart';
import '../../model/register/register_response.dart';
import '../../util/global.dart';
import '../../util/show_loading_dialog.dart';
import '../sign_in/sign_in_page.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({Key? key}) : super(key: key);

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmController = TextEditingController();
  String email = "";
  String password = "";
  String confirmPassword = "";
  bool isShowPassword = false;
  bool isShowConfirmPassword = false;
  bool isLoading = false;

  /// call api register
  Future<RegisterResponse> registerApi(RegisterRequest registerRequest) async {
    setState(() {
      isLoading = true;
      if (isLoading) {
        IsShowDialog().showLoadingDialog(context);
      } else {
        Navigator.of(context).pop();
      }
    });
    RegisterResponse registerResponse;
    Map<String, dynamic>? body;
    try {
      body = await HttpHelper.invokeHttp(
          Uri.parse("http://14.225.204.248:7070/api/user/register"),
          RequestType.post,
          headers: null,
          body: const JsonEncoder().convert(registerRequest.toBodyRequest()));
    } catch (error) {
      debugPrint("Fail to register $error");
      rethrow;
    }
    if (body == null) return RegisterResponse.buildDefault();
    registerResponse = RegisterResponse.fromJson(body);
    if (registerResponse.status == false) {
      setState(() {
        isLoading = false;
        if (isLoading) {
          IsShowDialog().showLoadingDialog(context);
        } else {
          Navigator.of(context).pop();
        }
        Fluttertoast.showToast(
            msg: "Username or password is not correct. Please try again!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 3,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16);
      });
    } else {
      setState(() {
        isLoading = false;
        if (isLoading) {
          IsShowDialog().showLoadingDialog(context);
        } else {
          Navigator.of(context).pop();
          Fluttertoast.showToast(
              msg: "Register Successfully",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 3,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16);
          Navigator.pushNamedAndRemoveUntil(
              context, SignInPage.routeName, (Route<dynamic> route) => false);
        }
      });
    }
    return registerResponse;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 50, 10, 0),
      child: Column(
        children: [
          emailTextField(),
          passwordTextField(),
          confirmPasswordTextField(),

          /// button
          Container(
            height: 50,
            width: MediaQuery.of(context).size.width,
            color: Colors.green,
            child: TextButton(
              onPressed: () {
                setState(() {
                  if (Global.isAvailableToClick()) {
                    RegisterRequest registerRequest =
                        RegisterRequest(email, password);
                    if (emailController.text.isNotEmpty &&
                        passwordController.text.isNotEmpty &&
                        confirmController.text.isNotEmpty) {
                      if (Global().checkEmailAddress(email) == true) {
                        if (passwordController.text == confirmController.text) {
                          registerApi(registerRequest);
                        } else {
                          Fluttertoast.showToast(
                              msg:
                                  "Password and Confirm password do not match!",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 3,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: 16);
                        }
                      } else {
                        Fluttertoast.showToast(
                            msg: "Invalid email.Please try again!",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 3,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16);
                      }
                    } else {
                      Fluttertoast.showToast(
                          msg: "Please enter enough information!",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 3,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16);
                    }
                  }
                });
              },
              child: const Text(
                'Continue',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
          ),

          /// social media
          Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(top: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    height: 40,
                    width: 40,
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.only(right: 10),
                    decoration: const BoxDecoration(
                        color: Color(0xFFF5F6F9), shape: BoxShape.circle),
                    child: const Icon(
                      Icons.facebook_outlined,
                      color: Colors.blue,
                    )),
                Container(
                    height: 40,
                    width: 40,
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.only(right: 10),
                    decoration: const BoxDecoration(
                        color: Color(0xFFF5F6F9), shape: BoxShape.circle),
                    child: Image.asset(ImageAssets.icGoogle)),
                Container(
                    height: 40,
                    width: 40,
                    padding: const EdgeInsets.all(10),
                    decoration: const BoxDecoration(
                        color: Color(0xFFF5F6F9), shape: BoxShape.circle),
                    child: Image.asset(ImageAssets.icTwitter))
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// text field user name
  Widget emailTextField() {
    return Container(
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(6),
      ),
      margin: const EdgeInsets.only(bottom: 30),
      padding: const EdgeInsets.only(left: 16, right: 10),
      child: TextField(
        controller: emailController,
        keyboardType: TextInputType.text,
        cursorColor: Colors.grey,
        decoration: const InputDecoration(
            hintText: 'Enter Your Email',
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
            suffixIcon: Icon(Icons.email_outlined)),
        onChanged: (value) {
          setState(() {
            email = value;
          });
        },
        style: const TextStyle(
            color: Colors.black,
            fontFamily: 'NunitoSans',
            fontSize: 14,
            fontWeight: FontWeight.w400,
            height: 1.9),
      ),
    );
  }

  /// text field password sign up
  Widget passwordTextField() {
    return Container(
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(6),
      ),
      margin: const EdgeInsets.only(bottom: 30),
      padding: const EdgeInsets.only(left: 16, right: 10),
      child: TextField(
        obscureText: !isShowPassword,
        controller: passwordController,
        keyboardType: TextInputType.text,
        cursorColor: Colors.grey,
        decoration: InputDecoration(
          hintText: 'Enter Your Password',
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
          suffixIcon: SizedBox(
            width: 80,
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isShowPassword = !isShowPassword;
                    });
                  },
                  child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: (isShowPassword == true)
                          ? const Icon(Icons.visibility, color: Colors.green)
                          : const Icon(
                              Icons.visibility_off,
                              color: Colors.green,
                            )),
                ),
                const SizedBox(width: 20),
                const Icon(Icons.lock_clock),
              ],
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
            height: 1.9),
      ),
    );
  }

  /// text field confirm password sign up
  Widget confirmPasswordTextField() {
    return Container(
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(6),
      ),
      margin: const EdgeInsets.only(bottom: 30),
      padding: const EdgeInsets.only(left: 16, right: 10),
      child: TextField(
        obscureText: !isShowConfirmPassword,
        controller: confirmController,
        keyboardType: TextInputType.text,
        cursorColor: Colors.grey,
        decoration: InputDecoration(
          hintText: 'Enter Your Confirm Password',
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
          suffixIcon: SizedBox(
            width: 80,
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isShowConfirmPassword = !isShowConfirmPassword;
                    });
                  },
                  child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: (isShowConfirmPassword == true)
                          ? const Icon(Icons.visibility, color: Colors.green)
                          : const Icon(
                              Icons.visibility_off,
                              color: Colors.green,
                            )),
                ),
                const SizedBox(width: 20),
                const Icon(Icons.lock_clock),
              ],
            ),
          ),
        ),
        onChanged: (value) {
          setState(() {
            confirmPassword = value;
          });
        },
        style: const TextStyle(
            color: Colors.black,
            fontFamily: 'NunitoSans',
            fontSize: 14,
            fontWeight: FontWeight.w400,
            height: 1.9),
      ),
    );
  }
}
