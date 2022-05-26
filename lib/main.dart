//import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:provider/provider.dart'as p;
import 'package:target/providers/AppProvider.dart';

import 'Modules/SplashScreen/Splashscreen,dart.dart';
import 'helpers/Translations.dart';


void main() async {


  WidgetsFlutterBinding.ensureInitialized();
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final SharedPreferences prefs = await _prefs;
  print(prefs.getString("startdate")??DateTime.now().toString());
  int x =(DateTime.now()).difference(DateTime.parse(prefs.getString("startdate")??DateTime.now().toString())).inDays;
  if(x==-1){
    x=0;
  }
  runApp(
    p.ChangeNotifierProvider(
      create: (context) => appProvider((prefs.getString('Lang') ?? "Eng"),x,(DateTime.parse(prefs.getString("startdate")??DateTime.now().toString()))),
      child:    MyApp((prefs.getString('Lang') ?? "Eng")),
    ),
  );
}

class MyApp extends StatefulWidget {
  String s="";
  MyApp(this.s);
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      translations: translation(),
      theme: ThemeData(
        textTheme: GoogleFonts.tajawalTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      home: SplachScreen(),

      localizationsDelegates: translator.delegates,
      locale: Locale(widget.s),
      fallbackLocale: Locale(widget.s),
    );
  }
}