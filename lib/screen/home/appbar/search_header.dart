import 'package:flutter/material.dart';

import '../../cart/cart_page.dart';

class SearchHeader extends StatefulWidget {
  const SearchHeader({Key? key}) : super(key: key);

  @override
  State<SearchHeader> createState() => _SearchHeaderState();
}

class _SearchHeaderState extends State<SearchHeader> {
  TextEditingController inputSearchController = TextEditingController();
  String inputSearch = "";
  bool isSearching = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: MediaQuery.of(context).size.width/1.3,
          height: 35,
          margin: const EdgeInsets.only(left: 10),
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
                //updateSearchFavorite(value);
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
                hintText: "Search...",
                hintStyle: TextStyle(
                    color: Colors.black.withOpacity(0.2),
                    fontFamily: 'NunitoSans',
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w400,
                    fontSize: (14)),
                border: InputBorder.none),
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) =>  const CartPage(dataOrder: null,)),
            );
          },
          child: Stack(
            children: [
              Container(
                height: 40,
                width: 40,
                padding: const EdgeInsets.all(10),
                child: const Icon(Icons.shopping_cart_outlined),
              ),
              Positioned(
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(1),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  constraints: const BoxConstraints(
                    minWidth: 16,
                    minHeight: 16,
                  ),
                  child: const Text(
                    "9",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}

