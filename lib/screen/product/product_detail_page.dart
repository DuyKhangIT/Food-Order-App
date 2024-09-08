import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../handle_api/handle_api.dart';
import '../../model/add_favorite/add_favorite_request.dart';
import '../../model/add_favorite/add_favorite_response.dart';
import '../../model/check_is_fav/check_is_fav_requuest.dart';
import '../../model/check_is_fav/check_is_favorite_response.dart';
import '../../model/get_products/foods_response.dart';
import '../../model/post_order/order_request/post_order_request.dart';
import '../../model/post_order/order_response/post_order_response.dart';
import '../../util/global.dart';
import '../../util/share_preferences.dart';
import '../../util/show_loading_dialog.dart';
import '../home/home_page.dart';

class ProductDetailPage extends StatefulWidget {
  final FoodsResponse? dataFood;
  static String routeName = "/product_screen";
  const ProductDetailPage({Key? key, required this.dataFood}) : super(key: key);

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  bool isLoading = false;
  String username = "";
  int? isFavorite;
  int? del;

  @override
  void initState() {
    getUserName();
    super.initState();
  }

  Future<void> getUserName() async {
    username = await ConfigSharedPreferences()
        .getStringValue(SharedData.EMAIL.toString(), defaultValue: "");
    setState(() {
      if (username.isNotEmpty && widget.dataFood!.id!.isNotEmpty) {
        CheckIsFavoriteRequest checkIsFavoriteRequest =
            CheckIsFavoriteRequest(username, widget.dataFood!.id!);
        checkIsFavoriteApi(checkIsFavoriteRequest);
      }
    });
  }

  /// call api add to cart
  Future<PostOrderResponse> addToCartApi(
      PostOrderRequest postOrderRequest) async {
    setState(() {
      isLoading = true;
      if (isLoading) {
        IsShowDialog().showLoadingDialog(context);
      } else {
        Navigator.of(context).pop();
      }
    });
    PostOrderResponse postOrderResponse;
    Map<String, dynamic>? body;
    try {
      body = await HttpHelper.invokeHttp(
          Uri.parse("http://14.225.204.248:7070/api/order"), RequestType.post,
          headers: null,
          body: const JsonEncoder().convert(postOrderRequest.toBodyRequest()));
    } catch (error) {
      debugPrint("Fail to add to cart $error");
      setState(() {
        isLoading = false;
        if (isLoading) {
          IsShowDialog().showLoadingDialog(context);
        } else {
          Navigator.of(context).pop();
          Fluttertoast.showToast(
              msg: "Error from server",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16);
        }
      });
      rethrow;
    }
    if (body == null) return PostOrderResponse.buildDefault();
    postOrderResponse = PostOrderResponse.fromJson(body);
    if (postOrderResponse.status == false) {
      setState(() {
        isLoading = false;
        if (isLoading) {
          IsShowDialog().showLoadingDialog(context);
        } else {
          Navigator.of(context).pop();
        }
      });
      Fluttertoast.showToast(
          msg: "Add to cart fail",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16);
    } else {
      setState(() {
        isLoading = false;
        if (isLoading) {
          IsShowDialog().showLoadingDialog(context);
        } else {
          Navigator.of(context).pop();
          Fluttertoast.showToast(
              msg: "Add to cart Successfully",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16);
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const HomePage()));
        }
      });
    }

    return postOrderResponse;
  }

  /// call api add to favorite
  Future<AddFavoriteResponse> addToFavoriteApi(
      AddFavoriteRequest addFavoriteRequest) async {
    setState(() {
      isLoading = true;
      if (isLoading) {
        IsShowDialog().showLoadingDialog(context);
      } else {
        Navigator.of(context).pop();
      }
    });
    AddFavoriteResponse addFavoriteResponse;
    Map<String, dynamic>? body;
    try {
      body = await HttpHelper.invokeHttp(
          Uri.parse("http://14.225.204.248:7070/api/fav/add"), RequestType.post,
          headers: null,
          body:
              const JsonEncoder().convert(addFavoriteRequest.toBodyRequest()));
    } catch (error) {
      debugPrint("Fail to add to fav $error");
      setState(() {
        isLoading = false;
        if (isLoading) {
          IsShowDialog().showLoadingDialog(context);
        } else {
          Navigator.of(context).pop();
          Fluttertoast.showToast(
              msg: "Error from server",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16);
        }
      });
      rethrow;
    }
    if (body == null) return AddFavoriteResponse.buildDefault();
    addFavoriteResponse = AddFavoriteResponse.fromJson(body);
    if (addFavoriteResponse.status == false) {
      setState(() {
        isLoading = false;
        if (isLoading) {
          IsShowDialog().showLoadingDialog(context);
        } else {
          Navigator.of(context).pop();
        }
      });
      Fluttertoast.showToast(
          msg: "Add to favorite fail",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16);
    } else {
      if (addFavoriteResponse.del == 0) {
        setState(() {
          isLoading = false;
          if (isLoading) {
            IsShowDialog().showLoadingDialog(context);
          } else {
            Navigator.of(context).pop();
            Fluttertoast.showToast(
                msg: "Add to favorite Successfully",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.green,
                textColor: Colors.white,
                fontSize: 16);
            del = addFavoriteResponse.del;
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const HomePage()));
          }
        });
      } else {
        setState(() {
          isLoading = false;
          if (isLoading) {
            IsShowDialog().showLoadingDialog(context);
          } else {
            Navigator.of(context).pop();
            Fluttertoast.showToast(
                msg: "Cancel to favorite Successfully",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.green,
                textColor: Colors.white,
                fontSize: 16);
            del = addFavoriteResponse.del;
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const HomePage()));
          }
        });
      }
    }

    return addFavoriteResponse;
  }

  /// call api check is favorite
  Future<CheckIsFavoriteResponse> checkIsFavoriteApi(
      CheckIsFavoriteRequest checkIsFavoriteRequest) async {
    setState(() {
      isLoading = true;
      if (isLoading) {
        IsShowDialog().showLoadingDialog(context);
      } else {
        Navigator.of(context).pop();
      }
    });
    CheckIsFavoriteResponse checkIsFavoriteResponse;
    Map<String, dynamic>? body;
    try {
      body = await HttpHelper.invokeHttp(
          Uri.parse("http://14.225.204.248:7070/api/fav/isFav"),
          RequestType.post,
          headers: null,
          body: const JsonEncoder()
              .convert(checkIsFavoriteRequest.toBodyRequest()));
    } catch (error) {
      debugPrint("Fail to check fav $error");
      setState(() {
        isLoading = false;
        if (isLoading) {
          IsShowDialog().showLoadingDialog(context);
        } else {
          Navigator.of(context).pop();
          Fluttertoast.showToast(
              msg: "Error from server",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16);
        }
      });
      rethrow;
    }
    if (body == null) return CheckIsFavoriteResponse.buildDefault();
    checkIsFavoriteResponse = CheckIsFavoriteResponse.fromJson(body);
    if (checkIsFavoriteResponse.status == false) {
      setState(() {
        isLoading = false;
        if (isLoading) {
          IsShowDialog().showLoadingDialog(context);
        } else {
          Navigator.of(context).pop();
        }
      });
    } else {
      if (checkIsFavoriteResponse.isFav == 0) {
        setState(() {
          isLoading = false;
          if (isLoading) {
            IsShowDialog().showLoadingDialog(context);
          } else {
            Navigator.of(context).pop();

            isFavorite = checkIsFavoriteResponse.isFav;
          }
        });
      } else {
        setState(() {
          isLoading = false;
          if (isLoading) {
            IsShowDialog().showLoadingDialog(context);
          } else {
            Navigator.of(context).pop();
            isFavorite = checkIsFavoriteResponse.isFav;
          }
        });
      }
    }

    return checkIsFavoriteResponse;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        leading: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const HomePage()),
            );
          },
          child: const Icon(Icons.arrow_back),
        ),
        title: const Text("Details"),
      ),
      body: bodyProduct(context),
      bottomNavigationBar: Container(
        width: MediaQuery.of(context).size.width,
        height: 130,
        margin: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// quantity
            addToFavourite(context),
            addToCart(context),
          ],
        ),
      ),
    );
  }

  Widget bodyProduct(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 250,
            margin: const EdgeInsets.only(bottom: 20),
            child: Image.network(widget.dataFood!.image!, fit: BoxFit.cover),
          ),
          Container(
              width: MediaQuery.of(context).size.width,
              constraints: const BoxConstraints(minHeight: 100),
              child: Text(widget.dataFood!.description!)),
        ],
      ),
    );
  }

  Widget addToCart(BuildContext context) {
    return InkWell(
      onTap: () {
        if (Global.isAvailableToClick()) {
          if (username.isNotEmpty && widget.dataFood!.id!.isNotEmpty) {
            PostOrderRequest postOrderRequest = PostOrderRequest(
                username, Global.orderId, widget.dataFood!.id!);
            addToCartApi(postOrderRequest);
          } else {
            Fluttertoast.showToast(
                msg: "Something wrong",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 3,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16);
          }
        }
      },
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 50,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: Colors.green, borderRadius: BorderRadius.circular(10)),
          child: const Text(
            "Add to cart",
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget addToFavourite(BuildContext context) {
    return InkWell(
      onTap: () {
        if (Global.isAvailableToClick()) {
          if (username.isNotEmpty && widget.dataFood!.id!.isNotEmpty) {
            AddFavoriteRequest addFavoriteRequest =
                AddFavoriteRequest(username, widget.dataFood!.id!);
            addToFavoriteApi(addFavoriteRequest);
          }
        }
      },
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 50,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: Colors.green, borderRadius: BorderRadius.circular(10)),
          child: Text(
            isFavorite == 0 ? "Add to favorites" : "Cancel favorites",
            style: const TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
