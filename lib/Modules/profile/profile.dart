import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:get/get.dart';
import 'package:target/Modules/CalenderWithMeals/selectmeals.dart';
import 'package:target/Modules/editprofile/editprofileinfo.dart';
import 'package:target/providers/AppProvider.dart';
import 'package:target/shared/ChangeLang.dart';




class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    final x =Provider.of<appProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        title: Text(
          'Profile'.tr,
          style: TextStyle(
              color: Color(0xff36a9e0),
              fontSize: 20.0,
              fontWeight: FontWeight.bold
          ),
        ),
        actions: [
          Container(margin: EdgeInsets.all(10.0), child: ChangeLang())
        ],
        iconTheme: IconThemeData(color: Color(0xff36a9e0), size: 20.0),
      ),
      body: Container(

        margin: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/bgg.jpg'),
              fit: BoxFit.fill,
            )
        ),
        child: Column(
          children: [
            Card(
              elevation: 5.0,
              margin: EdgeInsets.all(15.0),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                padding: EdgeInsets.all(5.0),
                child: ListTile(
                  title: Text(
                    'Current Program',
                    style: TextStyle(
                        color: Color(0xff36a9e0),
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  subtitle:  Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Row(

                          children: [
                            Text("Target Name: ".tr,
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold
                              ),),
                            Text("${x.choosedprogram}",
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold
                              ),),
                          ],
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Row(
                          children: [
                            Text("Collection Name : ".tr,
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold
                              ),),
                            Text("${x.currentcollection.title}",
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold
                              ),),
                          ],
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Row(
                          children: [
                            Text("Days: ".tr,
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold
                              ),),
                            Text("${x.daysoptions[x.currentcollection.days_id].numodfays}",
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold
                              ),),
                            Text(" Days".tr,
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold
                              ),),
                          ],
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Row(
                          children: [
                            Text("Fee: ".tr,
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold
                              ),),
                            Text("${x.currentcollection.price} KWD",
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold
                              ),),
                          ],
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text("Collection Meals:- ".tr,
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold
                          ),),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Row(
                          children: [

                            x.currentcollection.launch?Text("Launch / ".tr,
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold
                              ),
                            ):Container(),
                            x.currentcollection.dinner?Text("Dinner / ".tr,
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold
                              ),
                            ):Container(),
                            x.currentcollection.breakfast?Text("Break Fast / ".tr,
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold
                              ),
                            ):Container(),
                            x.currentcollection.snacks?Text("Snacks".tr,
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold
                              ),
                            ):Container(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) {return selectmeals(x.currentcollection);}));
              },
              child: Container(

                height: 40,
                width: MediaQuery.of(context).size.width*0.3,
                decoration: BoxDecoration(
                    color: Color(0xff36a9e0),
                    borderRadius: BorderRadius.all(Radius.circular(20))
                ),
                child: Center(
                  child: AutoSizeText(
                    "Edit Meals".tr,
                    style: TextStyle(color: Colors.white, fontSize:(x.language=="en")?15.0:12, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10,),
            InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) {return editprifile();}));
              },
              child: Container(

                height: 40,
                width: MediaQuery.of(context).size.width*0.3,
                decoration: BoxDecoration(
                    color: Color(0xff36a9e0),
                    borderRadius: BorderRadius.all(Radius.circular(20))
                ),
                child: Center(
                  child: AutoSizeText(
                    "Edit Account".tr,
                    style: TextStyle(color: Colors.white, fontSize: (x.language=="en")?15.0:12, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}