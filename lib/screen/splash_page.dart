import 'package:flutter/material.dart';
import 'package:food_app_project/screen/sign_in/sign_in_page.dart';

import '../util/global.dart';
import '../util/share_preferences.dart';
import 'home/home_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);
  static String routeName = "/splash_page";
  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  bool isNewUser = false;
  @override
  void initState() {
    checkAlreadyLoggedIn();
    super.initState();
  }

  /// check login with shared preferences
  Future<void> checkAlreadyLoggedIn() async {
    String? userId = await ConfigSharedPreferences()
        .getStringValue(SharedData.TOKEN.toString(), defaultValue: "");
    if (userId.isEmpty || userId == "") {
      setState(() {
        isNewUser = true;
      });
    } else {
      loadData(userId);
    }
  }

  Future<void> loadData(String token) async {
    await Future.delayed(const Duration(seconds: 3));
    setState(() {
      Global.token = token;
      Navigator.pushNamedAndRemoveUntil(
        context,
        HomePage.routeName,
        (Route<dynamic> route) => false,
      );
    });
  }

  // Future<GetOrderResponse> getListCartOrders() async {
  //   GetOrderResponse getOrderResponse;
  //   Map<String, dynamic>? body;
  //   try {
  //     body = await HttpHelper.invokeHttp(
  //         Uri.parse("http://14.225.204.248:7070/api/order/$userId"),
  //         RequestType.get,
  //         headers: null,
  //         body: null);
  //   } catch (error) {
  //     debugPrint("Fail to list cart orders $error");
  //     rethrow;
  //   }
  //   if (body == null) return GetOrderResponse.buildDefault();
  //   //get data from api here
  //   getOrderResponse = GetOrderResponse.fromJson(body);
  //
  //   List<OrderDetailResponseGet> orderDetailResponse = [];
  //   if (getOrderResponse.dataGetOrderResponse!.responseOrderList != null) {
  //     for (int i = 0;
  //     i <
  //         getOrderResponse.dataGetOrderResponse!.responseOrderList!
  //             .orderDetailResponseGet!.length;
  //     i++) {
  //       OrderDetailResponseGet orderDetailResponseGet = getOrderResponse
  //           .dataGetOrderResponse!
  //           .responseOrderList!
  //           .orderDetailResponseGet![i];
  //       orderDetailResponse.add(OrderDetailResponseGet(
  //         orderDetailResponseGet.id ??= "",
  //         orderDetailResponseGet.title ??= "",
  //         orderDetailResponseGet.description ??= "",
  //         orderDetailResponseGet.image ??= "",
  //         orderDetailResponseGet.price ??= 0,
  //       ));
  //     }
  //     setState(() {
  //       if (getOrderResponse.dataGetOrderResponse!.responseOrderList!
  //           .orderDetailResponseGet !=
  //           null &&
  //           getOrderResponse.dataGetOrderResponse!.responseOrderList!
  //               .orderDetailResponseGet!.isNotEmpty) {
  //         listDataOrder = getOrderResponse
  //             .dataGetOrderResponse!.responseOrderList!.orderDetailResponseGet!;
  //       }
  //       if (getOrderResponse
  //           .dataGetOrderResponse!.responseOrderList!.orderId.isNotEmpty) {
  //         Global.orderId =
  //             getOrderResponse.dataGetOrderResponse!.responseOrderList!.orderId;
  //       }
  //     });
  //   }
  //
  //   return getOrderResponse;
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(color: Colors.green),
          child: isNewUser == false

              /// loading
              ? const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(
                      backgroundColor: Colors.white,
                      strokeWidth: 5,
                    ),
                    SizedBox(height: 15),
                    Text('loading...',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18)),
                  ],
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    /// start for new joiner
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height / 1.5,
                      margin: const EdgeInsets.only(top: 50),
                      alignment: Alignment.center,
                      child: const Text('Food Now',
                          style: TextStyle(
                              fontSize: 40,
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                    ),

                    /// button start
                    Expanded(
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: InkWell(
                          onTap: () {
                            Navigator.pushNamedAndRemoveUntil(
                                context,
                                SignInPage.routeName,
                                (Route<dynamic> route) => false);
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 50,
                            alignment: Alignment.center,
                            margin: const EdgeInsets.only(
                                left: 20, right: 20, bottom: 30),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white,
                            ),
                            child: Text(
                              'Start'.toUpperCase(),
                              style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
