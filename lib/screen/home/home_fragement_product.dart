import 'package:flutter/material.dart';

import '../../handle_api/handle_api.dart';
import '../../model/get_products/foods_response.dart';
import '../../model/get_products/product_response.dart';
import '../product/list_all_product.dart';
import '../product/product_detail_page.dart';

class ProductPopular extends StatefulWidget {
  const ProductPopular({Key? key}) : super(key: key);

  @override
  State<ProductPopular> createState() => _ProductPopularState();
}

class _ProductPopularState extends State<ProductPopular> {
  List<FoodsResponse>? data;
  ProductResponse? dataProduct;
  @override
  void initState() {
    getProduct();
    super.initState();
  }

  /// call api list foods
  Future<ProductResponse> getProduct() async {
    ProductResponse productResponse;
    Map<String, dynamic>? body;
    try {
      body = await HttpHelper.invokeHttp(
          Uri.parse("http://14.225.204.248:7070/api/food"),
          RequestType.get,
          headers: null,
          body: null);
    } catch (error) {
      debugPrint("Fail to foods info $error");
      rethrow;
    }
    if (body == null) return ProductResponse.buildDefault();
    //get data from api here
    productResponse = ProductResponse.fromJson(body);

    setState(() {
      data = productResponse.dataResponse!.listFoods;
      dataProduct = productResponse;
    });

    return productResponse;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.fromLTRB(10, 20, 10, 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            children: [
              const Expanded(
                  child: Text(
                "Popular Products",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.green),
              )),
              GestureDetector(
                onTap: () {
                  if (dataProduct != null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              ListAllProduct(productInfo: dataProduct!)),
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
          const SizedBox(height: 15),
          data != null
              ? GridView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  primary: false,
                  itemCount: 6, //data.length
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 10,
                      childAspectRatio: 0.65),
                  itemBuilder: (context, index) {
                    return data![index].title!.isNotEmpty &&
                            data![index].price!.toString().isNotEmpty &&
                            data![index].image!.isNotEmpty
                        ? GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ProductDetailPage(
                                          dataFood: data![index],
                                        )),
                              );
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // image from api
                                Image.network(
                                  data![index].image!,
                                  fit: BoxFit.cover,
                                  width: 115,
                                  height: 115,
                                ),

                                /// title from api
                                Container(
                                    margin: const EdgeInsets.only(top: 10),
                                    constraints:
                                        const BoxConstraints(maxHeight: 32),
                                    child: Text(
                                      data![index].title!,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    )),

                                /// price from api
                                Container(
                                  margin: const EdgeInsets.only(top: 5),
                                  padding: const EdgeInsets.all(2),
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.white),
                                      borderRadius: BorderRadius.circular(2),
                                      color: Colors.green),
                                  child: Text(
                                    "${data![index].price}.000 VNĐ",

                                    /// api
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                )
                              ],
                            ),
                          )
                        : const SizedBox();

                    /// api
                  })
              : Container(
                  width: MediaQuery.of(context).size.width,
                  constraints: const BoxConstraints(minHeight: 180),
                  alignment: Alignment.center,
                  child: const CircularProgressIndicator(
                    color: Colors.green,
                  ))
        ],
      ),
    );
  }
}
