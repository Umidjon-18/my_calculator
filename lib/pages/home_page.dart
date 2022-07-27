import 'dart:async';
import 'dart:math' as math;
import 'package:calculator/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:calculator/utils/calculator_utils.dart';
import 'package:calculator/utils/hive_utils.dart';
import 'package:flutter_fast_forms/flutter_fast_forms.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:list_tile_switch/list_tile_switch.dart';
import 'package:status_bar_control/status_bar_control.dart';
import 'package:wakelock/wakelock.dart';

import '../utils/currency_utils.dart';
import '../utils/drawer_utils.dart';
import '../utils/measure_utils.dart';
import '../utils/routes.dart';
import '../utils/theme_consts.dart';
import 'compare_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with
        CalculatorUtils,
        ThemeContants,
        CurrencyUtils,
        MeasureUtils,
        DrawerUtils,
        HiveUtil,
        TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  final formKey = GlobalKey<FormState>();
  late TabController _endDrawerTabController;
  late AnimationController animationController;
  late TabController _measureTabController;
  late TabController _tabController;
  late TextEditingController distanceController;
  late ScrollController scrollController;
  late Animation animation;

  late Map<String, dynamic> currentTheme;
  double animCricleClear = 0;
  String animationText = 'What is your name?';
  String changedText = '';
  String distanceValue = 'millimeter';
  String areaValue = 'square meter';
  String massValue = 'kilogram';
  String volumeValue = 'cubic meter';
  String temperatureValue = 'kelvin';
  String fuelValue = 'liters/100 kilometer';
  String cookingValue = 'milliliter';
  String historyBoxName = 'history_box';
  String settingsBoxName = 'settings_box';
  late Box historyBox;
  late Box settingsBox;
  final ValueNotifier<Map<String, List<String>>> historyResult =
      ValueNotifier<Map<String, List<String>>>({});
  var historyLength = 0;
  late Size screenSize;

  @override
  void initState() {
    super.initState();
    screenSize = const Size(0, 0);
    currentTheme = themeSwitcher(theme.value);
    _tabController = TabController(vsync: this, length: myTabs.length);
    _measureTabController =
        TabController(vsync: this, length: measureTabs.length);
    _endDrawerTabController =
        TabController(vsync: this, length: endDrawerTabs.length);
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1500));
    animationController.repeat(reverse: false);
    animation = Tween(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: animationController, curve: Curves.easeIn))
      ..addListener(() {
        setState(() {});
      });
    distanceController = TextEditingController();
    scrollController = ScrollController();
    scrollController.addListener(() {
      if (scrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        if (switcher_two) {
          writer('=');
          setState(() {});
        }
        writer('C');
        animCricleClear = 20;
        setState(() {});
        Timer(const Duration(milliseconds: 1), () async {
          animCricleClear = 0;
          setState(() {});
        });
      }
    });
    setDatabase();
    initPlatformState();
  }

  /// status bar switcher
  Future<void> initPlatformState() async {
    try {
      await StatusBarControl.setHidden(switcher_six);
    } on PlatformException {}
    setState(() {});
  }

  /// #database connection
  setDatabase() async {
    historyBox = await Hive.openBox(historyBoxName);
    settingsBox = await Hive.openBox(settingsBoxName);
    if (settingsBox.keys.contains('animationText')) {
      animationText = settingsBox.get('animationText');
    }
    if (settingsBox.keys.contains('isMinimumAccuracy')) {
      switcher_one = settingsBox.get('isDisableWakelock');
    }
    if (settingsBox.keys.contains('isSwipe')) {
      switcher_two = settingsBox.get('isSwipe');
    }
    if (settingsBox.keys.contains('disableAnimation')) {
      switcher_three = settingsBox.get('disableAnimation');
    }
    if (settingsBox.keys.contains('isDisableWakelock')) {
      switcher_four = settingsBox.get('isDisableWakelock');
    }
    if (settingsBox.keys.contains('isHiddenBar')) {
      switcher_six = settingsBox.get('isHiddenBar');
    }

    if (settingsBox.keys.contains('themeIndex')) {
      theme.value = settingsBox.get('themeIndex');
    }
  }

  getHistory() {
    historyLength = historyBox.keys.length;
    var historyDataKeys = historyBox.keys;
    var historyDataValues = historyBox.values;
    historyResult.value = {};
    for (var i = 0; i < historyLength; i++) {
      historyResult.value[historyDataKeys.elementAt(i)] =
          historyDataValues.elementAt(i);
    }
  }

  deleteHistory(String dataKey) {
    if (dataKey == 'all') {
      historyBox.deleteAll(historyBox.keys);
    } else {
      historyBox.delete(dataKey);
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    _measureTabController.dispose();
    _endDrawerTabController.dispose();
    animationController.dispose();
    calculateController.dispose();
    resultController.dispose();
    super.dispose();
  }

  writer(String command) {
    if (command == 'C') {
      calculateController.text = '';
      resultController.text = '';
      topFieldSize = 35;
      bottomFieldSize = 45;
    } else if (command == 'del') {
      if (calculateController.text.isNotEmpty) {
        calculateController.text = calculateController.text
            .substring(0, calculateController.text.length - 1);
        var res = calculate(bracketFiller(calculateController.text));
        if (res != null) {
          resultController.text = "$res";
        }
      }
    } else if (command == '=') {
      if (resultController.text.isNotEmpty) {
        var currentTime = DateTime.now().toString();
        historyBox.put(
            currentTime, [calculateController.text, resultController.text]);
        calculateController.text = resultController.text;
        resultController.text = '';
      }
    } else if (command == '+/-') {
      if (resultController.text.length > 1) {
        if (resultController.text.contains('-')) {
          resultController.text = resultController.text.substring(1);
        } else {
          resultController.text = '-${resultController.text}';
        }
      }
    } else if (command == '%') {
      if (calculateController.text.isNotEmpty) {
        var last = splitter(calculateController.text);
        var calculateText = calculateController.text;
        calculateController.text =
            '${calculateText.substring(0, calculateText.length - last.length)}${double.parse(last) / 100}';
        var res = calculate(bracketFiller(calculateController.text));
        if (res != null) {
          resultController.text = "$res";
        }
      }
    } else if (command == '/' ||
        command == '*' ||
        command == '+' ||
        command == '-') {
      lastOperator = command;
      if (calculateController.text.isNotEmpty &&
          !isOperator(
              calculateController.text[calculateController.text.length - 1])) {
        calculateController.text += command;
        var res = calculate(bracketFiller(calculateController.text));
        if (res != null) {
          resultController.text = "$res";
        }
      }
    } else if (command == '.') {
      if (calculateController.text.isNotEmpty &&
          !isOperator(
              calculateController.text[calculateController.text.length - 1])) {
        if (calculateController.text.isNotEmpty) {
          var last = splitter(calculateController.text);
          if (!last.contains('.')) {
            calculateController.text += command;
            var res = calculate(bracketFiller(calculateController.text));
            if (res != null) {
              resultController.text = "$res";
            }
          }
        }
      }
    } else if (command == '(') {
      if (calculateController.text.isEmpty) {
        calculateController.text += command;
      } else if (operators.contains(
          calculateController.text[calculateController.text.length - 1])) {
        calculateController.text += command;
        resultController.text =
            calculate(bracketFiller(calculateController.text));
      } else {
        calculateController.text += '*$command';
      }
    } else if (command == ')') {
      if (!operators.contains(
              calculateController.text[calculateController.text.length - 1]) &&
          calculateController.text.isNotEmpty) {
        if (bracketDifference(calculateController.text) > 0) {
          calculateController.text += command;
          resultController.text =
              calculate(bracketFiller(calculateController.text));
        }
      }
    } else {
      if (resultController.text.isEmpty &&
          calculateController.text.isNotEmpty) {
        if (calculateController.text.contains('(')) {
          calculateController.text += command;
        } else {
          calculateController.text = command;
        }
        resultController.text = command;
      } else {
        calculateController.text += command;
        var res = calculate(bracketFiller(calculateController.text));
        if (res != null) {
          resultController.text = "$res";
        }
      }
    }
  }

  int bracketDifference(String operation) {
    int left = 0;
    int right = 0;
    for (int i = 0; i < operation.length; i++) {
      if (operation[i] == '(') {
        left++;
      }
      if (operation[i] == ')') {
        right++;
      }
    }
    return left - right;
  }

  String bracketFiller(String operation) {
    int left = 0;
    int right = 0;
    for (int i = 0; i < operation.length; i++) {
      if (operation[i] == '(') {
        left++;
      }
      if (operation[i] == ')') {
        right++;
      }
    }
    for (int j = 0; j < left - right; j++) {
      if (!operators.contains(operation[operation.length - 1])) {
        operation += '*1)';
      }
    }
    return operation;
  }

  // Calculator text size checker
  sizeChecker() {
    if (resultController.text.length < 15) {
      bottomFieldSize = 45;
      setState(() {});
    } else if (resultController.text.length < 20) {
      bottomFieldSize = 30;
      setState(() {});
    } else if (resultController.text.length < 25) {
      bottomFieldSize = 20;
      setState(() {});
    } else if (resultController.text.length < 35) {
      bottomFieldSize = 15;
      setState(() {});
    }
    if (calculateController.text.length < 15) {
      topFieldSize = 35;
      setState(() {});
    } else if (calculateController.text.length < 20) {
      topFieldSize = 25;
      setState(() {});
    } else if (calculateController.text.length < 25) {
      topFieldSize = 20;
      setState(() {});
    } else if (calculateController.text.length < 35) {
      topFieldSize = 15;
      setState(() {});
    }
  }

  // Simple Calculator keyboard
  Widget customKeyboard(Size size) {
    return GridView.count(
      shrinkWrap: true,
      mainAxisSpacing: currentTheme['calculatorMainAxisSpacing'],
      crossAxisSpacing: currentTheme['calculatorCrossAxisSpacing'],
      controller: scrollController,
      physics:
          const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
      childAspectRatio:
          (screenSize.width / 4) / (screenSize.height * 0.6 / 5.4),
      crossAxisCount: 4,
      children: List.generate(
        20,
        (index) => Container(
          decoration: index < 4
              ? currentTheme['operatorBtDecoration']
              : index % 4 == 3
                  ? currentTheme['operatorBtDecoration']
                  : currentTheme['simpleBtDecoration'],
          child: InkWell(
            splashColor: Colors.blue[200],
            onTap: () {
              writer(simpleButtons.values.elementAt(index));
              HapticFeedback.vibrate;
              setState(() {});
            },
            child: Center(
              child: Text(
                simpleButtons.keys.elementAt(index),
                style: TextStyle(
                    color: index < 4
                        ? currentTheme['operatorButtonColor']
                        : index % 4 == 3
                            ? currentTheme['operatorButtonColor']
                            : currentTheme['simpleButtonColor'],
                    fontSize: 30),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Scientific Calculator keyboard
  Widget customScientificKeyboard(Size size) {
    return Container(
      color: Colors.black,
      height: size.height * 0.56,
      child: GridView.count(
        mainAxisSpacing: currentTheme['calculatorMainAxisSpacing'],
        crossAxisSpacing: currentTheme['calculatorCrossAxisSpacing'],
        childAspectRatio:
            (screenSize.width / 4) / (screenSize.height * 0.6 / 5.4),
        crossAxisCount: 4,
        children: List.generate(
          20,
          (index) => InkWell(
            splashColor: Colors.blue[200],
            onTap: () {
              writer(scientificButtons.values.elementAt(index));
              HapticFeedback.heavyImpact();
              setState(() {});
            },
            child: Container(
              decoration: currentTheme['simpleBtDecoration'],
              child: Center(
                child: Text(
                  scientificButtons.keys.elementAt(index),
                  style: TextStyle(
                      color: currentTheme['simpleButtonColor'], fontSize: 24),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Calculator History
  Widget calculatorHistory(Size size) {
    return ValueListenableBuilder(
      builder: (BuildContext context, value, Widget? child) {
        return SafeArea(
          child: Container(
            decoration: BoxDecoration(
              color: currentTheme['fullBgColor'],
              border: Border(
                top: BorderSide(color: currentTheme['menuBtColor'], width: 2),
              ),
            ),
            width: double.infinity,
            height: size.height * 0.75,
            child: ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.only(left: 20, right: 20),
              physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              children: List.generate(
                historyLength,
                (index) => Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: currentTheme['menuBtColor'], width: 2),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: ListTile(
                    leading: IconButton(
                        onPressed: () {
                          deleteHistory(
                              historyResult.value.keys.elementAt(index));
                          getHistory();
                          setState(() {});
                        },
                        icon: const Icon(
                          CupertinoIcons.delete,
                          size: 20,
                          color: Colors.red,
                        )),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          historyResult.value.values.elementAt(index)[1],
                          style: TextStyle(
                              color: currentTheme['simpleButtonColor'],
                              fontSize: 12),
                        ),
                        Text(
                          historyResult.value.values.elementAt(index)[0],
                          style: TextStyle(
                              color: currentTheme['simpleButtonColor'],
                              fontSize: 12),
                        ),
                      ],
                    ),
                    subtitle: Text(
                      historyResult.value.keys
                          .elementAt(index)
                          .substring(0, 19),
                      style: TextStyle(
                          color: currentTheme['simpleButtonColor'],
                          fontSize: 8),
                    ),
                    trailing: IconButton(
                        onPressed: () {
                          calculateController.text =
                              historyResult.value.values.elementAt(index)[0];
                          resultController.text =
                              historyResult.value.values.elementAt(index)[1];
                          setState(() {});
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.document_scanner_outlined,
                          color: currentTheme['menuBtColor'],
                        )),
                  ),
                ),
              ),
            ),
          ),
        );
      },
      valueListenable: historyResult,
    );
  }

  // Calculator Page Widget
  Widget calculatorPageWidget(Size size) {
    screenSize = size;
    if (switcher_four) {
      Wakelock.enable();
    } else {
      Wakelock.disable();
    }
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // #history field
          Container(
            margin: EdgeInsets.only(bottom: size.height * 0.02),
            width: double.infinity,
            height: size.height * 0.075 - 3,
            child: Row(
              children: [
                Expanded(
                  flex: 15,
                  child: Container(
                    padding: EdgeInsets.only(left: size.width * 0.1),
                    height: size.height * 0.048,
                    child: ShaderMask(
                      shaderCallback: (rect) {
                        return LinearGradient(
                          stops: [
                            animation.value - 0.3,
                            animation.value,
                            animation.value + 0.3,
                          ],
                          colors: [
                            currentTheme['fullBgColor'],
                            currentTheme['animationTextColors'],
                            currentTheme['fullBgColor'],
                          ],
                        ).createShader(rect);
                      },
                      child: Center(
                        child: Text(
                          switcher_three ? '' : animationText,
                          style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: AspectRatio(
                    aspectRatio: .1 / .1,
                    child: Container(
                      decoration: currentTheme['historyDecoration'],
                      child: GestureDetector(
                        onTap: () {
                          getHistory();
                          showModalBottomSheet(
                            isScrollControlled: true,
                            context: context,
                            builder: (BuildContext context) {
                              return StatefulBuilder(
                                builder: (BuildContext context,
                                    StateSetter setState) {
                                  return Container(
                                    color: currentTheme['fullBgColor'],
                                    height: size.height * 0.89,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Container(
                                          color: Colors.transparent,
                                          padding: EdgeInsets.only(
                                              bottom: size.height * 0.0),
                                          width: double.infinity,
                                          height: size.height * 0.06,
                                          child: Row(
                                            children: [
                                              Expanded(
                                                flex: 12,
                                                child: Container(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  height: size.height * 0.06,
                                                  color: currentTheme[
                                                      'fullBgColor'],
                                                  child: Text(
                                                    '      history',
                                                    style: TextStyle(
                                                        color: currentTheme[
                                                            'menuBtColor'],
                                                        fontSize: 20),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 2,
                                                child: Container(
                                                  height: size.height * 0.06,
                                                  color: currentTheme[
                                                      'fullBgColor'],
                                                  child: IconButton(
                                                    splashRadius:
                                                        size.height * 0.04,
                                                    onPressed: () {
                                                      deleteHistory('all');
                                                      getHistory();
                                                      setState(() {});
                                                    },
                                                    icon: Image(
                                                      image: const AssetImage(
                                                          'assets/images/main_images/trash_bin.png'),
                                                      width: 35,
                                                      color: currentTheme[
                                                          'menuBtColor'],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          width: double.infinity,
                                          child: calculatorHistory(size),
                                        ),
                                        SizedBox(
                                          width: double.infinity,
                                          height: size.height * 0.04,
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.pop(context);
                                            },
                                            child: Container(
                                              height: size.height * 0.04,
                                              decoration: currentTheme[
                                                  'bottomSheetDecoration'],
                                              child: Center(
                                                child: Transform.rotate(
                                                  angle: math.pi,
                                                  child: Image(
                                                    image: const AssetImage(
                                                        'assets/images/main_images/up_down.png'),
                                                    height: size.height * 0.015,
                                                    color: currentTheme[
                                                        'bottomSheetIconColor'],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                          );
                        },
                        child: Image(
                          image: const AssetImage(
                              'assets/images/main_images/ic_history.png'),
                          color: currentTheme['historyIconColor'],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 15),
              ],
            ),
          ),

          Stack(
            children: [
              SizedBox(
                width: double.infinity,
                height: size.height * 0.2,
                child: Column(
                  children: [
                    // #first textfield
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      alignment: Alignment.centerRight,
                      width: double.infinity,
                      height: size.height * 0.1,
                      child: TextField(
                        maxLines: 3,
                        onTap: sizeChecker(),
                        textAlign: TextAlign.end,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                        ),
                        controller: calculateController,
                        readOnly: true,
                        style: TextStyle(
                          fontSize: topFieldSize,
                          fontWeight: FontWeight.w500,
                          color: currentTheme['firstTextFieldColor'],
                        ),
                      ),
                    ),
                    //#second textfield
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      alignment: Alignment.topRight,
                      width: double.infinity,
                      height: size.height * 0.1,
                      child: TextField(
                        maxLines: 2,
                        textAlign: TextAlign.end,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                        ),
                        controller: resultController,
                        readOnly: true,
                        style: TextStyle(
                          fontSize: bottomFieldSize,
                          fontWeight: FontWeight.w500,
                          color: currentTheme['secondTextFieldColor'],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              //#swipe clear
              Align(
                alignment: const Alignment(0, 1),
                child: Transform.translate(
                  offset: const Offset(200, 100),
                  child: AnimatedScale(
                    duration: const Duration(milliseconds: 300),
                    scale: animCricleClear,
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: currentTheme['swipeColor']),
                    ),
                    onEnd: () {
                      setState(() {
                        animCricleClear = 0;
                        setState(() {});
                      });
                    },
                  ),
                ),
              ),
            ],
          ),
          //#keyboards
          Container(
            width: double.infinity,
            height: size.height * 0.6,
            decoration: currentTheme['calKeyboardContainerDec'],
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  alignment: Alignment.bottomCenter,
                  width: double.infinity,
                  height: size.height * 0.56,
                  child: customKeyboard(size),
                ),
                Expanded(
                  child: SizedBox(
                    width: double.infinity,
                    child: InkWell(
                      onTap: () {
                        showModalBottomSheet(
                          isScrollControlled: true,
                          context: context,
                          builder: (BuildContext context) {
                            return Container(
                              color: currentTheme['fullBgColor'],
                              height: size.height * 0.6,
                              child: Column(
                                children: [
                                  SizedBox(
                                    width: double.infinity,
                                    height: size.height * 0.04,
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                      child: Container(
                                        margin: const EdgeInsets.all(1),
                                        height: size.height * 0.04,
                                        decoration: currentTheme[
                                            'bottomSheetDecoration'],
                                        child: Center(
                                          child: Transform.rotate(
                                            angle: math.pi,
                                            child: Image(
                                              image: const AssetImage(
                                                  'assets/images/main_images/up_down.png'),
                                              height: size.height * 0.015,
                                              color: currentTheme[
                                                  'bottomSheetIconColor'],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: double.infinity,
                                    child: customScientificKeyboard(size),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 1),
                        height: size.height * 0.04,
                        decoration: currentTheme['bottomSheetDecoration'],
                        child: Center(
                          child: Image(
                            image: const AssetImage(
                                'assets/images/main_images/up_down.png'),
                            height: size.height * 0.015,
                            color: currentTheme['bottomSheetIconColor'],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

////////////////////////////////////////////////////////////////////////////////////////////////////////////////

  /// #measure bottomSheet
  Widget measureBottomSheet(
      Size size, Map<String, String> measureType, String selectedItem) {
    return ListView.builder(
      itemCount: measureType.length,
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
          onTap: () {
            switch (measureType) {
              case MeasureUtils.distance:
                distanceValue = measureType.keys.elementAt(index);
                break;
              case MeasureUtils.area:
                areaValue = measureType.keys.elementAt(index);
                break;
              case MeasureUtils.mass:
                massValue = measureType.keys.elementAt(index);
                break;
              case MeasureUtils.volume:
                volumeValue = measureType.keys.elementAt(index);
                break;
              case MeasureUtils.temperature:
                temperatureValue = measureType.keys.elementAt(index);
                break;
              case MeasureUtils.fuel:
                fuelValue = measureType.keys.elementAt(index);
                break;
              default:
                cookingValue = measureType.keys.elementAt(index);
            }
            setState(() {});
            Navigator.pop(context);
          },
          child: Container(
            alignment: Alignment.center,
            decoration: index.isOdd
                ? currentTheme['simpleBtDecoration']
                : currentTheme['operatorBtDecoration'],
            height: size.height * 0.1,
            width: double.infinity,
            child: ListTile(
              leading: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    measureType.keys.elementAt(index),
                    style:
                        TextStyle(color: currentTheme['measureTabItemColor']),
                  ),
                  Text(
                    measureType.values.elementAt(index),
                    style: TextStyle(
                        color: currentTheme['measureTabItemColor'],
                        fontSize: 22),
                  ),
                ],
              ),
              trailing: selectedItem == measureType.keys.elementAt(index)
                  ? const Image(
                      image:
                          AssetImage('assets/images/main_images/checkmark.png'),
                      width: 25,
                    )
                  : null,
            ),
          ),
        );
      },
    );
  }

  /// Measure listview
  Widget measureListview(Size size, Map<String, String> measureType) {
    bool checkColor = false;
    return Container(
      color: Colors.transparent,
      height: size.height * 0.65,
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: measureType.length,
        itemBuilder: (BuildContext context, int index) {
          if (measureTypeChecker(measureType) !=
              measureType.keys.elementAt(index)) {
            bool temp = checkColor;
            checkColor = !checkColor;
            return Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: temp
                    ? currentTheme['IsOddColor']
                    : currentTheme['IsEvenColor'],
              ),
              height: size.height * 0.1,
              width: double.infinity,
              child: ListTile(
                leading: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      measureType.keys.elementAt(index),
                      style: TextStyle(
                          color: temp
                              ? currentTheme['simpleButtonColor']
                              : currentTheme['measureTabItemColor']),
                    ),
                    Text(
                      measureType.values.elementAt(index),
                      style: TextStyle(
                          color: temp
                              ? currentTheme['simpleButtonColor']
                              : currentTheme['measureTabItemColor'],
                          fontSize: 22),
                    ),
                  ],
                ),
                trailing: Text(
                  chosenMeasure(measureType, measureType.keys.elementAt(index)),
                  style: TextStyle(
                      color: temp
                          ? currentTheme['simpleButtonColor']
                          : currentTheme['measureTabItemColor'],
                      fontSize: 20),
                ),
              ),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }

  measureTypeChecker(Map<String, String> measureType) {
    switch (measureType) {
      case MeasureUtils.distance:
        return distanceValue;
      case MeasureUtils.area:
        return areaValue;
      case MeasureUtils.mass:
        return massValue;
      case MeasureUtils.volume:
        return volumeValue;
      case MeasureUtils.temperature:
        return temperatureValue;
      case MeasureUtils.fuel:
        return fuelValue;
      default:
        return cookingValue;
    }
  }

  String chosenMeasure(Map<String, String> measureType, String measurekey) {
    switch (measureType) {
      case MeasureUtils.distance:
        var res = (double.parse(measureAmount) *
                MeasureUtils.distanceAmounts[distanceValue] /
                MeasureUtils.distanceAmounts[measurekey])
            .toStringAsFixed(10);
        return double.parse(res).toString();
      case MeasureUtils.area:
        var res = (double.parse(measureAmount) *
                MeasureUtils.areaAmounts[areaValue] /
                MeasureUtils.areaAmounts[measurekey])
            .toStringAsFixed(10);
        return double.parse(res).toString();
      case MeasureUtils.mass:
        var res = (double.parse(measureAmount) *
                MeasureUtils.massAmounts[massValue] /
                MeasureUtils.massAmounts[measurekey])
            .toStringAsFixed(10);
        return double.parse(res).toString();
      case MeasureUtils.volume:
        var res = (double.parse(measureAmount) *
                MeasureUtils.volumeAmounts[volumeValue] /
                MeasureUtils.volumeAmounts[measurekey])
            .toStringAsFixed(10);
        return double.parse(res).toString();
      case MeasureUtils.temperature:
        var res = (double.parse(measureAmount) *
                MeasureUtils.temperatureAmounts[temperatureValue]! /
                MeasureUtils.temperatureAmounts[measurekey]!)
            .toStringAsFixed(10);
        return double.parse(res).toString();
      case MeasureUtils.fuel:
        var res = (double.parse(measureAmount) *
                MeasureUtils.fuelAmounts[fuelValue] /
                MeasureUtils.fuelAmounts[measurekey])
            .toStringAsFixed(10);
        return double.parse(res).toString();
      default:
        var res = (double.parse(measureAmount) *
                MeasureUtils.cookingAmounts[cookingValue] /
                MeasureUtils.cookingAmounts[measurekey])
            .toStringAsFixed(10);
        return double.parse(res).toString();
    }
  }

  /// Measure keyboard
  Widget measureKeyboard(Size size) {
    return GridView.count(
      mainAxisSpacing: currentTheme['calculatorMainAxisSpacing'],
      crossAxisSpacing: currentTheme['calculatorCrossAxisSpacing'],
      controller: scrollController,
      physics:
          const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
      childAspectRatio:
          (screenSize.width / 4) / (screenSize.height * 0.6 / 4.2),
      crossAxisCount: 4,
      children: List.generate(
        16,
        (index) => InkWell(
          splashColor: Colors.blue[200],
          onTap: index == 11
              ? () {
                  Navigator.pop(context);
                  setState(() {});
                }
              : index == 15
                  ? () {
                      measureCalculator('C');
                      Navigator.pop(context);
                      setState(() {});
                    }
                  : () {
                      measureCalculator(measureButtons.values.elementAt(index));
                      setState(() {});
                    },
          child: Container(
            decoration: currentTheme['operatorBtDecoration'],
            child: Center(
              child: Image(
                image: AssetImage(measureButtons.keys.elementAt(index)),
                height: 24,
                width: 24,
                color: currentTheme['operatorButtonColor'],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Measure Page Widget
  Widget measurePageWidget(Size size) {
    currentTheme = themeSwitcher(theme.value);
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 47,
        title: TabBar(
          isScrollable: true,
          labelColor: currentTheme['measureTabItemColor'],
          controller: _measureTabController,
          indicatorWeight: 4,
          indicatorColor: currentTheme['measureTabItemColor'],
          tabs: measureTabs,
        ),
      ),
      body: TabBarView(
        controller: _measureTabController,
        children: [
          // #distance page
          ListView(
            reverse: true,
            children: [
              SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 10),
                      height: size.height * 0.2,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            width: 3,
                            color: currentTheme['measureTabItemColor'],
                          ),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            distanceValue,
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: currentTheme['measureTabItemColor']),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: () {
                                  showModalBottomSheet(
                                    isScrollControlled: true,
                                    context: context,
                                    builder: (BuildContext context) {
                                      return Container(
                                        color: currentTheme['fullBgColor'],
                                        width: double.infinity,
                                        height: size.height * 0.67,
                                        child: measureBottomSheet(
                                            size,
                                            MeasureUtils.distance,
                                            distanceValue),
                                      );
                                    },
                                  );
                                },
                                child: Row(
                                  children: [
                                    Text(
                                      MeasureUtils.distance[distanceValue] ??
                                          '',
                                      style: TextStyle(
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold,
                                          color: currentTheme[
                                              'measureTabItemColor']),
                                    ),
                                    Icon(Icons.arrow_drop_down,
                                        color: currentTheme[
                                            'measureTabItemColor']),
                                  ],
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  showModalBottomSheet(
                                    isScrollControlled: true,
                                    context: context,
                                    builder: (BuildContext context) {
                                      return Container(
                                        padding: const EdgeInsets.all(10),
                                        color: currentTheme['fullBgColor'],
                                        width: double.infinity,
                                        height: size.height * 0.6,
                                        child: measureKeyboard(size),
                                      );
                                    },
                                  );
                                },
                                child: Text(
                                  measureAmount,
                                  style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                      color:
                                          currentTheme['measureTabItemColor']),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    measureListview(size, MeasureUtils.distance),
                  ],
                ),
              ),
            ],
          ),

          //#area page
          ListView(
            reverse: true,
            children: [
              SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 10),
                      height: size.height * 0.2,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            width: 3,
                            color: currentTheme['measureTabItemColor'],
                          ),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            areaValue,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: currentTheme['measureTabItemColor'],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: () {
                                  showModalBottomSheet(
                                    isScrollControlled: true,
                                    context: context,
                                    builder: (BuildContext context) {
                                      return Container(
                                        color: currentTheme['fullBgColor'],
                                        width: double.infinity,
                                        height: size.height * 0.67,
                                        child: measureBottomSheet(
                                            size, MeasureUtils.area, areaValue),
                                      );
                                    },
                                  );
                                },
                                child: Row(
                                  children: [
                                    Text(
                                      MeasureUtils.area[areaValue] ?? '',
                                      style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold,
                                        color:
                                            currentTheme['measureTabItemColor'],
                                      ),
                                    ),
                                    Icon(
                                      Icons.arrow_drop_down,
                                      color:
                                          currentTheme['measureTabItemColor'],
                                    ),
                                  ],
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  showModalBottomSheet(
                                    isScrollControlled: true,
                                    context: context,
                                    builder: (BuildContext context) {
                                      return Container(
                                        width: double.infinity,
                                        height: size.height * 0.6,
                                        child: measureKeyboard(size),
                                      );
                                    },
                                  );
                                },
                                child: Text(
                                  measureAmount,
                                  style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                    color: currentTheme['measureTabItemColor'],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    measureListview(size, MeasureUtils.area),
                  ],
                ),
              ),
            ],
          ),

          //#mass page
          ListView(
            reverse: true,
            children: [
              SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 10),
                      height: size.height * 0.2,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            width: 3,
                            color: currentTheme['measureTabItemColor'],
                          ),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            areaValue,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: currentTheme['measureTabItemColor'],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: () {
                                  showModalBottomSheet(
                                    isScrollControlled: true,
                                    context: context,
                                    builder: (BuildContext context) {
                                      return Container(
                                        color: currentTheme['fullBgColor'],
                                        width: double.infinity,
                                        height: size.height * 0.67,
                                        child: measureBottomSheet(
                                            size, MeasureUtils.mass, areaValue),
                                      );
                                    },
                                  );
                                },
                                child: Row(
                                  children: [
                                    Text(
                                      MeasureUtils.mass[massValue] ?? '',
                                      style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold,
                                        color:
                                            currentTheme['measureTabItemColor'],
                                      ),
                                    ),
                                    Icon(
                                      Icons.arrow_drop_down,
                                      color:
                                          currentTheme['measureTabItemColor'],
                                    ),
                                  ],
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  showModalBottomSheet(
                                    isScrollControlled: true,
                                    context: context,
                                    builder: (BuildContext context) {
                                      return Container(
                                        width: double.infinity,
                                        height: size.height * 0.6,
                                        child: measureKeyboard(size),
                                      );
                                    },
                                  );
                                },
                                child: Text(
                                  measureAmount,
                                  style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                    color: currentTheme['measureTabItemColor'],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    measureListview(size, MeasureUtils.mass),
                  ],
                ),
              ),
            ],
          ),

          //#volume page
          ListView(
            reverse: true,
            children: [
              SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 10),
                      height: size.height * 0.2,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            width: 3,
                            color: currentTheme['measureTabItemColor'],
                          ),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            volumeValue,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: currentTheme['measureTabItemColor'],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: () {
                                  showModalBottomSheet(
                                    isScrollControlled: true,
                                    context: context,
                                    builder: (BuildContext context) {
                                      return Container(
                                        color: currentTheme['fullBgColor'],
                                        width: double.infinity,
                                        height: size.height * 0.67,
                                        child: measureBottomSheet(size,
                                            MeasureUtils.volume, volumeValue),
                                      );
                                    },
                                  );
                                },
                                child: Row(
                                  children: [
                                    Text(
                                      MeasureUtils.volume[volumeValue] ?? '',
                                      style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold,
                                        color:
                                            currentTheme['measureTabItemColor'],
                                      ),
                                    ),
                                    Icon(
                                      Icons.arrow_drop_down,
                                      color:
                                          currentTheme['measureTabItemColor'],
                                    ),
                                  ],
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  showModalBottomSheet(
                                    isScrollControlled: true,
                                    context: context,
                                    builder: (BuildContext context) {
                                      return Container(
                                        width: double.infinity,
                                        height: size.height * 0.6,
                                        child: measureKeyboard(size),
                                      );
                                    },
                                  );
                                },
                                child: Text(
                                  measureAmount,
                                  style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                    color: currentTheme['measureTabItemColor'],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    measureListview(size, MeasureUtils.volume),
                  ],
                ),
              ),
            ],
          ),

          //#temperature page
          ListView(
            reverse: true,
            children: [
              SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 10),
                      height: size.height * 0.2,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            width: 3,
                            color: currentTheme['measureTabItemColor'],
                          ),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            temperatureValue,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: currentTheme['measureTabItemColor'],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: () {
                                  showModalBottomSheet(
                                    isScrollControlled: true,
                                    context: context,
                                    builder: (BuildContext context) {
                                      return Container(
                                        color: currentTheme['fullBgColor'],
                                        width: double.infinity,
                                        height: size.height * 0.67,
                                        child: measureBottomSheet(
                                            size,
                                            MeasureUtils.temperature,
                                            temperatureValue),
                                      );
                                    },
                                  );
                                },
                                child: Row(
                                  children: [
                                    Text(
                                      MeasureUtils
                                              .temperature[temperatureValue] ??
                                          '',
                                      style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold,
                                        color:
                                            currentTheme['measureTabItemColor'],
                                      ),
                                    ),
                                    Icon(
                                      Icons.arrow_drop_down,
                                      color:
                                          currentTheme['measureTabItemColor'],
                                    ),
                                  ],
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  showModalBottomSheet(
                                    isScrollControlled: true,
                                    context: context,
                                    builder: (BuildContext context) {
                                      return Container(
                                        width: double.infinity,
                                        height: size.height * 0.6,
                                        child: measureKeyboard(size),
                                      );
                                    },
                                  );
                                },
                                child: Text(
                                  measureAmount,
                                  style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                    color: currentTheme['measureTabItemColor'],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    measureListview(size, MeasureUtils.temperature),
                  ],
                ),
              ),
            ],
          ),

          //#fuel page
          ListView(
            reverse: true,
            children: [
              SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 10),
                      height: size.height * 0.2,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            width: 3,
                            color: currentTheme['measureTabItemColor'],
                          ),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            fuelValue,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: currentTheme['measureTabItemColor'],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: () {
                                  showModalBottomSheet(
                                    isScrollControlled: true,
                                    context: context,
                                    builder: (BuildContext context) {
                                      return Container(
                                        color: currentTheme['fullBgColor'],
                                        width: double.infinity,
                                        height: size.height * 0.67,
                                        child: measureBottomSheet(
                                            size, MeasureUtils.fuel, fuelValue),
                                      );
                                    },
                                  );
                                },
                                child: Row(
                                  children: [
                                    Text(
                                      MeasureUtils.fuel[fuelValue] ?? '',
                                      style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold,
                                        color:
                                            currentTheme['measureTabItemColor'],
                                      ),
                                    ),
                                    Icon(
                                      Icons.arrow_drop_down,
                                      color:
                                          currentTheme['measureTabItemColor'],
                                    ),
                                  ],
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  showModalBottomSheet(
                                    isScrollControlled: true,
                                    context: context,
                                    builder: (BuildContext context) {
                                      return Container(
                                        width: double.infinity,
                                        height: size.height * 0.6,
                                        child: measureKeyboard(size),
                                      );
                                    },
                                  );
                                },
                                child: Text(
                                  measureAmount,
                                  style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                    color: currentTheme['measureTabItemColor'],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    measureListview(size, MeasureUtils.fuel),
                  ],
                ),
              ),
            ],
          ),

          //#cooking page
          ListView(
            reverse: true,
            children: [
              SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 10),
                      height: size.height * 0.2,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            width: 3,
                            color: currentTheme['measureTabItemColor'],
                          ),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            cookingValue,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: currentTheme['measureTabItemColor'],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: () {
                                  showModalBottomSheet(
                                    isScrollControlled: true,
                                    context: context,
                                    builder: (BuildContext context) {
                                      return Container(
                                        color: currentTheme['fullBgColor'],
                                        width: double.infinity,
                                        height: size.height * 0.67,
                                        child: measureBottomSheet(size,
                                            MeasureUtils.cooking, cookingValue),
                                      );
                                    },
                                  );
                                },
                                child: Row(
                                  children: [
                                    Text(
                                      MeasureUtils.cooking[cookingValue] ?? '',
                                      style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold,
                                        color:
                                            currentTheme['measureTabItemColor'],
                                      ),
                                    ),
                                    Icon(
                                      Icons.arrow_drop_down,
                                      color:
                                          currentTheme['measureTabItemColor'],
                                    ),
                                  ],
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  showModalBottomSheet(
                                    isScrollControlled: true,
                                    context: context,
                                    builder: (BuildContext context) {
                                      return Container(
                                        width: double.infinity,
                                        height: size.height * 0.6,
                                        child: measureKeyboard(size),
                                      );
                                    },
                                  );
                                },
                                child: Text(
                                  measureAmount,
                                  style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                    color: currentTheme['measureTabItemColor'],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    measureListview(size, MeasureUtils.cooking),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

////////////////////////////////////////////////////////////////////////////////////////////////////////////////

  Widget endDrawerPageWidget() {
    currentTheme = themeSwitcher(theme.value);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        shape: currentTheme['appBarShape'],
        backgroundColor: currentTheme['appBarBgColor'],
        title: TabBar(
          controller: _endDrawerTabController,
          tabs: endDrawerTabs,
          indicatorWeight: 4.0,
          indicatorColor: Colors.white,
        ),
      ),
      body: TabBarView(
        controller: _endDrawerTabController,
        children: [
          //#settings page
          SafeArea(
            child: Container(
              margin: const EdgeInsets.all(10),
              width: double.infinity,
              child: ListView(
                children: [
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 260,
                        child: FastForm(
                          formKey: formKey,
                          children: [
                            FastTextField(
                              name: 'text_field',
                              labelText: 'Change the animation text',
                              onChanged: (value) {
                                changedText = value ?? animationText;
                              },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 30),
                      OutlinedButton(
                        onPressed: () {
                          animationText = changedText;
                          settingsBox.put('animationText', animationText);
                          Navigator.pop(context);
                          setState(() {});
                        },
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.grey),
                          foregroundColor:
                              MaterialStateProperty.all(Colors.white),
                        ),
                        child: const Center(
                          child: Text('OK'),
                        ),
                      ),
                    ],
                  ),
                  ListTileSwitch(
                    value: switcher_one,
                    onChanged: (value) {
                      setState(() {
                        switcher_one = value;
                        settingsBox.put('isMinimumAccuracy', switcher_one);
                      });
                    },
                    visualDensity: VisualDensity.comfortable,
                    switchType: SwitchType.cupertino,
                    switchActiveColor: Colors.indigo,
                    title: const Text('Minimum accuracy'),
                    subtitle: const Text('Limit minimum accuracy to 2 digits'),
                  ),
                  ListTileSwitch(
                    value: switcher_two,
                    onChanged: (value) {
                      setState(() {
                        switcher_two = value;
                        settingsBox.put('isSwipe', switcher_two);
                      });
                    },
                    visualDensity: VisualDensity.comfortable,
                    switchType: SwitchType.cupertino,
                    switchActiveColor: Colors.indigo,
                    title: const Text('Swipe to count'),
                    subtitle:
                        const Text('Swipe down the keyboard to calculate'),
                  ),
                  ListTileSwitch(
                    value: switcher_three,
                    onChanged: (value) {
                      setState(() {
                        switcher_three = value;
                        settingsBox.put('disableAnimation', switcher_three);
                      });
                    },
                    visualDensity: VisualDensity.comfortable,
                    switchType: SwitchType.cupertino,
                    switchActiveColor: Colors.indigo,
                    title: const Text('Disable text animation'),
                    subtitle: const Text(
                        'Turn off text animation in the main section'),
                  ),
                  ListTileSwitch(
                    value: switcher_four,
                    onChanged: (value) {
                      setState(() {
                        switcher_four = value;
                        settingsBox.put('isDisableWakelock', switcher_four);
                      });
                    },
                    visualDensity: VisualDensity.comfortable,
                    switchType: SwitchType.cupertino,
                    switchActiveColor: Colors.indigo,
                    title: const Text('Leave the screen on'),
                    subtitle: const Text(
                        'Disable sleep mode while the application is running'),
                  ),
                  ListTileSwitch(
                    value: switcher_five,
                    onChanged: (value) {
                      setState(() {
                        switcher_five = value;
                      });
                    },
                    visualDensity: VisualDensity.comfortable,
                    switchType: SwitchType.cupertino,
                    switchActiveColor: Colors.indigo,
                    title: const Text('Turn off the vibration'),
                  ),
                  ListTileSwitch(
                    value: switcher_six,
                    onChanged: (value) {
                      switcher_six = value;
                      initPlatformState();
                      setState(() {
                        settingsBox.put('isHiddenBar', switcher_six);
                      });
                    },
                    visualDensity: VisualDensity.comfortable,
                    switchType: SwitchType.cupertino,
                    switchActiveColor: Colors.indigo,
                    title: const Text('Hide status bar'),
                  ),
                  Center(
                    child: InkWell(
                      onTap: () =>
                          Navigator.pushNamed(context, Routes.aboutPage),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Image(
                            image: AssetImage(
                                'assets/images/main_images/about.png'),
                            width: 30,
                          ),
                          Text(
                            ' About',
                            style: TextStyle(color: Colors.black, fontSize: 25),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),

          //#themes page
          SafeArea(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                children: List.generate(
                  themesList.length,
                  (index) {
                    return GestureDetector(
                      onTap: () {
                        theme.value = index + 1;
                        settingsBox.put('themeIndex', theme.value);
                        setState(() {});
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 3),
                        child: Image(
                          image: AssetImage(themesList[index]),
                          fit: BoxFit.contain,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (switcher_one) {
      minimumAccuracy = 2;
    } else {
      minimumAccuracy = 9;
    }
    currentTheme = themeSwitcher(theme.value);
    var size = MediaQuery.of(context).size;
    return Container(
      decoration: currentTheme['fullBgDecoration'],
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        key: _key,
        drawer: Drawer(
          width: 300,
          child: ListView(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                child: GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  children: List.generate(
                    themesList.length,
                    (index) {
                      return GestureDetector(
                        onTap: () {
                          theme.value = index + 1;
                          settingsBox.put('themeIndex', theme.value);
                          setState(() {});
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 3),
                          child: Image(
                            image: AssetImage(themesList[index]),
                            fit: BoxFit.contain,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      content: Text(
                        'To get more themes, stay tuned to our product. We will add new themes with each update.',
                        style: TextStyle(
                            color: Colors.blue[400],
                            fontWeight: FontWeight.w400,
                            fontSize: 22),
                        textAlign: TextAlign.center,
                      ),
                      actions: [
                        OutlinedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          style: buttonStyle(
                              color: Colors.orange, borderRadius: 15),
                          child: const Text(
                            'OK',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                        ),
                      ],
                    ),
                  );
                },
                child: Container(
                  height: 50,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 35, vertical: 10),
                  color: Colors.orange,
                  child: const Center(
                      child: Text(
                    'More themes',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  )),
                ),
              ),
            ],
          ),
        ),
        endDrawer: Drawer(width: double.infinity, child: endDrawerPageWidget()),
        appBar: AppBar(
          shape: currentTheme['appBarShape'],
          backgroundColor: currentTheme['appBarBgColor'],
          leading: IconButton(
            onPressed: () {
              _key.currentState!.openDrawer();
            },
            icon: Icon(
              Icons.menu,
              size: 35,
              color: currentTheme['menuBtColor'],
            ),
          ),
          elevation: 0,
          toolbarHeight: 50,
          title: TabBar(
            labelColor: currentTheme['measureTabItemColor'],
            controller: _tabController,
            tabs: myTabs,
            indicatorWeight: 0.001,
          ),
          actions: [
            IconButton(
              color: currentTheme['settingBtColor'],
              onPressed: () => _key.currentState!.openEndDrawer(),
              icon: Icon(
                Icons.settings_outlined,
                size: 28,
                color: currentTheme['settingBtColor'],
              ),
            ),
            const SizedBox(width: 5),
          ],
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            // #calculator page
            calculatorPageWidget(size),
            // #currency page
            const ComparePage(),
            // #measure page
            measurePageWidget(size),
          ],
        ),
      ),
    );
  }
}
