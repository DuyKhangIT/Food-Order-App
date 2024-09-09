import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:food_app_project/model/error_response.dart';
import 'package:food_app_project/model/get_products/foods_response.dart';

import '../../handle_api/handle_api.dart';
import '../../model/get_list_favorite/get_list_favorite_response/get_list_favorite_response.dart';
import '../../util/show_loading_dialog.dart';

class FavoriteDetail extends StatefulWidget {
  const FavoriteDetail({Key? key}) : super(key: key);

  @override
  State<FavoriteDetail> createState() => _FavoriteDetailState();
}

class _FavoriteDetailState extends State<FavoriteDetail> {
  List<FoodsResponse>? listFav;

  @override
  void initState() {
    super.initState();
    getFavoriteList();
  }

  Future<void> getFavoriteList() async {
    await getListFavorites();
  }

  /// call api list favorite
  Future<void> getListFavorites() async {
    GetListFavoriteResponse getListFavoriteResponse;
    ErrorResponse errorResponse;
    Map<String, dynamic>? body;
    try {

      body = await HttpHelper.invokeHttp(
        Uri.parse("http://10.0.2.2:5000/api/favorite/getFavoriteFoods"),
        RequestType.get,
        headers: null,
        body: null,
      );

      if (body == null) return;

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
        //get data from api here
        getListFavoriteResponse = GetListFavoriteResponse.fromJson(body);

       setState(() {
         listFav = getListFavoriteResponse.favoriteFoods;
       });

        print('ListFV $listFav');
      }
    } catch (error) {
      debugPrint("Fail to list fav $error");
      Fluttertoast.showToast(
        msg: "get list favorite fail!",
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

  @override
  Widget build(BuildContext context) {
    return listFav != null && listFav!.isNotEmpty
        ? Expanded(
            child: ListView.builder(
              itemCount: listFav!.length,
              itemBuilder: (context, index) {
                return favoritesItemList(context, index);
              },
            ),
          )
        : const SizedBox();
  }

  Widget favoritesItemList(BuildContext context, index) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          SizedBox(
              width: 100,
              height: 100,
              child: Image.network(
                listFav![index].image!,
                fit: BoxFit.cover,
              )),
          const SizedBox(
            width: 10,
          ),
          Container(
            width: MediaQuery.of(context).size.width / 1.5,
            constraints: const BoxConstraints(maxHeight: 100),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                    width: MediaQuery.of(context).size.width / 1.5,
                    height: 20,
                    child: Text(
                      listFav![index].title!,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    )),

                ///api
                Container(
                    width: MediaQuery.of(context).size.width / 1.5,
                    constraints: const BoxConstraints(maxHeight: 80),
                    child: Text(
                      listFav![index].description!,

                      ///api
                      maxLines: 5,
                      overflow: TextOverflow.ellipsis,
                    ))
              ],
            ),
          )
        ],
      ),
    );
  }
}
