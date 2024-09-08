import 'package:flutter/material.dart';
import '../../model/get_categories/categories_response.dart';
import '../../model/get_categories/store_response.dart';
import '../../util/global.dart';

class ListAllCategories extends StatefulWidget {
  final StoreResponse storeInfo;
  const ListAllCategories({Key? key, required this.storeInfo})
      : super(key: key);

  @override
  State<ListAllCategories> createState() => _ListAllCategoriesState();
}

class _ListAllCategoriesState extends State<ListAllCategories> {
  List<CategoriesResponse> dataCategories = [];
  TextEditingController inputSearchController = TextEditingController();
  String inputSearch = "";
  bool isSearching = false;

  /// new list for searching
  List<CategoriesResponse> resultCategory = [];
  @override
  void initState() {
    dataCategories = widget.storeInfo.listCategories!;
    resultCategory = dataCategories;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    /// searching
    void updateSearchCategories(String value) {
      setState(() {
        resultCategory = dataCategories
            .where((element) => Global()
                .accentParser(element.title!)
                .toLowerCase()
                .contains(Global().accentParser(value).toLowerCase()))
            .toList();
        isSearching = value.isNotEmpty;
      });
    }

    return Scaffold(
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
                updateSearchCategories(value);
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
                hintText: "Search Category...",
                hintStyle: TextStyle(
                    color: Colors.black.withOpacity(0.2),
                    fontFamily: 'NunitoSans',
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w400,
                    fontSize: (14)),
                border: InputBorder.none),
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        margin: const EdgeInsets.fromLTRB(25, 20, 0, 20),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: (resultCategory.isEmpty && isSearching)
            ? const Center(child: Text("The category does not exist"))
            : GridView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                primary: false,
                itemCount: resultCategory.length, //data.length
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    childAspectRatio: 0.85),
                itemBuilder: (context, index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // image from api
                      Image.network(
                        resultCategory[index].image!,
                        fit: BoxFit.cover,
                        width: 150,
                        height: 150,
                      ),

                      /// title from api
                      Container(
                          width: 150,
                          constraints: const BoxConstraints(maxHeight: 35),
                          alignment: Alignment.center,
                          child: Text(
                            resultCategory[index].title!,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          )),
                    ],
                  );
                }),
      ),
    );
  }
}
