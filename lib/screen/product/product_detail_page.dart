import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:food_app_project/model/add_or_remove_favorite/add_or_remove_favorite_request.dart';
import 'package:food_app_project/model/add_or_remove_favorite/add_or_remove_favorite_response.dart';

import '../../handle_api/handle_api.dart';
import '../../model/check_is_fav/check_is_fav_requuest.dart';
import '../../model/check_is_fav/check_is_favorite_response.dart';
import '../../model/error_response.dart';
import '../../model/get_products/foods_response.dart';
import '../../util/global.dart';
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
  bool isFav = false;

  @override
  void initState() {
    checkFav();
    super.initState();
  }

  Future<void> checkFav() async {
    if (widget.dataFood != null && widget.dataFood!.id!.isNotEmpty) {
      CheckIsFavoriteRequest checkIsFavoriteRequest =
          CheckIsFavoriteRequest(widget.dataFood!.id!);
      checkIsFavoriteApi(checkIsFavoriteRequest);
    }
  }

  /// call api add to favorite
  Future<void> addOrRemoveFavoriteApi(
    AddOrRemoveFavoriteRequest addOrRemoveFavoriteRequest,
  ) async {
    setState(() {
      IsShowDialog().showLoadingDialog(context);
    });
    AddOrRemoveFavoriteResponse addOrRemoveFavoriteResponse;
    Map<String, dynamic>? body;
    try {
      body = await HttpHelper.invokeHttp(
        Uri.parse("${Global.apiAddress}/api/favorite/toggleFavorite"),
        RequestType.post,
        headers: null,
        body: const JsonEncoder().convert(
          addOrRemoveFavoriteRequest.toBodyRequest(),
        ),
      );
    } catch (error) {
      debugPrint("Fail to add to fav $error");
      setState(
        () {
          Navigator.of(context).pop();
          Fluttertoast.showToast(
            msg: "Error from server",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16,
          );
        },
      );
      rethrow;
    }
    if (body == null) return;
    addOrRemoveFavoriteResponse = AddOrRemoveFavoriteResponse.fromJson(body);
    if (addOrRemoveFavoriteResponse.status == false) {
      setState(() {
        Navigator.of(context).pop();
      });
      Fluttertoast.showToast(
        msg: "Add to favorite fail",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 3,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16,
      );
    } else {
      if (addOrRemoveFavoriteResponse.message == "Favorited") {
        setState(
          () {
            Navigator.of(context).pop();
            Fluttertoast.showToast(
              msg: "Add to favorite Successfully",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16,
            );
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const HomePage()),
            );
          },
        );
      } else {
        setState(
          () {
            Navigator.of(context).pop();
            Fluttertoast.showToast(
                msg: "Cancel to favorite Successfully",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.green,
                textColor: Colors.white,
                fontSize: 16);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const HomePage()),
            );
          },
        );
      }
    }

    return;
  }

  /// call api check is favorite
  Future<void> checkIsFavoriteApi(
    CheckIsFavoriteRequest checkIsFavoriteRequest,
  ) async {
    CheckIsFavoriteResponse checkIsFavoriteResponse;
    ErrorResponse? errorResponse;
    Map<String, dynamic>? body;
    try {
      body = await HttpHelper.invokeHttp(
        Uri.parse("${Global.apiAddress}/api/favorite/checkFavorite"),
        RequestType.post,
        headers: null,
        body:
            const JsonEncoder().convert(checkIsFavoriteRequest.toBodyRequest()),
      );
      if (body == null) return;
      checkIsFavoriteResponse = CheckIsFavoriteResponse.fromJson(body);
      if (body.containsKey('statusCode')) {
        errorResponse = ErrorResponse.fromJson(body);
        Fluttertoast.showToast(
          msg: errorResponse.errorMessage,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16,
        );
      } else {
        setState(() {
          isFav = checkIsFavoriteResponse.isFavorite;
        });
      }
    } catch (error) {
      debugPrint("Fail to check fav $error");
      Fluttertoast.showToast(
        msg: "Error from server",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16,
      );
      rethrow;
    }
    return;
  }

  void addToBasketList(FoodsResponse food) {
    setState(() {
      Global.basketList.add(food);
    });
    Navigator.pushNamedAndRemoveUntil(
      context,
      HomePage.routeName,
      (Route<dynamic> route) => false,
    ).then((value) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text(
          "Details",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: bodyProduct(),
      bottomNavigationBar: Container(
        width: MediaQuery.of(context).size.width,
        height: 130,
        margin: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// quantity
            addToFavourite(),
            addToCart(),
          ],
        ),
      ),
    );
  }

  Widget bodyProduct() {
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

  Widget addToCart() {
    return InkWell(
      onTap: () {
        if (Global.isAvailableToClick()) {
          if (widget.dataFood != null) {
            addToBasketList(widget.dataFood!);
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
            color: Colors.green,
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Text(
            "Add to cart",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget addToFavourite() {
    return InkWell(
      onTap: () {
        if (Global.isAvailableToClick()) {
          if (widget.dataFood != null && widget.dataFood!.id!.isNotEmpty) {
            AddOrRemoveFavoriteRequest addOrRemoveFavoriteRequest =
                AddOrRemoveFavoriteRequest(widget.dataFood!.id!);
            addOrRemoveFavoriteApi(addOrRemoveFavoriteRequest);
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
            color: isFav ? Colors.red : Colors.green,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            isFav ? "Cancel favorites" : "Add to favorites",
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
