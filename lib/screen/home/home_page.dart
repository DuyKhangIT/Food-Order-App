import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../handle_api/handle_api.dart';
import '../../model/get_basket_list/get_basket_response.dart';
import '../../model/get_products/foods_response.dart';
import '../../util/global.dart';
import '../cart/cart_page.dart';
import 'account_fragment.dart';
import 'appbar/menu_header.dart';
import 'favorite_fragment.dart';
import 'home_detail.dart';

class HomePage extends StatefulWidget {
  static String routeName = "/home_screen";
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var selectIndex = 0;
  bool favorites = true;
  bool homePage = true;
  List<FoodsResponse> basketListData = [];

  @override
  void initState() {
    getBasketList();
    super.initState();
  }

  /// call api list cart orders
  Future<void> getBasketList() async {
    GetBasketResponse getBasketResponse;
    Map<String, dynamic>? body;
    try {
      body = await HttpHelper.invokeHttp(
        Uri.parse("${Global.apiAddress}/api/basket/getBasket"),
        RequestType.get,
        headers: null,
        body: null,
      );
      if (body == null) return;
      //get data from api here
      getBasketResponse = GetBasketResponse.fromJson(body);

      setState(() {
        basketListData = getBasketResponse.basketList;
        Global.basketList = basketListData;
        Global.basketId = getBasketResponse.basketId ?? "";
      });
    } catch (error) {
      debugPrint("Fail get basket list  $error");
      rethrow;
    }

    return;
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> screen = [
      const HomeDetail(),
      const FavoriteDetail(),
      const AccountDetail()
    ];

    return Scaffold(
      resizeToAvoidBottomInset: false, //
      appBar: AppBar(
        backgroundColor: Colors.green,
        automaticallyImplyLeading: false,
        title: homePage
            ? const Text(
                "Home",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              )
            : favorites
                ? const Text(
                    "Favorites",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  )
                : const MenuHeader(),
        actions: homePage
            ? [
                GestureDetector(
                  onTap: () {
                    if (basketListData.isNotEmpty) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CartPage(
                            listDataOrder: basketListData,
                          ),
                        ),
                      );
                    } else {
                      Fluttertoast.showToast(
                        msg: "Do not exist order!",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 3,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16,
                      );
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
                          child: const Icon(
                            Icons.shopping_cart_outlined,
                            color: Colors.white,
                          ),
                        ),
                        if (basketListData.isNotEmpty)
                          Positioned(
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
                                basketListData.length > 9
                                    ? "9+"
                                    : "${basketListData.length}",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 10.5,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          )
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
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite), label: 'Favorite'),
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
