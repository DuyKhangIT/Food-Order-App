import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:food_app_project/model/error_response.dart';
import 'package:food_app_project/model/get_products/foods_response.dart';

import '../../handle_api/handle_api.dart';
import '../../model/add_or_remove_item_basket/basket_request.dart';
import '../../model/add_or_remove_item_basket/basket_response.dart';
import '../../model/check_out_order/checkout_order_request.dart';
import '../../model/check_out_order/checkout_order_response.dart';
import '../../util/global.dart';

import '../../util/show_loading_dialog.dart';
import '../home/home_page.dart';

class CartPage extends StatefulWidget {
  static String routeName = "/cart_screen";
  final List<FoodsResponse> listDataOrder;
  const CartPage({Key? key, required this.listDataOrder}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<FoodsResponse> basketList = [];
  @override
  void initState() {
    basketList = widget.listDataOrder;
    super.initState();
  }

  // call api save basket
  Future<void> removeFromBasket(BasketRequest request) async {
    IsShowDialog().showLoadingDialog(context);
    BasketResponse response;
    ErrorResponse errorResponse;
    Map<String, dynamic>? body;
    try {
      body = await HttpHelper.invokeHttp(
        Uri.parse("${Global.apiAddress}/api/basket/removeFromBasket"),
        RequestType.post,
        headers: null,
        body: const JsonEncoder().convert(request.toBodyRequest()),
      );
      if (body == null) return;
      if (body.containsKey('statusCode')) {
        errorResponse = ErrorResponse.fromJson(body);
        Navigator.of(context).pop();
        Fluttertoast.showToast(
          msg: errorResponse.errorMessage,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16,
        );
      } else {
        response = BasketResponse.fromJson(body);
        setState(() {
          basketList = response.basketList;
          Global.basketList = basketList;
        });
        Navigator.of(context).pop();
        Fluttertoast.showToast(
          msg: response.message,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16,
        );
      }
    } catch (error) {
      debugPrint("Fail to checkout order $error");
      Navigator.of(context).pop();
      Fluttertoast.showToast(
        msg: "Server Error",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 3,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16,
      );
      rethrow;
    }
    return;
  }

  /// call api sum order
  void sumOrderApi() async {
    var total = 0;
    for (var item in basketList) {
      if (item.price != null && item.price != 0) {
        total += item.price!;
      }
    }
    IsShowDialog().showDialogContent(context, "$total.000 VND");
  }

  /// call api checkout  order
  Future<void> checkoutOrderApi(
    CheckoutOrderRequest checkoutOrderRequest,
  ) async {
    IsShowDialog().showLoadingDialog(context);
    CheckoutOrderResponse checkoutOrderResponse;
    ErrorResponse errorResponse;
    Map<String, dynamic>? body;
    try {
      body = await HttpHelper.invokeHttp(
        Uri.parse("${Global.apiAddress}/api/basket/checkoutBasket"),
        RequestType.post,
        headers: null,
        body: const JsonEncoder().convert(checkoutOrderRequest.toBodyRequest()),
      );
      if (body == null) return;

      if (body.containsKey('statusCode')) {
        errorResponse = ErrorResponse.fromJson(body);
        Navigator.of(context).pop();
        Fluttertoast.showToast(
          msg: errorResponse.errorMessage,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16,
        );
      } else {
        checkoutOrderResponse = CheckoutOrderResponse.fromJson(body);
        Navigator.of(context).pop();
        Fluttertoast.showToast(
          msg: checkoutOrderResponse.message,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16,
        );
        Global.basketId = "";
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
          (Route<dynamic> route) => false,
        );
      }
    } catch (error) {
      debugPrint("Fail to checkout order $error");
      rethrow;
    }

    return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        iconTheme: const IconThemeData(color: Colors.white),
        leading: InkWell(
          onTap: () {
            Navigator.pushNamedAndRemoveUntil(
              context,
              HomePage.routeName,
              (Route<dynamic> route) => false,
            ).then((value) {
              setState(() {});
            });
          },
          child: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        title: const Text(
          "Cart Details",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: bodyCart(),
      bottomNavigationBar: checkOutAndSumCart(),
    );
  }

  Widget bodyCart() {
    return basketList.isNotEmpty
        ? ListView.builder(
            shrinkWrap: true,
            itemCount: basketList.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: cartItem(index),
                  ),
                  const Divider()
                ],
              );
            },
          )
        : const Center(
            child: Text(
              'Giỏ hàng trống',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
          );
  }

  Widget cartItem(index) {
    var item = basketList[index];
    return Container(
      color: const Color(0xFFF5F5F5),
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// title + price + delete
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: 80,
                height: 80,
                margin: const EdgeInsets.only(right: 10),
                child: Image.network(item.image!, fit: BoxFit.cover),
              ),
              Container(
                  constraints: const BoxConstraints(maxWidth: 140),
                  height: 30,
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.only(right: 10),
                  child: Text(
                    item.title!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  )),
              Container(
                  constraints: const BoxConstraints(maxWidth: 80),
                  height: 20,
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.only(right: 10),
                  child: Text(
                    "${item.price!}.000 VND",
                    maxLines: 1,
                  )),
              GestureDetector(
                onTap: () async {
                  if (item.id != null && item.id!.isNotEmpty) {
                    BasketRequest request = BasketRequest(item.id!);
                    await removeFromBasket(request);
                  }
                },
                child: const Icon(Icons.delete_outline),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget checkOutAndSumCart() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            if (Global.isAvailableToClick()) {
              sumOrderApi();
            }
          },
          child: Container(
            width: MediaQuery.of(context).size.width / 2,
            height: 50,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.green), color: Colors.white),
            child: Text(
              "Sum".toUpperCase(),
              style: const TextStyle(fontSize: 14),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            if (Global.isAvailableToClick()) {
              if (Global.basketId.isNotEmpty) {
                print('Basket ID: ${Global.basketId}');
                CheckoutOrderRequest checkoutOrderRequest =
                    CheckoutOrderRequest(Global.basketId);
                checkoutOrderApi(checkoutOrderRequest);
              }
            }
          },
          child: Container(
            width: MediaQuery.of(context).size.width / 2,
            height: 50,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.green), color: Colors.green),
            child: Text(
              "Check out".toUpperCase(),
              style: const TextStyle(fontSize: 14, color: Colors.white),
            ),
          ),
        )
      ],
    );
  }
}
