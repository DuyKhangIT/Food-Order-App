import 'package:flutter/material.dart';

import 'home_fragement_product.dart';
import 'home_fragment_categories.dart';

class HomeDetail extends StatelessWidget {
  const HomeDetail({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          CategoriesStore(),
          ProductPopular(),
        ],
      ),
    );
  }
}
