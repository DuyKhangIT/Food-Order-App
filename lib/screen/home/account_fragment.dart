import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../assets/images.dart';
import '../../handle_api/handle_api.dart';
import '../../model/change_account/change_account_request.dart';
import '../../model/change_account/change_account_response.dart';
import '../../util/global.dart';
import '../../util/share_preferences.dart';
import '../../util/show_loading_dialog.dart';
import 'home_page.dart';

class AccountDetail extends StatefulWidget {
  const AccountDetail({Key? key}) : super(key: key);

  @override
  State<AccountDetail> createState() => _AccountDetailState();
}

class _AccountDetailState extends State<AccountDetail> {
  TextEditingController changeOldPasswordController = TextEditingController();
  TextEditingController changeNewPasswordController = TextEditingController();
  TextEditingController changeConfirmNewPasswordController =
      TextEditingController();
  String changeOldPassword = "";
  String changeNewPassword = "";
  String changeConfirmNewPassword = "";
  bool isShowChangeOldPassword = false;
  bool isShowChangeNewPassword = false;
  bool isShowChangeConfirmNewPassword = false;
  bool isLoading = false;
  String username = "";

  @override
  void initState() {
    getUserName();
    super.initState();
  }

  Future<void> getUserName() async {
    username = await ConfigSharedPreferences()
        .getStringValue(SharedData.USERNAME.toString(), defaultValue: "");
    setState(() {
      username;
    });
  }

  /// call api change account
  Future<ChangeAccountResponse> changeAccountApi(
      ChangeAccountRequest changeAccountRequest) async {
    setState(() {
      isLoading = true;
      if (isLoading) {
        IsShowDialog().showLoadingDialog(context);
      } else {
        Navigator.of(context).pop();
      }
    });
    ChangeAccountResponse changeAccountResponse;
    Map<String, dynamic>? body;
    try {
      body = await HttpHelper.invokeHttp(
          Uri.parse("http://14.225.204.248:7070/api/user/update-user"),
          RequestType.put,
          headers: null,
          body: const JsonEncoder()
              .convert(changeAccountRequest.toBodyRequest()));
    } catch (error) {
      debugPrint("Fail to change account $error");
      rethrow;
    }
    if (body == null) return ChangeAccountResponse.buildDefault();
    changeAccountResponse = ChangeAccountResponse.fromJson(body);
    if (changeAccountResponse.status == false) {
      setState(() {
        isLoading = false;
        if (isLoading) {
          IsShowDialog().showLoadingDialog(context);
        } else {
          Navigator.of(context).pop();
        }
        Fluttertoast.showToast(
            msg: "Password is not correct. Please try again!",
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
              msg: "Change Account Successfully",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 3,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16);
          Navigator.pushNamedAndRemoveUntil(
              context, HomePage.routeName, (Route<dynamic> route) => false);
        }
      });
    }
    return changeAccountResponse;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
      child: Column(
        children: [
          changeEmailTextField(),
          changeOldPasswordTextField(),
          changeNewPasswordTextField(),
          changeConfirmNewPasswordTextField(),

          /// button continue
          SizedBox(
            height: 50,
            width: MediaQuery.of(context).size.width,
            child: InkWell(
              onTap: () {
                if (Global.isAvailableToClick()) {
                  if (username.isNotEmpty &&
                      changeOldPassword.isNotEmpty &&
                      changeNewPassword.isNotEmpty &&
                      changeConfirmNewPassword.isNotEmpty) {
                    if (changeNewPassword == changeConfirmNewPassword) {
                      ChangeAccountRequest changeAccountRequest =
                          ChangeAccountRequest(
                              username, changeOldPassword, changeNewPassword);
                      changeAccountApi(changeAccountRequest);
                    } else {
                      Fluttertoast.showToast(
                          msg: "Password and Confirm password do not match!",
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
              },
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(8)),
                alignment: Alignment.center,
                child: const Text(
                  "Change",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),

          /// social media
          SizedBox(
              width: MediaQuery.of(context).size.width,
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Container(
                    height: 40,
                    width: 40,
                    padding: const EdgeInsets.all(10),
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
              ])),
        ],
      ),
    );
  }

  /// text field change email
  Widget changeEmailTextField() {
    return Container(
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(6),
      ),
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.only(left: 16, right: 10),
      child: TextField(
        keyboardType: TextInputType.text,
        cursorColor: Colors.grey,
        decoration: InputDecoration(
            hintText: username,
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
            suffixIcon: const Icon(Icons.email_outlined)),
        readOnly: true,
        style: const TextStyle(
            color: Colors.black,
            fontFamily: 'NunitoSans',
            fontSize: 14,
            fontWeight: FontWeight.w400,
            height: 1.9),
      ),
    );
  }

  /// text field change old password
  Widget changeOldPasswordTextField() {
    return Container(
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(6),
      ),
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.only(left: 16, right: 10),
      child: TextField(
        obscureText: !isShowChangeOldPassword,
        controller: changeOldPasswordController,
        keyboardType: TextInputType.text,
        cursorColor: Colors.grey,
        decoration: InputDecoration(
          hintText: 'Enter Your Old Password',
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
                      isShowChangeOldPassword = !isShowChangeOldPassword;
                    });
                  },
                  child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: (isShowChangeOldPassword == true)
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
            changeOldPassword = value;
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

  /// text field change new password
  Widget changeNewPasswordTextField() {
    return Container(
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(6),
      ),
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.only(left: 16, right: 10),
      child: TextField(
        obscureText: !isShowChangeNewPassword,
        controller: changeNewPasswordController,
        keyboardType: TextInputType.text,
        cursorColor: Colors.grey,
        decoration: InputDecoration(
          hintText: 'Enter Your New Password',
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
                      isShowChangeNewPassword = !isShowChangeNewPassword;
                    });
                  },
                  child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: (isShowChangeNewPassword == true)
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
            changeNewPassword = value;
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

  /// text field change confirm new password
  Widget changeConfirmNewPasswordTextField() {
    return Container(
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(6),
      ),
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.only(left: 16, right: 10),
      child: TextField(
        obscureText: !isShowChangeConfirmNewPassword,
        controller: changeConfirmNewPasswordController,
        keyboardType: TextInputType.text,
        cursorColor: Colors.grey,
        decoration: InputDecoration(
          hintText: 'Enter Your Confirm New Password',
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
                      isShowChangeConfirmNewPassword =
                          !isShowChangeConfirmNewPassword;
                    });
                  },
                  child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: (isShowChangeConfirmNewPassword == true)
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
            changeConfirmNewPassword = value;
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
