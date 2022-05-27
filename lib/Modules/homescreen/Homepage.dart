import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:geolocator/geolocator.dart';
import 'package:target/Modules/Packages/Packages.dart';
import 'package:target/providers/AppProvider.dart';
import 'package:target/shared/ChangeLang.dart';


import '../login/loginpage.dart';
class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isSwitched = false;
  String lat="";
  String lang="";
  @override
  Widget build(BuildContext context) {
    final appProviderInstance =Provider.of<appProvider>(context);
    isSwitched= (appProviderInstance.language=='Ar')?true:!false;

    return Scaffold(

      body:  Container(
        decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/bg.jpg'),
             fit: BoxFit.fill,
              colorFilter: ColorFilter.mode(Colors.black26, BlendMode.color),
            )
        ),
        margin: EdgeInsets.all(3.0),
        child: ListView(
          scrollDirection: Axis.vertical,
          children: [
            Align(
                alignment: Alignment.topRight,
                child: ChangeLang()
            ),
            Container(
              margin: EdgeInsets.all(10.0),
              height: 200.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.transparent,
                image: DecorationImage(
                    image: AssetImage('assets/logo.jpg'),
                    // fit: BoxFit.fill
                ),
              ),
            ),
            Column(
              children: [
                InkWell(
                  onTap: () {
                    appProviderInstance.getmeals();
                    appProviderInstance.resetUser();
                    print(appProviderInstance.user);
                    Navigator.push(context, MaterialPageRoute(builder: (_) {return Packages();}));
                  },
                  child: Container(

                    height: 40,
                    width: 140,
                    decoration: BoxDecoration(
                        color: Color(0xff36a9e0),
                        borderRadius: BorderRadius.all(Radius.circular(20))
                    ),
                    child: Center(
                      child: AutoSizeText(
                        "New Subscription".tr,
                        style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 15.0),
            Column(
              children: [
                InkWell(
                  onTap: () {
                    appProviderInstance.getmeals();
                    Navigator.push(context, MaterialPageRoute(builder: (_) {return loginpage();}));
                  },
                  child: Container(

                    height: 40,
                    width: 140,
                    decoration: BoxDecoration(
                        color: Color(0xff36a9e0),
                        borderRadius: BorderRadius.all(Radius.circular(20))
                    ),
                    child: Center(
                      child: AutoSizeText(
                        "Sign in".tr,
                        style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //getcurrentlocation();
  }
  void getcurrentlocation() async{
    final geoposition =await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    setState(() {
      lat="${geoposition.latitude}";
      lang="${geoposition.longitude}";
      print(lat);
      print(lang);
    });
  }
}
