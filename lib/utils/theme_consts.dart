import 'package:flutter/material.dart';

mixin ThemeContants {
  ///////////////   1 - theme   ////////////////
  Map<String, dynamic> firstTheme = {
    'appBarBgColor': const Color(0xff262626),
    'appBarShape': null,
    'fullBgColor': const Color(0xff454545),
    'swipeColor': Colors.blue,
    'animationTextColors': Colors.grey[300],
    'fullBgDecoration': const BoxDecoration(
      color: Color(0xff454545),
    ),
    'historyDecoration': BoxDecoration(
      border: Border.all(
        color: Colors.white,
        width: 1,
      ),
      borderRadius: BorderRadius.circular(10),
    ),
    'historyIconColor': Colors.white,
    'calKeyboardContainerDec': const BoxDecoration(
      color: Colors.black,
    ),
    'menuBtColor': const Color(0xff00E0FF),
    'settingBtColor': const Color(0xff00E0FF),
    'firstTextFieldColor': Colors.white,
    'secondTextFieldColor': Colors.white,
    'calculatorBtchildAspectRatio': (.6 / .44),
    'measureBtchildAspectRatio': (.6 / .6),
    'calculatorMainAxisSpacing': 3.0,
    'calculatorCrossAxisSpacing': 3.0,
    'bottomSheetDecoration': const BoxDecoration(
      color: Color(0xff00E0FF),
    ),
    'bottomSheetIconColor': Colors.black,
    'operatorBtDecoration': const BoxDecoration(
      color: Color(0xff262626),
    ),
    'simpleBtDecoration': const BoxDecoration(
      color: Color(0xff454545),
    ),
    'outlineBorder': null,
    'simpleButtonColor': Colors.white,
    'operatorButtonColor': const Color(0xff00E0FF),
    'scientificButtonColor': Colors.white,
    'currencyTabDecoration': const BoxDecoration(
      image: DecorationImage(
          image:
              AssetImage('assets/images/theme_images/theme_ten/cur_tab_bg.png'),
          fit: BoxFit.cover),
    ),
    'measureTabItemColor': const Color(0xff00E0FF),
    'IsEvenColor': const Color.fromARGB(255, 15, 14, 14).withOpacity(.15),
    'IsOddColor': const Color(0xff555454).withOpacity(.15),
  };

  ///////////////   2 - theme   ////////////////
  Map<String, dynamic> secondTheme = {
    'appBarBgColor': const Color(0xff1F2229),
    'appBarShape': null,
    'fullBgColor': const Color(0xff22262F),
    'swipeColor': const Color(0xffFCA300),
    'animationTextColors': Colors.grey[300],
    'fullBgDecoration': const BoxDecoration(
      color: Color(0xff22262F),
    ),
    'historyDecoration': BoxDecoration(
      border: Border.all(
        color: Colors.white,
        width: 1,
      ),
      borderRadius: BorderRadius.circular(10),
    ),
    'historyIconColor': Colors.white,
    'calKeyboardContainerDec': const BoxDecoration(
      color: Color(0xff1F2229),
    ),
    'menuBtColor': const Color(0xffFCA300),
    'settingBtColor': const Color(0xffFCA300),
    'firstTextFieldColor': Colors.white,
    'secondTextFieldColor': Colors.white,
    'calculatorBtchildAspectRatio': (.47 / .44),
    'measureBtchildAspectRatio': (.6 / .6),
    'calculatorMainAxisSpacing': 0.0,
    'calculatorCrossAxisSpacing': 0.0,
    'bottomSheetDecoration': const BoxDecoration(
      color: Color(0xffFCA300),
    ),
    'bottomSheetIconColor': Colors.black,
    'operatorBtDecoration': const BoxDecoration(
      color: Color(0xff1F2229),
      border: Border(
        top: BorderSide(width: 2, color: Color(0xff5A5A5A)),
        right: BorderSide(width: 1, color: Colors.black),
        left: BorderSide(width: 1, color: Colors.black),
       ),
    ),
    'simpleBtDecoration': const BoxDecoration(
      color: Color(0xff32363F),
      border: Border(
        top: BorderSide(width: 2, color: Color(0xff5A5A5A)),
        right: BorderSide(width: 1, color: Colors.black),
        left: BorderSide(width: 1, color: Colors.black),
      ),
    ),
    'outlineBorder': null,
    'simpleButtonColor': Colors.white,
    'operatorButtonColor': const Color(0xffFCA300),
    'scientificButtonColor': Colors.white,
    'currencyTabDecoration': const BoxDecoration(
      image: DecorationImage(
          image:
              AssetImage('assets/images/theme_images/theme_ten/cur_tab_bg.png'),
          fit: BoxFit.cover),
    ),
    'measureTabItemColor': const Color(0xffFCA300),
    'IsEvenColor': const Color(0xff32363F).withOpacity(.15),
    'IsOddColor': const Color(0xff494F5C).withOpacity(.15),
  };

  ///////////////   3 - theme   ////////////////
  Map<String, dynamic> thirdTheme = {
    'appBarBgColor': const Color(0xffCDCDCD),
    'appBarShape': null,
    'fullBgColor': const Color(0xffCDCDCD),
    'swipeColor': Colors.grey[900],
    'animationTextColors': const Color(0xff333333),
    'fullBgDecoration': const BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        colors: [
          Color(0xffCCCCCC),
          Color(0xffF3F3F3),
        ],
      ),
    ),
    'historyDecoration': BoxDecoration(
      border: Border.all(
        color: const Color(0xff656565),
        width: 1,
      ),
      borderRadius: BorderRadius.circular(10),
    ),
    'historyIconColor': const Color(0xff656565),
    'calKeyboardContainerDec': const BoxDecoration(
      color: Color(0xff656565),
    ),
    'menuBtColor': const Color(0xff333333),
    'settingBtColor': const Color(0xff333333),
    'firstTextFieldColor': const Color(0xff333333),
    'secondTextFieldColor': const Color(0xff333333),
    'calculatorBtchildAspectRatio': (.47 / .44),
    'measureBtchildAspectRatio': (.6 / .6),
    'calculatorMainAxisSpacing': 0.0,
    'calculatorCrossAxisSpacing': 0.0,
    'bottomSheetDecoration': const BoxDecoration(
      color: Color(0xff777777),
    ),
    'bottomSheetIconColor': Colors.black,
    'operatorBtDecoration': const BoxDecoration(
      color: Color(0xffDCDCDC),
      border: Border(
        top: BorderSide(width: 2, color: Color(0xff5A5A5A)),
        right: BorderSide(width: 1, color: Colors.black),
        left: BorderSide(width: 1, color: Colors.black),
      ),
    ),
    'simpleBtDecoration': const BoxDecoration(
      color: Color(0xffF1EFED),
      border: Border(
        top: BorderSide(width: 2, color: Color(0xff5A5A5A)),
        right: BorderSide(width: 1, color: Colors.black),
        left: BorderSide(width: 1, color: Colors.black),
      ),
    ),
    'outlineBorder': null,
    'simpleButtonColor': const Color(0xff656565),
    'operatorButtonColor': const Color(0xff333333),
    'scientificButtonColor': Colors.white,
    'currencyTabDecoration': const BoxDecoration(
      image: DecorationImage(
          image:
              AssetImage('assets/images/theme_images/theme_ten/cur_tab_bg.png'),
          fit: BoxFit.cover),
    ),
    'measureTabItemColor': const Color(0xff333333),
    'IsEvenColor': const Color(0xffDCDCDC).withOpacity(.15),
    'IsOddColor': Color.fromARGB(255, 93, 92, 92).withOpacity(.15),
  };

  ///////////////   4 - theme   ////////////////
  Map<String, dynamic> fourTheme = {
    'appBarBgColor': const Color(0xffAAAAAA),
    'appBarShape': null,
    'fullBgColor': const Color(0xff454545),
    'swipeColor': const Color(0xff333333),
    'animationTextColors': Colors.grey[300],
    'fullBgDecoration': const BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        colors: [
          Color(0xffAAAAAA),
          Color(0xffD0D0D0),
          Color(0xffF4F4F4),
        ],
      ),
    ),
    'historyDecoration': BoxDecoration(
      border: Border.all(
        color: const Color(0xff333333),
        width: 1,
      ),
      borderRadius: BorderRadius.circular(10),
    ),
    'historyIconColor': const Color(0xff333333),
    'calKeyboardContainerDec': const BoxDecoration(
      color: Colors.black,
    ),
    'menuBtColor': const Color(0xff333333),
    'settingBtColor': const Color(0xff333333),
    'firstTextFieldColor': const Color(0xff333333),
    'secondTextFieldColor': const Color(0xff333333),
    'calculatorBtchildAspectRatio': (.47 / .425),
    'measureBtchildAspectRatio': (.6 / .6),
    'calculatorMainAxisSpacing': 8.0,
    'calculatorCrossAxisSpacing': 8.0,
    'bottomSheetDecoration': const BoxDecoration(
      color: Color(0xffDCDCDC),
    ),
    'bottomSheetIconColor': Colors.black,
    'operatorBtDecoration': BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        colors: [
          Color(0xffEC5C22),
          Color(0xffF0781A),
        ],
      ),
      borderRadius: BorderRadius.circular(5),
    ),
    'simpleBtDecoration': BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        colors: [
          Color(0xffCDCDCD),
          Color(0xffDADADA),
        ],
      ),
      borderRadius: BorderRadius.circular(5),
    ),
    'outlineBorder': const BoxDecoration(
      border: Border(
        top: BorderSide(width: 2, color: Colors.white),
      ),
    ),
    'simpleButtonColor': const Color(0xff333333),
    'operatorButtonColor': Colors.grey[50],
    'scientificButtonColor': Colors.white,
    'currencyTabDecoration': const BoxDecoration(
      image: DecorationImage(
          image:
              AssetImage('assets/images/theme_images/theme_ten/cur_tab_bg.png'),
          fit: BoxFit.cover),
    ),
    'measureTabItemColor': const Color(0xff333333),
    'IsEvenColor': const Color.fromARGB(255, 15, 14, 14).withOpacity(.15),
    'IsOddColor': const Color(0xff555454).withOpacity(.15),
  };

  ///////////////   5 - theme   ////////////////
  Map<String, dynamic> fiveTheme = {
    'appBarBgColor': const Color(0xff161616),
    'appBarShape': null,
    'fullBgColor': const Color(0xff262626),
    'swipeColor': Colors.red,
    'animationTextColors': Colors.grey[300],
    'fullBgDecoration': const BoxDecoration(
      color: Color(0xff262626),
    ),
    'historyDecoration': BoxDecoration(
      border: Border.all(
        color: Colors.white,
        width: 1,
      ),
      borderRadius: BorderRadius.circular(10),
    ),
    'historyIconColor': Colors.white,
    'calKeyboardContainerDec': const BoxDecoration(
      color: Color(0xff262626),
    ),
    'menuBtColor': Colors.red,
    'settingBtColor': Colors.red,
    'firstTextFieldColor': Colors.white,
    'secondTextFieldColor': Colors.white,
    'calculatorBtchildAspectRatio': (.47 / .44),
    'measureBtchildAspectRatio': (.6 / .6),
    'calculatorMainAxisSpacing': 0.0,
    'calculatorCrossAxisSpacing': 0.0,
    'bottomSheetDecoration': const BoxDecoration(
      color: Colors.red,
    ),
    'bottomSheetIconColor': Colors.black,
    'operatorBtDecoration': const BoxDecoration(
      color: Color(0xff161616),
      border: Border(
        top: BorderSide(width: 2, color: Color(0xff5A5A5A)),
        right: BorderSide(width: 1, color: Colors.black),
        left: BorderSide(width: 1, color: Colors.black),
      ),
    ),
    'simpleBtDecoration': const BoxDecoration(
      color: Color(0xff262626),
      border: Border(
        top: BorderSide(width: 2, color: Color(0xff5A5A5A)),
        right: BorderSide(width: 1, color: Colors.black),
        left: BorderSide(width: 1, color: Colors.black),
      ),
    ),
    'outlineBorder': null,
    'simpleButtonColor': Colors.white,
    'operatorButtonColor': Colors.red,
    'scientificButtonColor': Colors.white,
    'currencyTabDecoration': const BoxDecoration(
      image: DecorationImage(
          image:
              AssetImage('assets/images/theme_images/theme_ten/cur_tab_bg.png'),
          fit: BoxFit.cover),
    ),
    'measureTabItemColor': Colors.red,
    'IsEvenColor': const Color.fromARGB(255, 15, 14, 14).withOpacity(.15),
    'IsOddColor': const Color(0xff555454).withOpacity(.15),
  };

  ///////////////   6 - theme   ////////////////
  Map<String, dynamic> sixTheme = {
    'appBarBgColor': const Color.fromARGB(255, 36, 36, 36),
    'appBarShape': null,
    'fullBgColor': const Color(0xff111111),
    'swipeColor': const Color(0xff02C4F4),
    'animationTextColors': Colors.grey[300],
    'fullBgDecoration': const BoxDecoration(
      color: Color(0xff111111),
    ),
    'historyDecoration': BoxDecoration(
      border: Border.all(
        color: const Color(0xff02C4F4),
        width: 2,
      ),
      borderRadius: BorderRadius.circular(10),
    ),
    'historyIconColor': const Color(0xff02C4F4),
    'calKeyboardContainerDec': const BoxDecoration(
      color: Color(0xff111111),
    ),
    'menuBtColor': const Color(0xff02C4F4),
    'settingBtColor': const Color(0xff02C4F4),
    'firstTextFieldColor': const Color(0xff02C4F4),
    'secondTextFieldColor': const Color(0xff02C4F4),
    'calculatorBtchildAspectRatio': (.47 / .43),
    'measureBtchildAspectRatio': (.6 / .6),
    'calculatorMainAxisSpacing': 5.0,
    'calculatorCrossAxisSpacing': 5.0,
    'bottomSheetDecoration': BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topRight,
        stops: [
          0.1,
          1.5,
        ],
        colors: [
          Color(0xff01232F),
          Color(0xff111111),
        ],
      ),
      borderRadius: BorderRadius.circular(5),
    ),
    'bottomSheetIconColor': const Color(0xff02C4F4),
    'operatorBtDecoration': BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topRight,
        stops: [
          0.1,
          1.5,
        ],
        colors: [
          Color.fromARGB(255, 1, 44, 59),
          Color(0xff111111),
        ],
      ),
      borderRadius: BorderRadius.circular(5),
    ),
    'simpleBtDecoration': BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topRight,
        stops: [
          0.1,
          1.5,
        ],
        colors: [
          Color.fromARGB(255, 1, 44, 59),
          Color(0xff111111),
        ],
      ),
      borderRadius: BorderRadius.circular(5),
    ),
    'outlineBorder': null,
    'simpleButtonColor': const Color(0xff02C4F4),
    'operatorButtonColor': const Color(0xff02C4F4),
    'scientificButtonColor': const Color(0xff02C4F4),
    'currencyTabDecoration': const BoxDecoration(
      image: DecorationImage(
          image:
              AssetImage('assets/images/theme_images/theme_ten/cur_tab_bg.png'),
          fit: BoxFit.cover),
    ),
    'measureTabItemColor': const Color(0xff02C4F4),
    'IsEvenColor': const Color.fromARGB(255, 15, 14, 14).withOpacity(.15),
    'IsOddColor': const Color(0xff555454).withOpacity(.15),
  };

  ///////////////   7 - theme   ////////////////
  Map<String, dynamic> sevenTheme = {
    'appBarBgColor': const Color(0xff023844),
    'appBarShape': null,
    'fullBgColor': const Color(0xff05525C),
    'swipeColor': const Color(0xffC6FDFF),
    'animationTextColors': Colors.grey[300],
    'fullBgDecoration': const BoxDecoration(
      color: Color(0xff05525C),
    ),
    'historyDecoration': BoxDecoration(
      border: Border.all(
        color: const Color(0xff9EFEFF),
        width: 1,
      ),
      borderRadius: BorderRadius.circular(10),
    ),
    'historyIconColor': const Color(0xffC6FDFF),
    'calKeyboardContainerDec': const BoxDecoration(
      color: Color(0xff111111),
    ),
    'menuBtColor': const Color(0xffC6FDFF),
    'settingBtColor': const Color(0xffC6FDFF),
    'firstTextFieldColor': const Color(0xff9EFEFF),
    'secondTextFieldColor': const Color(0xff9EFEFF),
    'calculatorBtchildAspectRatio': (.47 / .44),
    'measureBtchildAspectRatio': (.6 / .6),
    'calculatorMainAxisSpacing': 0.0,
    'calculatorCrossAxisSpacing': 0.0,
    'bottomSheetDecoration': const BoxDecoration(
      color: Color(0xff023844),
      image: DecorationImage(
          image:
              AssetImage('assets/images/theme_images/theme_eight/down_bg.png'),
          fit: BoxFit.cover),
    ),
    'bottomSheetIconColor': Colors.white,
    'operatorBtDecoration': BoxDecoration(
      color: const Color(0xff023844),
      image: const DecorationImage(
          image:
              AssetImage('assets/images/theme_images/theme_eight/btn_bg.png'),
          fit: BoxFit.cover),
      border: Border.all(color: Colors.white, width: 0),
    ),
    'simpleBtDecoration': BoxDecoration(
      color: const Color(0xff0A7988),
      image: const DecorationImage(
          image:
              AssetImage('assets/images/theme_images/theme_eight/btn_bg.png'),
          fit: BoxFit.cover),
      border: Border.all(color: Colors.white, width: 0),
    ),
    'outlineBorder': null,
    'simpleButtonColor': const Color(0xff9EFEFF),
    'operatorButtonColor': const Color(0xff9EFEFF),
    'scientificButtonColor': Colors.white,
    'currencyTabDecoration': const BoxDecoration(
      boxShadow: [
        BoxShadow(
          color: Colors.white,
          spreadRadius: 7,
          blurRadius: 7,
        )
      ],
      image: DecorationImage(
          image:
              AssetImage('assets/images/theme_images/theme_ten/cur_tab_bg.png'),
          fit: BoxFit.cover),
    ),
    'measureTabItemColor': const Color(0xffC6FDFF),
    'IsEvenColor': const Color(0xff282828).withOpacity(.15),
    'IsOddColor': Colors.black.withOpacity(.15),
  };

  ///////////////   9 - theme   ////////////////
  Map<String, dynamic> nineTheme = {
    'appBarBgColor': Colors.black,
    'appBarShape': null,
    'fullBgColor': Colors.black,
    'swipeColor': Colors.white,
    'animationTextColors': Colors.grey[300],
    'fullBgDecoration': const BoxDecoration(
      color: Color(0xff111111),
    ),
    'historyDecoration': BoxDecoration(
      border: Border.all(
        color: const Color(0xffBBBBBB),
        width: 1,
      ),
      borderRadius: BorderRadius.circular(10),
    ),
    'historyIconColor': const Color(0xffBBBBBB),
    'calKeyboardContainerDec': const BoxDecoration(
      color: Color(0xff111111),
    ),
    'menuBtColor': Colors.white,
    'settingBtColor': Colors.white,
    'firstTextFieldColor': Colors.white,
    'secondTextFieldColor': Colors.white,
    'calculatorBtchildAspectRatio': (.47 / .42),
    'measureBtchildAspectRatio': (.6 / .6),
    'calculatorMainAxisSpacing': 1.0,
    'calculatorCrossAxisSpacing': 1.0,
    'bottomSheetDecoration': const BoxDecoration(
      color: Colors.black,
    ),
    'bottomSheetIconColor': Colors.white,
    'operatorBtDecoration': BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topRight,
        stops: [
          0.1,
          1.5,
        ],
        colors: [
          Color(0xff01232F),
          Color(0xff111111),
        ],
      ),
      boxShadow: const [
        BoxShadow(
          color: Colors.white,
          spreadRadius: 7,
          blurRadius: 7,
        )
      ],
      borderRadius: BorderRadius.circular(5),
    ),
    'simpleBtDecoration': BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topRight,
        stops: [
          0.1,
          1.5,
        ],
        colors: [
          Color(0xff01232F),
          Color(0xff111111),
        ],
      ),
      boxShadow: const [
        BoxShadow(
          color: Colors.white,
          spreadRadius: 7,
          blurRadius: 7,
        )
      ],
      borderRadius: BorderRadius.circular(5),
      border: Border.all(color: Colors.white, width: 1),
    ),
    'outlineBorder': null,
    'simpleButtonColor': Colors.white,
    'operatorButtonColor': Colors.grey[50],
    'scientificButtonColor': Colors.white,
    'currencyTabDecoration': const BoxDecoration(
      boxShadow: [
        BoxShadow(
          color: Colors.white,
          // spreadRadius: 0,
          // blurRadius: 0,
        )
      ],
      image: DecorationImage(
          image:
              AssetImage('assets/images/theme_images/theme_ten/cur_tab_bg.png'),
          fit: BoxFit.cover),
    ),
    'measureTabItemColor': Colors.white,
    'IsEvenColor': const Color(0xff282828).withOpacity(.15),
    'IsOddColor': Colors.black.withOpacity(.15),
  };

  ///////////////   10 - theme   ////////////////
  Map<String, dynamic> tenTheme = {
    'appBarBgColor': const Color(0xff023844),
    'appBarShape': null,
    'fullBgColor': const Color(0xff05525C),
    'swipeColor': const Color(0xffC6FDFF),
    'animationTextColors': Colors.grey[300],
    'fullBgDecoration': const BoxDecoration(
      color: Color(0xff05525C),
    ),
    'historyDecoration': BoxDecoration(
      border: Border.all(
        color: const Color(0xff9EFEFF),
        width: 1,
      ),
      borderRadius: BorderRadius.circular(10),
    ),
    'historyIconColor': const Color(0xffC6FDFF),
    'calKeyboardContainerDec': const BoxDecoration(
      color: Color(0xff111111),
    ),
    'menuBtColor': const Color(0xffC6FDFF),
    'settingBtColor': const Color(0xffC6FDFF),
    'firstTextFieldColor': const Color(0xff9EFEFF),
    'secondTextFieldColor': const Color(0xff9EFEFF),
    'calculatorBtchildAspectRatio': (.47 / .44),
    'measureBtchildAspectRatio': (.6 / .6),
    'calculatorMainAxisSpacing': 0.0,
    'calculatorCrossAxisSpacing': 0.0,
    'bottomSheetDecoration': const BoxDecoration(
      color: Color(0xff023844),
      image: DecorationImage(
          image: AssetImage('assets/images/theme_images/theme_ten/down_bg.png'),
          fit: BoxFit.cover),
    ),
    'bottomSheetIconColor': Colors.white,
    'operatorBtDecoration': BoxDecoration(
      color: const Color(0xff023844),
      image: const DecorationImage(
          image: AssetImage('assets/images/theme_images/theme_ten/btn_bg.png'),
          fit: BoxFit.cover),
      border: Border.all(color: Colors.white, width: 0),
    ),
    'simpleBtDecoration': BoxDecoration(
      color: const Color(0xff0A7988),
      image: const DecorationImage(
          image: AssetImage('assets/images/theme_images/theme_ten/btn_bg.png'),
          fit: BoxFit.cover),
      border: Border.all(color: Colors.white, width: 0),
    ),
    'outlineBorder': null,
    'simpleButtonColor': const Color(0xff9EFEFF),
    'operatorButtonColor': const Color(0xff9EFEFF),
    'scientificButtonColor': Colors.white,
    'currencyTabDecoration': const BoxDecoration(
      boxShadow: [
        BoxShadow(
          color: Colors.white,
          spreadRadius: 7,
          blurRadius: 7,
        )
      ],
      image: DecorationImage(
          image:
              AssetImage('assets/images/theme_images/theme_ten/cur_tab_bg.png'),
          fit: BoxFit.cover),
    ),
    'measureTabItemColor': const Color(0xffC6FDFF),
    'IsEvenColor': const Color(0xff282828).withOpacity(.15),
    'IsOddColor': Colors.black.withOpacity(.15),
  };

///////////////   8 - theme   ////////////////

  Map<String, dynamic> eightTheme = {
    'appBarBgColor': const Color(0xff023844),
    'appBarShape': null,
    'fullBgColor': const Color(0xff05525C),
    'fullBgDecoration': const BoxDecoration(
      color: Color(0xff05525C),
    ),
    'calKeyboardContainerDec': null,
    'menuBtColor': const Color(0xffC6FDFF),
    'settingBtColor': const Color(0xffC6FDFF),
    'firstTextFieldColor': const Color(0xffC6FDFF),
    'secondTextFieldColor': const Color(0xffC6FDFF),
    'calculatorBtchildAspectRatio': (.47 / .44),
    'bottomSheetDecoration': const BoxDecoration(
      image: DecorationImage(
          image:
              AssetImage('assets/images/theme_images/theme_ten/up_down_bg.png'),
          fit: BoxFit.cover),
    ),
    'bottomSheetIconColor': Colors.blue,
    'operatorBtDecoration': BoxDecoration(
      image: const DecorationImage(
        image:
            AssetImage('assets/images/theme_images/theme_eight/button_bg.png'),
      ),
      color: const Color(0xff023844),
      border: Border.all(color: Colors.blueAccent),
    ),
    'simpleBtDecoration': BoxDecoration(
      image: const DecorationImage(
        image:
            AssetImage('assets/images/theme_images/theme_eight/button_bg.png'),
      ),
      border: Border.all(color: Colors.blueAccent),
    ),
    'outlineBorder': null,
    'calculatorBtDecoration': const BoxDecoration(
      image: DecorationImage(
          image:
              AssetImage('assets/images/theme_images/theme_ten/button_bg.png'),
          fit: BoxFit.cover),
    ),
    'buttonColor': Colors.blue[900],
    'currencyTabDecoration': const BoxDecoration(
      image: DecorationImage(
          image:
              AssetImage('assets/images/theme_images/theme_ten/cur_tab_bg.png'),
          fit: BoxFit.cover),
    ),
    'measureListViewItemBg': Colors.blue[900]!.withOpacity(.15),
  };

  Map<String, dynamic> themeSwitcher(int index) {
    switch (index) {
      case 1:
        return firstTheme;
      case 2:
        return secondTheme;
      case 3:
        return thirdTheme;
      case 4:
        return fourTheme;
      case 5:
        return fiveTheme;
      case 6:
        return sixTheme;
      case 7:
        return sevenTheme;
      case 8:
        return nineTheme;
      default:
        return firstTheme;
    }
  }
}
