import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:provider/provider.dart';
import 'package:target/providers/AppProvider.dart';
import 'Modules/SplashScreen/Splashscreen,dart.dart';
import 'helpers/Translations.dart';


void main() async {


  WidgetsFlutterBinding.ensureInitialized();
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  final SharedPreferences prefs = await _prefs;
  print(prefs.getString("startdate")??DateTime.now().toString());
  int x =(DateTime.now()).difference(DateTime.parse(prefs.getString("startdate")??DateTime.now().toString())).inDays;
  if(x==-1){
    x=0;
  }
  runApp(
    ChangeNotifierProvider(
      create: (context) => appProvider((prefs.getString('Lang') ?? "Eng"),x,(DateTime.parse(prefs.getString("startdate")??DateTime.now().toString()))),
      child:    MyApp((prefs.getString('Lang') ?? "Eng")),
    ),
  );
}

class MyApp extends StatefulWidget {
  String language="";
  MyApp(this.language);
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
      locale: Locale(widget.language),
      fallbackLocale: Locale(widget.language),
    );
  }
}