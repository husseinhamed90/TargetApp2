import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:get/get.dart';
import 'package:target/Modules/homescreen/Homepage.dart';

class SplachScreen extends StatefulWidget {
  @override
  _SplachScreenState createState() => _SplachScreenState();
}

class _SplachScreenState extends State<SplachScreen> {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(

      seconds: 3,
      navigateAfterSeconds: new MyHomePage(),
      title: new Text(
        'Welcome to Target App'.tr,
        style: new TextStyle(fontSize: 20.0),
      ),
      photoSize: MediaQuery.of(context).size.height*0.3,
      image: new Image.asset('assets/logo.jpg'),
      backgroundColor: Colors.white,
      loaderColor: Colors.blueAccent,
    );
  }
}
