import 'package:flutter/material.dart';

import 'home_fragement_product.dart';
import 'home_fragment_categories.dart';

class HomeDetail extends StatelessWidget {
  const HomeDetail({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CategoriesStore(),
          ProductPopular(),
        ],
      ),
    );
  }
}
