import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:calculator/utils/calculator_utils.dart';
import 'package:calculator/utils/currency_utils.dart';
import 'package:calculator/utils/theme_consts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import '../utils/constants.dart';
import '../utils/currency_model.dart';
import '../utils/hive_utils.dart';
import '../utils/routes.dart';

class ComparePage extends StatefulWidget {
  const ComparePage({Key? key}) : super(key: key);

  @override
  State<ComparePage> createState() => _ComparePageState();
}

class _ComparePageState extends State<ComparePage>
    with HiveUtil, CurrencyUtils, CalculatorUtils, ThemeContants {
  final TextEditingController _editingControllerTop = TextEditingController();
  final TextEditingController _editingControllerBottom =
      TextEditingController();
  final FocusNode _topFocus = FocusNode();
  final FocusNode _bottomFocus = FocusNode();
  List<CurrencyModel> _listCurrency = [];
  CurrencyModel? topCur;
  CurrencyModel? bottomCur;
  late Map<String, dynamic> currentTheme;

  @override
  void initState() {
    super.initState();
    theme.addListener(() {
      setState(() {});
    });
    _editingControllerTop.addListener(() {
      if (_topFocus.hasFocus) {
        setState(() {
          if (_editingControllerTop.text.isNotEmpty) {
            double sum = double.parse(topCur?.rate ?? '0') /
                double.parse(bottomCur?.rate ?? '0') *
                double.parse(_editingControllerTop.text);
            _editingControllerBottom.text = sum.toStringAsFixed(2);
          } else {
            _editingControllerBottom.clear();
          }
        });
      }
    });
    _editingControllerBottom.addListener(() {
      if (_bottomFocus.hasFocus) {
        setState(() {
          if (_editingControllerBottom.text.isNotEmpty) {
            double sum = double.parse(bottomCur?.rate ?? '0') /
                double.parse(topCur?.rate ?? '0') *
                double.parse(_editingControllerBottom.text);
            _editingControllerTop.text = sum.toStringAsFixed(2);
          } else {
            _editingControllerTop.clear();
          }
        });
      }
    });
    changeTheme();
  }

  changeTheme() {
    currentTheme = themeSwitcher(theme.value);
  }

  @override
  void dispose() {
    _editingControllerTop.dispose();
    _editingControllerBottom.dispose();
    _topFocus.dispose();
    _bottomFocus.dispose();
    super.dispose();
  }

  Future<bool?> _loadData() async {
    var isLoad = await loadLocalData();
    if (isLoad) {
      try {
        var response = await get(
            Uri.parse('https://cbu.uz/uz/arkhiv-kursov-valyut/json/'));
        if (response.statusCode == 200) {
          for (final item in jsonDecode(response.body)) {
            var model = CurrencyModel.fromJson(item);
            if (model.ccy == 'USD') {
              topCur = model;
            } else if (model.ccy == 'RUB') {
              bottomCur = model;
            }
            _listCurrency.add(model);
            await saveBox<String>(dateBox, topCur?.date ?? '', key: dateKey);
            await saveBox<List<dynamic>>(currencyBox, _listCurrency,
                key: currencyListKey);
          }
          return true;
        } else {
          _showMessage('Unknown error');
        }
      } on SocketException {
        _showMessage('Connection error');
      } catch (e) {
        _showMessage(e.toString());
      }
    } else {
      return true;
    }
    return null;
  }

  Future<bool> loadLocalData() async {
    try {
      var date = await getBox<String>(dateBox, key: dateKey);
      if (date ==
          DateFormat('dd.MM.yyyy')
              .format(DateTime.now().add(const Duration(days: -1)))) {
        var list =
            await getBox<List<dynamic>>(currencyBox, key: currencyListKey) ??
                [];
        _listCurrency = List.castFrom<dynamic, CurrencyModel>(list);
        for (var model in _listCurrency) {
          if (model.ccy == 'USD') {
            topCur = model;
          } else if (model.ccy == 'RUB') {
            bottomCur = model;
          }
        }
        return false;
      } else {
        return true;
      }
    } catch (e) {
      log(e.toString());
    }
    return true;
  }

  _showMessage(String text, {bool isError = true}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: isError ? Colors.red : Colors.green[400],
        content: Text(
          text,
          style: kTextStyle(size: 15, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return ValueListenableBuilder(
      builder: (BuildContext context, value, Widget? child) {
        changeTheme();
        return Scaffold(
          backgroundColor: currentTheme['fullBgColor'],
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Column(
                children: [
                  FutureBuilder(
                      future: _listCurrency.isEmpty ? _loadData() : null,
                      builder: ((context, snapshot) {
                        if (snapshot.hasData) {
                          return Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(14),
                            margin: EdgeInsets.symmetric(
                                vertical: size.height * 0.001),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Exchange',
                                      style: kTextStyle(
                                          size: 16,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    IconButton(
                                      onPressed: () {},
                                      iconSize: 20,
                                      icon: const Icon(
                                        Icons.refresh,
                                        size: 30,
                                        color: Colors.white,
                                      ),
                                    )
                                  ],
                                ),
                                Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Column(
                                      children: [
                                        _itemExch(_editingControllerTop, topCur,
                                            _topFocus, ((value) {
                                          if (value is CurrencyModel) {
                                            setState(() => topCur = value);
                                          }
                                        }), true),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        _itemExch(_editingControllerBottom,
                                            bottomCur, _bottomFocus, ((value) {
                                          if (value is CurrencyModel) {
                                            setState(() => bottomCur = value);
                                          }
                                        }), false),
                                      ],
                                    ),
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          var model = topCur?.copyWith();
                                          topCur = bottomCur?.copyWith();
                                          bottomCur = model;
                                          _editingControllerTop.clear();
                                          _editingControllerBottom.clear();
                                        });
                                      },
                                      child: Container(
                                        height: 35,
                                        width: 35,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          color: const Color(0xff2d334d),
                                          shape: BoxShape.circle,
                                          border:
                                              Border.all(color: Colors.white12),
                                        ),
                                        child: const Icon(
                                          Icons.currency_exchange,
                                          color: Colors.white,
                                          size: 20,
                                        ),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          );
                        } else if (snapshot.hasError) {
                          return Expanded(
                            child: Center(
                              child: Text(
                                'Error',
                                style: kTextStyle(size: 18),
                              ),
                            ),
                          );
                        } else {
                          return const Expanded(
                            child: Center(
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            ),
                          );
                        }
                      })),
                  const Expanded(child: SizedBox(width: double.infinity)),
                  currencyKeyboard(size),
                ],
              ),
            ),
          ),
        );
      },
      valueListenable: theme,
    );
  }

  Widget _itemExch(TextEditingController controller, CurrencyModel? model,
      FocusNode focusNode, Function callback, bool isFocus) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.white12),
          borderRadius: BorderRadius.circular(15)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: TextField(
                  autofocus: isFocus,
                  readOnly: true,
                  controller: controller,
                  focusNode: focusNode,
                  style: kTextStyle(size: 24, fontWeight: FontWeight.bold),
                  keyboardType: TextInputType.none,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    isDense: true,
                    hintText: '0.00',
                    hintStyle:
                        kTextStyle(size: 24, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => Navigator.pushNamed(context, Routes.currencyPage,
                    arguments: {
                      'list_curreny': _listCurrency,
                      'top_cur': topCur?.ccy,
                      'bottom_cur': bottomCur?.ccy
                    }).then(((value) => callback(value))),
                child: Container(
                  padding: const EdgeInsets.all(7),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: const Color(0xff10a4d4)),
                  child: Row(children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: SvgPicture.asset(
                        'assets/flags/${model?.ccy?.substring(0, 2).toLowerCase()}.svg',
                        height: 20,
                        width: 20,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 5, right: 10),
                      child: Text(
                        model?.ccy ?? 'UNK',
                        style:
                            kTextStyle(size: 16, fontWeight: FontWeight.w600),
                      ),
                    ),
                    const Icon(
                      Icons.chevron_right,
                      color: Colors.white54,
                      size: 15,
                    )
                  ]),
                ),
              )
            ],
          ),
          Text(
            controller.text.isNotEmpty
                ? (double.parse(controller.text) * 0.05).toStringAsFixed(2)
                : '0.00',
            style:
                kTextStyle(fontWeight: FontWeight.w600, color: Colors.white54),
          )
        ],
      ),
    );
  }

  /// Currency Keyboard
  Widget currencyKeyboard(Size size) {
    return GridView.count(
      shrinkWrap: true,
      mainAxisSpacing: currentTheme['calculatorMainAxisSpacing'],
      crossAxisSpacing: currentTheme['calculatorCrossAxisSpacing'],
      physics:
          const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
      childAspectRatio: (size.width / 4) / (size.height * 0.6 / 5.4),
      crossAxisCount: 4,
      children: List.generate(
        16,
        (index) => Container(
          decoration: currentTheme['outlineBorder'],
          child: InkWell(
            splashColor: Colors.blue[200],
            onTap: () {
              currencyCalculator(currencyButtons.values.elementAt(index));
              setState(() {});
            },
            child: Container(
              decoration: currentTheme['operatorBtDecoration'],
              child: Center(
                child: Image(
                  image: AssetImage(currencyButtons.keys.elementAt(index)),
                  height: 24,
                  width: 24,
                  color: currentTheme['operatorButtonColor'],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  currencyCalculator(String command) {
    if (command == 'del') {
      if (_editingControllerTop.text.isNotEmpty) {
        _editingControllerTop.text = _editingControllerTop.text
            .substring(0, _editingControllerTop.text.length - 1);
      }
    } else if (command == 'up_down') {
      _editingControllerTop.text = _editingControllerBottom.text;
    } else if (command == 'C') {
      _editingControllerTop.text = '';
    } else if (command == 'ok') {
    } else if (command == '.') {
      if (!_editingControllerTop.text.contains('.')) {
        _editingControllerTop.text += command;
      }
    } else {
      _editingControllerTop.text += command;
    }
  }
}
