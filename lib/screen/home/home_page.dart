import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../handle_api/handle_api.dart';
import '../../model/get_order/get_order_response/get_order_response.dart';
import '../../model/get_order/get_order_response/order_detail_response_get.dart';
import '../../util/global.dart';
import '../../util/share_preferences.dart';
import '../cart/cart_page.dart';
import 'account_fragment.dart';
import 'appbar/menu_header.dart';
import 'favorite_fragment.dart';
import 'home_detail.dart';
import 'notification_fragment.dart';

class HomePage extends StatefulWidget {
  static String routeName = "/home_screen";
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var selectIndex = 0;
  bool favorites = true;
  bool notification = true;
  bool homePage = true;
  List<OrderDetailResponseGet>? listDataOrder;
  String userId = "";

  Future<void> getUserName() async {
    userId = await ConfigSharedPreferences()
        .getStringValue(SharedData.ID.toString(), defaultValue: "");
    setState(() {
      if (userId.isNotEmpty || userId != "") {
        getListCartOrders();
      }
    });
  }

  @override
  void initState() {
    getUserName();
    super.initState();
  }

  /// call api list cart orders
  Future<GetOrderResponse> getListCartOrders() async {
    GetOrderResponse getOrderResponse;
    Map<String, dynamic>? body;
    try {
      body = await HttpHelper.invokeHttp(
          Uri.parse("http://14.225.204.248:7070/api/order/$userId"),
          RequestType.get,
          headers: null,
          body: null);
    } catch (error) {
      debugPrint("Fail to list cart orders $error");
      rethrow;
    }
    if (body == null) return GetOrderResponse.buildDefault();
    //get data from api here
    getOrderResponse = GetOrderResponse.fromJson(body);

    List<OrderDetailResponseGet> orderDetailResponse = [];
    if (getOrderResponse.dataGetOrderResponse!.responseOrderList != null) {
      for (int i = 0;
          i <
              getOrderResponse.dataGetOrderResponse!.responseOrderList!
                  .orderDetailResponseGet!.length;
          i++) {
        OrderDetailResponseGet orderDetailResponseGet = getOrderResponse
            .dataGetOrderResponse!
            .responseOrderList!
            .orderDetailResponseGet![i];
        orderDetailResponse.add(OrderDetailResponseGet(
          orderDetailResponseGet.id ??= "",
          orderDetailResponseGet.title ??= "",
          orderDetailResponseGet.description ??= "",
          orderDetailResponseGet.image ??= "",
          orderDetailResponseGet.price ??= 0,
        ));
      }
      setState(() {
        if (getOrderResponse.dataGetOrderResponse!.responseOrderList!
                    .orderDetailResponseGet !=
                null &&
            getOrderResponse.dataGetOrderResponse!.responseOrderList!
                .orderDetailResponseGet!.isNotEmpty) {
          listDataOrder = getOrderResponse
              .dataGetOrderResponse!.responseOrderList!.orderDetailResponseGet!;
        }
        if (getOrderResponse
            .dataGetOrderResponse!.responseOrderList!.orderId.isNotEmpty) {
          Global.orderId =
              getOrderResponse.dataGetOrderResponse!.responseOrderList!.orderId;
        }
      });
    }

    return getOrderResponse;
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> screen = [
      const HomeDetail(),
      const FavoriteDetail(),
      const NotificationDetail(),
      const AccountDetail()
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        automaticallyImplyLeading: false,
        title: homePage
            ? const Text("Home")
            : favorites
                ? const Text("Favorites")
                : notification
                    ? const Text("Notificaitons")
                    : const MenuHeader(),
        actions: homePage
            ? [
                GestureDetector(
                  onTap: () {
                    if (listDataOrder != null && listDataOrder!.isNotEmpty) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CartPage(
                                  dataOrder: listDataOrder,
                                )),
                      );
                    } else {
                      Fluttertoast.showToast(
                          msg: "Do not exist order!",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 3,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16);
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 20, top: 5),
                    child: Stack(
                      children: [
                        Container(
                          height: 40,
                          width: 40,
                          padding: const EdgeInsets.all(10),
                          child: const Icon(Icons.shopping_cart_outlined),
                        ),
                        listDataOrder != null && listDataOrder!.isNotEmpty
                            ? Positioned(
                                right: 0,
                                child: Container(
                                  padding: const EdgeInsets.all(1.5),
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  constraints: const BoxConstraints(
                                    minWidth: 16,
                                    minHeight: 16,
                                  ),
                                  child: Text(
                                    listDataOrder!.length > 9
                                        ? "9+"
                                        : "${listDataOrder!.length}",
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 10.5,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              )
                            : Container()
                      ],
                    ),
                  ),
                )
              ]
            : null,
        centerTitle: true,
        elevation: 0,
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.green,
        type: BottomNavigationBarType.fixed,
        currentIndex: selectIndex,
        onTap: (index) {
          setState(() {
            selectIndex = index;
            if (selectIndex == 0) {
              homePage = true;
            } else {
              homePage = false;
            }
            if (selectIndex == 1) {
              favorites = true;
            } else {
              favorites = false;
            }
            if (selectIndex == 2) {
              notification = true;
            } else {
              notification = false;
            }
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite), label: 'Favorite'),
          BottomNavigationBarItem(
              icon: Icon(Icons.notifications), label: 'Notifications'),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle), label: 'Account'),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            screen[selectIndex]
          ],
        ),
      ),
    );
  }
}
