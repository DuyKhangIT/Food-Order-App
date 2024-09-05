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
          Uri.parse("http://14.225.204.248:7070/api/category"), RequestType.get,
          headers: null, body: null);
    } catch (error) {
      debugPrint("Fail to foods info $error");
      rethrow;
    }
    if (body == null) return StoreResponse.buildDefault();
    //get data from api here
    storeResponse = StoreResponse.fromJson(body);

    setState(() {
      dataCategories = storeResponse.dataCategoriesResponse!.listCategories;
      dataStore = storeResponse;
    });

    return storeResponse;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 4.3,
      margin: const EdgeInsets.all(8),
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
                                ListAllCategories(storeInfo: dataStore!)));
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
                  height: 150,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: dataCategories!.length,

                      /// data.length
                      itemBuilder: (context, index) {
                        return Container(
                          width: 150, height: 150,
                          padding: const EdgeInsets.all(5),

                          /// call api img
                          child: dataCategories![index].image!.isNotEmpty
                              ? Image.network(dataCategories![index].image!,
                                  fit: BoxFit.cover)
                              : const SizedBox(),
                        );
                      }),
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
