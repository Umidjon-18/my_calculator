import 'package:calculator/pages/intro_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'utils/currency_model.dart';
import 'utils/routes.dart';

void main() async{
  await Hive.initFlutter();
  Hive.registerAdapter<CurrencyModel>(CurrencyModelAdapter());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.interTextTheme(),
      ),
      onGenerateRoute: (settings) => Routes.generateRoute(settings),
    );
  }
}
