import 'package:flutter/material.dart';

mixin MeasureUtils {
  List<Tab> measureTabs = [
    const Tab(text: 'DISTANCE'),
    const Tab(text: 'AREA'),
    const Tab(text: 'MASS'),
    const Tab(text: 'VOLUME'),
    const Tab(text: 'TEMPERATURE'),
    const Tab(text: 'FUEL'),
    const Tab(text: 'COOKING'),
  ];

  

  Map<String, String> measureButtons = {
    'assets/images/main_images/seven.png': '7',
    'assets/images/main_images/eight.png': '8',
    'assets/images/main_images/nine.png': '9',
    'assets/images/main_images/backspace.png': 'del',
    'assets/images/main_images/four.png': '4',
    'assets/images/main_images/five.png': '5',
    'assets/images/main_images/six.png': '6',
    'assets/images/main_images/c.png': 'C',
    'assets/images/main_images/one.png': '1',
    'assets/images/main_images/two.png': '2',
    'assets/images/main_images/three.png': '3',
    'assets/images/main_images/ok.png': 'ok',
    'assets/images/main_images/vergul.png': '.',
    'assets/images/main_images/zero.png': '0',
    'assets/images/main_images/double_zero.png': '00',
    'assets/images/main_images/arrow_down.png': 'down',
  };

  static const Map<String, String> distance = {
    'meter': 'm',
    'kilometer': 'km',
    'millimeter': 'mm',
    'centimeter': 'cm',
    'mile': 'mi',
    'yard': 'yd',
    'foot': 'ft',
    'inch': 'in',
    'nautical mile': 'nmi',
  };

static const Map<String, dynamic> distanceAmounts = {
    'meter': 1,
    'kilometer': 1000,
    'millimeter': 0.001,
    'centimeter': 0.001,
    'mile': 1609.344,
    'yard': 0.9144,
    'foot': 0.3048,
    'inch': 0.0254,
    'nautical mile': 1852,
  };

  static const Map<String, String> area = {
    'square meter': 'm²',
    'square millimeter': 'mm²',
    'square centimeter': 'cm²',
    'square inch': 'in²',
    'square foot': 'ft²',
    'square yard': 'yd²',
    'hectare': 'ha',
    'square kilometer': 'km²',
    'arce': 'ac',
    'square mile': 'mi²',
  };

    static const Map<String, dynamic> areaAmounts = {
    'square meter': 1,
    'square millimeter': 0.00001,
    'square centimeter': 0.0001,
    'square inch': 0.00064516,
    'square foot': 0.0929030436,
    'square yard': 0.8361273924,
    'hectare': 10000,
    'square kilometer': 1000000,
    'arce': 4048.5829959514,
    'square mile': 2590673.5751295337,
  };

  static const Map<String, String> mass = {
    'kilogram': 'kg',
    'milligram': 'mg',
    'gram': 'g',
    'ton': 't',
    'long ton': 'ton(UK)',
    'short ton': 'ton(US)',
    'pound': 'lb',
    'ounce': 'ounce',
    'stone': 'st',
    'carat': 'ct',
  };

  static const Map<String, dynamic> massAmounts = {
    'kilogram': 1,
    'milligram': 0.000001,
    'gram': 0.001,
    'ton': 1000,
    'long ton': 1016.2601,
    'short ton': 909.0909,
    'pound': 0.453592,
    'ounce': 0.0283494,
    'stone': 6.3694,
    'carat': 0.0002,
  };


  static const Map<String, String> volume = {
    'cubic meter': 'm³',
    'cubic millimeter': 'mm³',
    'cubic centimeter': 'cm³',
    'cubic decimeter': 'dm³',
    'milliliter': 'ml(cc)',
    'liter': 'L',
    'cubic foot': 'ft³',
    'cubic inch': 'in³',
    '(US)gallon': 'gal(US)',
    '(US)quart': 'qt lqd(US)',
    '(US)pint': 'qt lqd(US)',
    '(US)ounce': 'oz(US)',
    '(US)cup': 'cup(US)',
    '(US)tablespoon': 'tbsp(US)',
    '(US)teaspoon': 'tsp(US)',
    '(UK)gallon': 'gal(UK)',
    '(UK)quart': 'qt lqd(UK)',
    '(UK)pint': 'qt lqd(UK)',
    '(UK)ounce': 'oz(UK)',
    '(UK)cup': 'cup(UK)',
    '(UK)tablespoon': 'tbsp(UK)',
    '(UK)teaspoon': 'tsp(UK)',
    'dram': 'dr',
    'barrel': 'bbl',
    'cord': 'cord',
    'gill': 'gill',
  };

  static const Map<String, dynamic> volumeAmounts = {
    'cubic meter': 1,
    'cubic millimeter': 0.000000001,
    'cubic centimeter': 0.000001,
    'cubic decimeter': 0.001,
    'milliliter': 0.000001,
    'liter': 0.001,
    'cubic foot': 0.0283167999,
    'cubic inch': 0.000016387,
    '(US)gallon': 0.0037854,
    '(US)quart': 0.00094635,
    '(US)pint': 0.0004731,
    '(US)ounce': 0.0000295735,
    '(US)cup': 0.0002365882,
    '(US)tablespoon': 0.00001478,
    '(US)teaspoon': 0.0000049289,
    '(UK)gallon': 0.0045460927,
    '(UK)quart': 0.0011365,
    '(UK)pint': 0.0005683,
    '(UK)ounce': 0.0000284131,
    '(UK)cup': 0.000284131,
    '(UK)tablespoon': 0.000017758,
    '(UK)teaspoon': 0.000005919,
    'dram': 0.0000036967,
    'barrel': 0.1589872891,
    'cord': 3.6231884058,
    'gill': 0.00011829,
  };

  static const Map<String, String> temperature = {
    'celcius': 'C',
    'kelvin': 'K',
    'fahrenheit': 'F'
  };

  static const Map<String, double> temperatureAmounts = {
    'celcius': 1,
    'kelvin': -272,
    'fahrenheit': -17.2222222,
  };

  static const Map<String, String> fuel = {
    'liters/100 kilometer': 'L/100km',
    'gallons(UK)/100 miles': 'gal(UK)/100 miles',
    'gallons(US)/100 miles': 'gal(US)/100 miles',
    'kilometer/liter': 'km/L',
    '(UK)miles per gallon': 'MPG(UK)',
    '(US)miles per gallon': 'MPG(US)'
  };

    static const Map<String, dynamic> fuelAmounts = {
    'liters/100 kilometer': 1,
    'gallons(UK)/100 miles': 2.83,
    'gallons(US)/100 miles': 2.35,
    'kilometer/liter': 0.01,
    '(UK)miles per gallon': 0.00354,
    '(US)miles per gallon': 0.00425
  };

  static const Map<String, String> cooking = {
    'milliliter': 'mL(cc)',
    'gallon': 'gal(US)',
    'quart': 'qt lqd(US)',
    'pint': 'pt lqd(US)',
    'ounce': 'fl oz(US)',
    'cup': 'cup(US)',
    'tablespoon': 'tbsp(US)',
    'teaspoon': 'tsp(US)',
    'gallon(UK)': 'gal(UK)',
    'quart(UK)': 'qt lqd(UK)',
    'pint(UK)': 'pt lqd(UK)',
    'ounce(UK)': 'fl oz(UK)',
    'cup(UK)': 'cup(UK)',
    'tablespoon(UK)': 'tbsp(UK)',
    'teaspoon(UK)': 'tsp(UK)'
  };

    static const Map<String, dynamic> cookingAmounts = {
    'milliliter': 1,
    'gallon': 4545.5,
    'quart': 1136.4,
    'pint': 568,
    'ounce': 28.5,
    'cup': 284,
    'tablespoon': 17.8,
    'teaspoon': 5.91,
    'gallon(UK)': 4545.5,
    'quart(UK)': 1136.4,
    'pint(UK)': 568.2,
    'ounce(UK)': 28.4,
    'cup(UK)': 284.1,
    'tablespoon(UK)': 17.76,
    'teaspoon(UK)': 5.91,
  };

  String measureAmount = '1';

  measureCalculator(String amount) {
    if (amount == 'del') {
      measureAmount = measureAmount.substring(0, measureAmount.length - 1);
    } else if (amount == 'C') {
      measureAmount = '';
    } else if (amount == '1') {
      if (measureAmount != '1') {
        measureAmount += amount;
      }
    } else if (amount == '.') {
      if (!measureAmount.contains('.')) {
        measureAmount = int.parse(measureAmount).toString()+amount;
      }
    } else {
      if (measureAmount == '1') {
        measureAmount = '';
      }
      measureAmount += amount;
    }
    if (measureAmount.isEmpty) {
      measureAmount = '1';
    }
  }
}
