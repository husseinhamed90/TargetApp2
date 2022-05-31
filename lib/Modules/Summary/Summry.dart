import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:get/get.dart';
import 'package:target/Modules/CalenderWithMeals/selectmeals.dart';
import 'package:target/Modules/RemainingDays/remainingdays.dart';
import 'package:target/providers/AppProvider.dart';
import '../../Widgets/ChangeLang.dart';
import 'package:target/shared/components.dart';

class Summry extends StatefulWidget {
  @override
  _SummryState createState() => _SummryState();
}
class _SummryState extends State<Summry> {
  @override
  Widget build(BuildContext context) {
    final appProvider_Instance =Provider.of<appProvider>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color:Color(0xff36a9e0),size: 25,),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Package & Account Information'.tr,
          style: TextStyle(
              color: Color(0xff36a9e0),
              fontSize: 20.0,
              fontWeight: FontWeight.bold
          ),
        ),
        actions: [
          Container(margin: EdgeInsets.all(10.0), child: ChangeLang())
        ],
      ),
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/bg.jpg'),
                fit: BoxFit.fill,
              )
          ),
          child: ListView(
            scrollDirection: Axis.vertical,
            children: [
              SizedBox(height: 10,),
              Card(
                elevation: 5.0,
                margin: EdgeInsets.all(15.0),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: MediaQuery.of(context).size.height*0.2,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    padding: EdgeInsets.all(5.0),
                    child:  Column(
                      children: [
                        buildHeader(context,'Account Data'),
                        SizedBox(height: 10,),
                        Expanded(
                          child: LayoutBuilder(builder: (context, constraints) => Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              getRow(constraints, "Full Name: ", "${appProvider_Instance.user.name}",appProvider_Instance),
                              getRow(constraints, "Email: ", "${appProvider_Instance.user.email}",appProvider_Instance),
                              getRow(constraints, "BirthDate: ", "${appProvider_Instance.user.birthdate.toString().substring(0, 10)}",appProvider_Instance),
                              getRow(constraints, "Mobile Number: ", "${appProvider_Instance.user.mobilenumber}",appProvider_Instance),
                            ],
                          ),),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10,),
              Card(
                elevation: 5.0,
                margin: EdgeInsets.all(15.0),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: MediaQuery.of(context).size.height*0.3,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    padding: EdgeInsets.all(5.0),
                    child:  Column(
                      children: [
                        buildHeader(context,'Collection Details'),
                        SizedBox(height: 10,),
                        Expanded(
                          child: LayoutBuilder(builder: (context, constraints) => Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              getRow(constraints, "Target Name: ", "${appProvider_Instance.cuurentprogram.name}",appProvider_Instance),
                              getRow(constraints, "Collection Name : ", "${appProvider_Instance.currentcollection.title}",appProvider_Instance),
                              getRow(constraints, "Days: ", "${appProvider_Instance.currentcollection.dayss.numodfays}",appProvider_Instance),
                              getRow(constraints, "Fee: ", "${appProvider_Instance.currentcollection.price} KWD",appProvider_Instance),
                              getRow(constraints, "Collection Meals:- ", "",appProvider_Instance),
                              Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: Row(
                                  children: [
                                    buildTypeOfMealIfExistInCollection(appProvider_Instance,"Launch / ",appProvider_Instance.currentcollection.launch),
                                    buildTypeOfMealIfExistInCollection(appProvider_Instance,"Dinner / ",appProvider_Instance.currentcollection.dinner),
                                    buildTypeOfMealIfExistInCollection(appProvider_Instance,"Break Fast / ",appProvider_Instance.currentcollection.breakfast),
                                    buildTypeOfMealIfExistInCollection(appProvider_Instance,"Snacks / ",appProvider_Instance.currentcollection.snacks),
                                  ],
                                ),
                              ),
                            ],
                          ),),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomSheet:  Container(
        height: 100,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.only(bottom: 5,top: 5),
        child: Column(
          children: [
            buildButtonInSummaryPage(appProvider_Instance, context, selectmeals(appProvider_Instance.currentcollection),"Edit Meals"),
            SizedBox(height: 10,),
            buildButtonInSummaryPage(appProvider_Instance, context,remainingdays(),"Proceed To Payment"),

          ],
        ),
      ),
    );
  }
}