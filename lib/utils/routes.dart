

import 'package:calculator/pages/about_page.dart';
import 'package:flutter/material.dart';

import '../pages/compare_page.dart';
import '../pages/currency_page.dart';
import '../pages/home_page.dart';

class Routes {
  static const homePage = '/';
  static const comparePage = '/comparePage';
  static const currencyPage = '/currencyPage';
  static const aboutPage = '/aboutPage';

  static Route<dynamic> generateRoute(RouteSettings routeSettings) {
    try {
      Map<String, dynamic>? args = routeSettings.arguments as Map<String, dynamic>?;
      args ?? <String, dynamic>{};
      switch (routeSettings.name) {
        case homePage:
          return MaterialPageRoute(builder: (context) => const HomePage());
        case comparePage:
          return MaterialPageRoute(builder: (context) => const ComparePage());
        case aboutPage:
          return MaterialPageRoute(builder: (context) => const AboutPage());
        case currencyPage:
          return MaterialPageRoute(
              builder: (context) => CurrencyPage(args?['list_curreny'], args?['top_cur'], args?['bottom_cur']));
        default:
          return MaterialPageRoute(builder: (context) => const HomePage());
      }
    } catch (e) {
      return MaterialPageRoute(builder: (context) => const HomePage());
    }
  }
}