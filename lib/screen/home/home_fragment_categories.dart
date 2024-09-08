import 'package:flutter/material.dart';

import '../../handle_api/handle_api.dart';
import '../../model/get_categories/categories_response.dart';
import '../../model/get_categories/store_response.dart';
import '../categories/list_all_categories.dart';

class CategoriesStore extends StatefulWidget {
  const CategoriesStore({Key? key}) : super(key: key);

  @override
  State<CategoriesStore> createState() => _CategoriesStoreState();
}

class _CategoriesStoreState extends State<CategoriesStore> {
  List<CategoriesResponse>? dataCategories;
  StoreResponse? dataStore;
  @override
  void initState() {
    getStore();
    super.initState();
  }

  /// call api
  Future<StoreResponse> getStore() async {
    StoreResponse storeResponse;
    Map<String, dynamic>? body;
    try {
      body = await HttpHelper.invokeHttp(
        Uri.parse("http://10.0.2.2:5000/api/category/getCategories"),
        RequestType.get,
        headers: null,
        body: null,
      );
    } catch (error) {
      debugPrint("Fail to foods info $error");
      rethrow;
    }
    if (body == null) return StoreResponse.buildDefault();
    //get data from api here
    storeResponse = StoreResponse.fromJson(body);

    setState(() {
      dataCategories = storeResponse.listCategories;
      dataStore = storeResponse;
    });

    return storeResponse;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        children: [
          Row(
            children: [
              const Expanded(
                  child: Text(
                "Categories",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.green),
              )),
              GestureDetector(
                onTap: () {
                  if (dataCategories != null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ListAllCategories(storeInfo: dataStore!),
                      ),
                    );
                  }
                },
                child: const Text(
                  "See more",
                  style: TextStyle(fontSize: 16, color: Colors.lightGreen),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          dataCategories != null
              ? SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 190,
                  child: ListView.builder(
                    shrinkWrap: true,
                    primary: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: dataCategories!.length,

                    /// data.length
                    itemBuilder: (context, index) {
                      return dataCategories![index].image!.isNotEmpty
                          ? Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Image.network(
                                    dataCategories![index].image!,
                                    fit: BoxFit.cover,
                                    width: 150,
                                    height: 150,
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    dataCategories![index].title!,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  )
                                ],
                              ),
                            )
                          : const SizedBox();
                    },
                  ),
                )
              : Container(
                  width: MediaQuery.of(context).size.width,
                  height: 120,
                  alignment: Alignment.center,
                  child: const CircularProgressIndicator(
                    color: Colors.green,
                  )),
        ],
      ),
    );
  }
}
