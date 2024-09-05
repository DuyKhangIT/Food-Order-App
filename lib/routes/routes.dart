import 'package:flutter/material.dart';

import '../screen/cart/cart_page.dart';
import '../screen/home/home_page.dart';
import '../screen/product/product_detail_page.dart';
import '../screen/sign_in/sign_in_page.dart';
import '../screen/sign_up/sign_up_page.dart';
import '../screen/splash_page.dart';

final Map<String, WidgetBuilder> routes = {
  SplashPage.routeName: (context) => const SplashPage(),
  SignInPage.routeName: (context) => const SignInPage(),
  SignUpPage.routeName: (context) => const SignUpPage(),
  HomePage.routeName: (context) => const HomePage(),
  ProductDetailPage.routeName: (context) => const ProductDetailPage(
        dataFood: null,
      ),
  CartPage.routeName: (context) => const CartPage(
        dataOrder: null,
      ),
};
