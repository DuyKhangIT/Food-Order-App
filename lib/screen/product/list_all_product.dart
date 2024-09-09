import 'package:flutter/material.dart';
import 'package:food_app_project/screen/product/product_detail_page.dart';

import '../../model/get_products/foods_response.dart';
import '../../model/get_products/product_response.dart';
import '../../util/global.dart';

class ListAllProduct extends StatefulWidget {
  final ProductResponse productInfo;
  const ListAllProduct({Key? key, required this.productInfo}) : super(key: key);

  @override
  State<ListAllProduct> createState() => _ListAllProductState();
}

class _ListAllProductState extends State<ListAllProduct> {
  TextEditingController inputSearchController = TextEditingController();
  String inputSearch = "";
  bool isSearching = false;
  List<FoodsResponse> dataFoods = [];

  /// new list for searching
  List<FoodsResponse> result = [];
  @override
  void initState() {
    dataFoods = widget.productInfo.listFoods!;
    result = dataFoods;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    /// searching
    void updateSearchProduct(String value) {
      setState(() {
        result = dataFoods
            .where((element) => Global()
                .accentParser(element.title!)
                .toLowerCase()
                .contains(Global().accentParser(value).toLowerCase()))
            .toList();
        isSearching = value.isNotEmpty;
      });
    }

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          leading: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(Icons.arrow_back)),
          title: Container(
            margin: const EdgeInsets.symmetric(vertical: 20),
            padding: const EdgeInsets.symmetric(horizontal: (5)),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular((20)),
              color: Colors.white,
            ),
            child: TextField(
              controller: inputSearchController,
              cursorColor: Colors.black,
              style: const TextStyle(
                  color: Colors.black,
                  fontFamily: 'NunitoSans',
                  fontWeight: FontWeight.w400,
                  fontSize: (14)),
              onChanged: (value) {
                setState(() {
                  updateSearchProduct(value);
                });
              },
              decoration: InputDecoration(
                isDense: true,
                contentPadding: const EdgeInsets.only(top: (11), bottom: (10)),
                prefixIcon: const Icon(Icons.search),
                prefixIconConstraints: const BoxConstraints(
                  minHeight: (24),
                  minWidth: (40),
                ),
                hintText: "Search Product...",
                hintStyle: TextStyle(
                    color: Colors.black.withOpacity(0.2),
                    fontFamily: 'NunitoSans',
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w400,
                    fontSize: (14)),
                border: InputBorder.none,
              ),
            ),
          ),
          elevation: 0,
        ),
        body: Container(
          margin: const EdgeInsets.fromLTRB(25, 20, 0, 20),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: (result.isEmpty && isSearching)
              ? const Center(child: Text("The product does not exist"))
              : GridView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  primary: false,
                  itemCount: result.length, //data.length
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    childAspectRatio: 0.8,
                  ),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProductDetailPage(
                              dataFood: result[index],
                            ),
                          ),
                        );
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // image from api
                          Image.network(
                            result[index].image!,
                            fit: BoxFit.cover,
                            width: 150,
                            height: 150,
                          ),

                          /// title from api
                          Container(
                            margin: const EdgeInsets.only(top: 10),
                            constraints: const BoxConstraints(maxHeight: 32),
                            child: Text(
                              result[index].title!,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),

                          /// price from api
                          Container(
                            margin: const EdgeInsets.only(top: 5),
                            padding: const EdgeInsets.all(2),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.white),
                                borderRadius: BorderRadius.circular(2),
                                color: Colors.green),
                            child: Text(
                              "${result[index].price!}.000 VNĐ",

                              /// api
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      ),
                    );
                  },
                ),
        ),
      ),
    );
  }
}
