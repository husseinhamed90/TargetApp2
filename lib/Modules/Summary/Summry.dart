
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:get/get.dart';
import 'package:target/Modules/CalenderWithMeals/selectmeals.dart';
import 'package:target/Modules/RemainingDays/remainingdays.dart';
import 'package:target/providers/AppProvider.dart';
import 'package:target/shared/ChangeLang.dart';

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
        iconTheme: IconThemeData(color: Color(0xff36a9e0), size: 20.0),
      ),
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/bg.jpg'),
                fit: BoxFit.fill,
              )
          ),
          margin: EdgeInsets.all(10.0),
          child: ListView(
            scrollDirection: Axis.vertical,
            children: [
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
                        Container(
                          height: (MediaQuery.of(context).size.height*0.2)*0.1,
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  'Account Data'.tr,
                                  style: TextStyle(
                                      color: Color(0xff36a9e0),
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                              ),
                              Icon( Icons.local_offer, color: Color(0xff36a9e0), size: 25.0),
                            ],
                          ),
                        ),
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
                        Container(
                          height: (MediaQuery.of(context).size.height*0.3)*0.1,
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  'Collection Details'.tr,
                                  style: TextStyle(
                                      color: Color(0xff36a9e0),
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                              ),
                              Icon( Icons.local_offer, color: Color(0xff36a9e0), size: 25.0),
                            ],
                          ),
                        ),
                        SizedBox(height: 10,),
                        Expanded(
                          child: LayoutBuilder(builder: (context, constraints) => Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              getRow(constraints, "Target Name: ", "${appProvider_Instance.choosedprogram}",appProvider_Instance),
                              getRow(constraints, "Collection Name : ", "${appProvider_Instance.currentcollection.title}",appProvider_Instance),
                              getRow(constraints, "Days: ", "${appProvider_Instance.currentcollection.dayss.numodfays}",appProvider_Instance),
                              getRow(constraints, "Fee: ", "${appProvider_Instance.currentcollection.price} KWD",appProvider_Instance),
                              getRow(constraints, "Collection Meals:- ", "",appProvider_Instance),
                              Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: Row(
                                  children: [

                                    appProvider_Instance.currentcollection.launch?Text("Launch / ".tr,
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold
                                      ),
                                    ):Container(),
                                    appProvider_Instance.currentcollection.dinner?Text("Dinner / ".tr,
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold
                                      ),
                                    ):Container(),
                                    appProvider_Instance.currentcollection.breakfast?Text("Break Fast / ".tr,
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold
                                      ),
                                    ):Container(),
                                    appProvider_Instance.currentcollection.snacks?Text("Snacks / ".tr,
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
      bottomSheet:  FittedBox(
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.only(bottom: 5,top: 5),
          child: Column(
            children: [
              InkWell(
                onTap: () {
                  appProvider_Instance.startdate=DateTime.now().add(new Duration(days:2));
                  appProvider_Instance.enddate=DateTime.now().add(new Duration(days:appProvider_Instance.currentcollection.dayss.numodfays+1));
                  //appProvider_Instance.resetmeals();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => selectmeals(appProvider_Instance.currentcollection),
                      ));
                },
                child: Container(

                  height: 40,
                  width: MediaQuery.of(context).size.width*0.5,
                  decoration: BoxDecoration(
                      color: Color(0xff36a9e0),
                      borderRadius: BorderRadius.all(Radius.circular(20))
                  ),
                  child: Center(
                    child: AutoSizeText(
                      "Edit Meals".tr,
                      style: TextStyle(color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10,),
              InkWell(
                onTap: () {
                  appProvider_Instance.startdate=DateTime.now().add(new Duration(days:2));
                  appProvider_Instance.enddate=DateTime.now().add(new Duration(days:appProvider_Instance.daysoptions[appProvider_Instance.currentcollection.days_id].numodfays+1));
                  appProvider_Instance.resetmeals();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => remainingdays(),
                      ));
                },
                child: Container(

                  height: 40,
                  width: MediaQuery.of(context).size.width*0.5,
                  decoration: BoxDecoration(
                      color: Color(0xff36a9e0),
                      borderRadius: BorderRadius.all(Radius.circular(20))
                  ),
                  child: Center(
                    child: AutoSizeText(
                      "Proceed To Payment".tr,
                      style: TextStyle(color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getRow(BoxConstraints constraints,String leftPart,String rightPart,appProvider x){
    return Expanded(
      child: Row(
        children: [

          Text(leftPart.tr,
            style: TextStyle(
                color: Colors.grey,
                fontSize: 18.0,
                fontWeight: FontWeight.bold
            ),),
          SizedBox(width: 2,),
          Expanded(
            child: AutoSizeText(rightPart,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  color: Colors.grey,
                  //fontSize: 18.0,
                  fontWeight: FontWeight.bold
              ),),
          ),
        ],
      ),
    );
  }

}