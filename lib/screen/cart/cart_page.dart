import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:food_app_project/model/error_response.dart';
import 'package:food_app_project/model/get_products/foods_response.dart';

import '../../handle_api/handle_api.dart';
import '../../model/check_out_order/checkout_order_request.dart';
import '../../model/check_out_order/checkout_order_response.dart';
import '../../model/save_basket/save_basket_request.dart';
import '../../model/save_basket/save_basket_response.dart';
import '../../model/sum_order/sum_order_request.dart';
import '../../model/sum_order/sum_order_response.dart';
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
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
  }

  // call api save basket
  Future<void> saveBasketAPI(SaveBasketRequest request) async {
    setState(() {
      IsShowDialog().showLoadingDialog(context);
    });
    SaveBasketResponse saveBasketResponse;
    ErrorResponse errorResponse;
    Map<String, dynamic>? body;
    try {
      body = await HttpHelper.invokeHttp(
        Uri.parse("${Global.apiAddress}/api/basket/saveBasket"),
        RequestType.post,
        headers: null,
        body: const JsonEncoder().convert(request.toBodyRequest()),
      );
      if (body == null) return;
      if (body.containsKey('statusCode')) {
        errorResponse = ErrorResponse.fromJson(body);
        setState(() {
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
        });
      } else {
        saveBasketResponse = SaveBasketResponse.fromJson(body);
        setState(() {
          Navigator.of(context).pop();
          Fluttertoast.showToast(
            msg: saveBasketResponse.message,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 3,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16,
          );
        });
      }
    } catch (error) {
      debugPrint("Fail to checkout order $error");
      setState(() {
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
      });
      rethrow;
    }
    return;
  }

  /// call api sum order
  Future<SumOrderResponse> sumOrderApi(SumOrderRequest sumOrderRequest) async {
    setState(() {
      isLoading = true;
      if (isLoading) {
        IsShowDialog().showLoadingDialog(context);
      } else {
        Navigator.of(context).pop();
      }
    });
    SumOrderResponse sumOrderResponse;
    Map<String, dynamic>? body;
    try {
      body = await HttpHelper.invokeHttp(
          Uri.parse("http://14.225.204.248:7070/api/order/sum"),
          RequestType.post,
          headers: null,
          body: const JsonEncoder().convert(sumOrderRequest.toBodyRequest()));
    } catch (error) {
      debugPrint("Fail to sum order $error");
      rethrow;
    }
    if (body == null) return SumOrderResponse.buildDefault();
    sumOrderResponse = SumOrderResponse.fromJson(body);
    if (sumOrderResponse.status == false) {
      setState(() {
        isLoading = false;
        if (isLoading) {
          IsShowDialog().showLoadingDialog(context);
        } else {
          Navigator.of(context).pop();
        }
        Fluttertoast.showToast(
            msg: "Sum order fail!",
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

          IsShowDialog().showDialogContent(context,
              "${sumOrderResponse.dataSumOrderResponse!.total}.000 VND");
        }
      });
    }

    return sumOrderResponse;
  }

  /// call api checkout  order
  Future<CheckoutOrderResponse> checkoutOrderApi(
      CheckoutOrderRequest checkoutOrderRequest) async {
    setState(() {
      isLoading = true;
      if (isLoading) {
        IsShowDialog().showLoadingDialog(context);
      } else {
        Navigator.of(context).pop();
      }
    });
    CheckoutOrderResponse checkoutOrderResponse;
    Map<String, dynamic>? body;
    try {
      body = await HttpHelper.invokeHttp(
          Uri.parse("http://14.225.204.248:7070/api/order/checkout"),
          RequestType.post,
          headers: null,
          body: const JsonEncoder()
              .convert(checkoutOrderRequest.toBodyRequest()));
    } catch (error) {
      debugPrint("Fail to checkout order $error");
      rethrow;
    }
    if (body == null) return CheckoutOrderResponse.buildDefault();
    checkoutOrderResponse = CheckoutOrderResponse.fromJson(body);
    if (checkoutOrderResponse.status == false) {
      setState(() {
        isLoading = false;
        if (isLoading) {
          IsShowDialog().showLoadingDialog(context);
        } else {
          Navigator.of(context).pop();
        }
        Fluttertoast.showToast(
            msg: "Checkout order fail!",
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
              msg: "Checkout order successfully",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 3,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16);
          Global.orderId = "";
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const HomePage()),
          );
        }
      });
    }

    return checkoutOrderResponse;
  }

  void removeFoodToBasket(FoodsResponse food) {
    setState(() {
      widget.listDataOrder.remove(food);
      Global.basketList = widget.listDataOrder;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          "Cart Details",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
          InkWell(
            onTap: () {
              SaveBasketRequest request =
                  SaveBasketRequest(widget.listDataOrder);
              saveBasketAPI(request);
            },
            child: const Padding(
              padding: EdgeInsets.only(right: 20),
              child: Text(
                "Save Basket",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
      body: bodyCart(),
    );
  }

  Widget bodyCart() {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: widget.listDataOrder.length,
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
                }),
          ),
          checkOutAndSumCart()
        ],
      ),
    );
  }

  Widget cartItem(index) {
    var item = widget.listDataOrder[index];
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
                onTap: () {
                  removeFoodToBasket(item);
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
              if (Global.orderId.isNotEmpty) {
                SumOrderRequest sumOrderRequest =
                    SumOrderRequest(Global.orderId);
                sumOrderApi(sumOrderRequest);
              }
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
              if (Global.orderId.isNotEmpty) {
                CheckoutOrderRequest checkoutOrderRequest =
                    CheckoutOrderRequest(Global.orderId);
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
