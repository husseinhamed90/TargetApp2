import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:target/Modules/Packages/Packages.dart';
import 'package:target/providers/AppProvider.dart';
import '../../Widgets/ChangeLang.dart';
import 'package:target/shared/components.dart';


import '../login/loginpage.dart';
class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  appProvider appProviderInstance;
  @override
  void initState() {
     appProviderInstance =Provider.of<appProvider>(context,listen: false);
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body:  SafeArea(
        child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/bg.jpg'),
               fit: BoxFit.fill,
                colorFilter: ColorFilter.mode(Colors.black26, BlendMode.color),
              )
          ),
          padding: EdgeInsets.all(5),
          child: Column(
            //scrollDirection: Axis.vertical,
            children: [
              SizedBox(height: 15.0),
              Align(
                  alignment: Alignment.topRight,
                  child: ChangeLang()
              ),
              SizedBox(height: 15.0),
              Container(
                height: 200.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.transparent,
                  image: DecorationImage(
                      image: AssetImage('assets/logo.jpg'),
                  ),
                ),
              ),
              SizedBox(height: 15.0),
              DrawButtonOnHomePage(text:"New Subscription",onTapFun: (){
                appProviderInstance.getMeals();
                appProviderInstance.resetUser();
                Navigator.push(context, MaterialPageRoute(builder: (_) {return Packages();}));
              }),
              SizedBox(height: 15.0),
              DrawButtonOnHomePage(text: "Sign in",onTapFun: (){
                appProviderInstance.getMeals();
                Navigator.push(context, MaterialPageRoute(builder: (_) {return loginpage();}));
              }),
            ],
          ),
        ),
      ),
    );
  }

}
