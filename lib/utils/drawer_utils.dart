import 'package:flutter/material.dart';

mixin DrawerUtils {
  bool switcher_one = false;
  bool switcher_two = false;
  bool switcher_three = false;
  bool switcher_four = false;
  bool switcher_five = false;
  bool switcher_six = false;

  List<Tab> endDrawerTabs = [
    const Tab(text: 'SETTINGS'),
    const Tab(text: 'THEMES'),
  ];

  List<String> themesList = [
    'assets/images/main_images/theme_one.png',
    'assets/images/main_images/theme_two.png',
    'assets/images/main_images/theme_three.png',
    'assets/images/main_images/theme_four.png',
    'assets/images/main_images/theme_five.png',
    'assets/images/main_images/theme_seven.png',
    'assets/images/main_images/theme_nine.png',
    'assets/images/main_images/theme_ten.png',

  ];
}
