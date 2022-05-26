
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
    final x =Provider.of<appProvider>(context);
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
      // body: Container(
      //   decoration: BoxDecoration(
      //       image: DecorationImage(
      //         image: AssetImage('assets/bg.jpg'),
      //         fit: BoxFit.fill,
      //       )
      //   ),
      //   margin: EdgeInsets.fromLTRB(0.0, 0.0, 0,0),
      //   child: ListView(
      //     scrollDirection: Axis.vertical,
      //     children: [
      //       Card(
      //         elevation: 5.0,
      //         margin: EdgeInsets.fromLTRB(15,100,15,15),
      //         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      //         child: Container(
      //           decoration: BoxDecoration(
      //             color: Colors.white,
      //             borderRadius: BorderRadius.circular(20.0),
      //           ),
      //           padding: EdgeInsets.all(5.0),
      //           child: ListTile(
      //             title: Text(
      //               'Account Data'.tr,
      //               style: TextStyle(
      //                   color: Color(0xff36a9e0),
      //                   fontSize: 20.0,
      //                   fontWeight: FontWeight.bold
      //               ),
      //             ),
      //
      //             subtitle: Column(
      //               children: [
      //                 Align(
      //                   alignment: Alignment.centerLeft,
      //                   child: Row(
      //
      //                     children: [
      //                       Text("Full Name: ".tr,
      //                         style: TextStyle(
      //                             color: Colors.grey,
      //                             fontSize: 18.0,
      //                             fontWeight: FontWeight.bold
      //                         ),),
      //                       Text("${x.user.name}",
      //                         style: TextStyle(
      //                             color: Colors.grey,
      //                             fontSize: 18.0,
      //                             fontWeight: FontWeight.bold
      //                         ),),
      //                     ],
      //                   ),
      //                 ),
      //                 Align(
      //                   alignment: Alignment.centerLeft,
      //                   child: Row(
      //                     children: [
      //                       Text("Email: ".tr,
      //
      //                         softWrap: false,
      //                         style: TextStyle(
      //                             color: Colors.grey,
      //                             fontSize: 18.0,
      //                             fontWeight: FontWeight.bold
      //                         ),),
      //                       Expanded(
      //                         child: Text("${x.user.email}",
      //                           maxLines: 1,
      //                           style: TextStyle(
      //                               color: Colors.grey,
      //                               fontSize: 18.0,
      //                               fontWeight: FontWeight.bold
      //                           ),),
      //                       ),
      //                     ],
      //                   ),
      //                 ),
      //                 Align(
      //                   alignment: Alignment.centerLeft,
      //                   child: Row(
      //                     children: [
      //                       Text("BirthDate: ".tr,
      //                         style: TextStyle(
      //                             color: Colors.grey,
      //                             fontSize: 18.0,
      //                             fontWeight: FontWeight.bold
      //                         ),),
      //                       Expanded(
      //                         child: Text("${x.user.birthdate.toString().substring(0, 10)}",
      //                           maxLines: 1,
      //                           style: TextStyle(
      //                               color: Colors.grey,
      //                               fontSize: 18.0,
      //                               fontWeight: FontWeight.bold
      //                           ),),
      //                       ),
      //                     ],
      //                   ),
      //                 ),
      //                 Align(
      //                   alignment: Alignment.centerLeft,
      //                   child: Row(
      //                     children: [
      //                       Text("Mobile Number: ".tr,
      //                         style: TextStyle(
      //                             color: Colors.grey,
      //                             fontSize: 18.0,
      //                             fontWeight: FontWeight.bold
      //                         ),),
      //                       Expanded(
      //                         child: Text("${x.user.mobilenumber}",
      //                           maxLines: 1,
      //                           style: TextStyle(
      //                               color: Colors.grey,
      //                               fontSize: 18.0,
      //                               fontWeight: FontWeight.bold
      //                           ),),
      //                       ),
      //                     ],
      //                   ),
      //                 ),
      //               ],
      //             ),
      //           ),
      //         ),
      //       ),
      //
      //       Card(
      //         elevation: 5.0,
      //         margin: EdgeInsets.fromLTRB(15,25,15,50),
      //         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      //         child: Container(
      //           decoration: BoxDecoration(
      //             color: Colors.white,
      //             borderRadius: BorderRadius.circular(20.0),
      //           ),
      //           padding: EdgeInsets.all(5.0),
      //           child: ListTile(
      //             title: Text(
      //               'Collection Details'.tr,
      //               style: TextStyle(
      //                   color: Color(0xff36a9e0),
      //                   fontSize: 20.0,
      //                   fontWeight: FontWeight.bold
      //               ),
      //             ),
      //             subtitle: Column(
      //               children: [
      //                 Align(
      //                   alignment: Alignment.centerLeft,
      //                   child: Row(
      //
      //                     children: [
      //                       Text("Target Name: ".tr,
      //                         style: TextStyle(
      //                             color: Colors.grey,
      //                             fontSize: 18.0,
      //                             fontWeight: FontWeight.bold
      //                         ),),
      //                       Text("${x.choosedprogram}",
      //                         style: TextStyle(
      //                             color: Colors.grey,
      //                             fontSize: 18.0,
      //                             fontWeight: FontWeight.bold
      //                         ),),
      //                     ],
      //                   ),
      //                 ),
      //                 Align(
      //                   alignment: Alignment.centerLeft,
      //                   child: Row(
      //                     children: [
      //                       Text("Collection Name : ".tr,
      //                         style: TextStyle(
      //                             color: Colors.grey,
      //                             fontSize: 18.0,
      //                             fontWeight: FontWeight.bold
      //                         ),),
      //                       Text("${x.currentcollection.title}",
      //                         style: TextStyle(
      //                             color: Colors.grey,
      //                             fontSize: 18.0,
      //                             fontWeight: FontWeight.bold
      //                         ),),
      //                     ],
      //                   ),
      //                 ),
      //                 Align(
      //                   alignment: Alignment.centerLeft,
      //                   child: Row(
      //                     children: [
      //                       Text("Days: ".tr,
      //                         style: TextStyle(
      //                             color: Colors.grey,
      //                             fontSize: 18.0,
      //                             fontWeight: FontWeight.bold
      //                         ),),
      //                       Text("${x.daysoptions[x.currentcollection.days_id].numodfays}",
      //                         style: TextStyle(
      //                             color: Colors.grey,
      //                             fontSize: 18.0,
      //                             fontWeight: FontWeight.bold
      //                         ),),
      //                       Text(" Days".tr,
      //                         style: TextStyle(
      //                             color: Colors.grey,
      //                             fontSize: 18.0,
      //                             fontWeight: FontWeight.bold
      //                         ),),
      //                     ],
      //                   ),
      //                 ),
      //                 Align(
      //                   alignment: Alignment.centerLeft,
      //                   child: Row(
      //                     children: [
      //                       Text("Fee: ".tr,
      //                         style: TextStyle(
      //                             color: Colors.grey,
      //                             fontSize: 18.0,
      //                             fontWeight: FontWeight.bold
      //                         ),),
      //                       Text("${x.currentcollection.price} KWD",
      //                         style: TextStyle(
      //                             color: Colors.grey,
      //                             fontSize: 18.0,
      //                             fontWeight: FontWeight.bold
      //                         ),),
      //                     ],
      //                   ),
      //                 ),
      //                 Align(
      //                   alignment: Alignment.centerLeft,
      //                   child: Row(
      //                     children: [
      //                       Text("Collection Meals:- ".tr,
      //                         style: TextStyle(
      //                             color: Colors.grey,
      //                             fontSize: 16.0,
      //                             fontWeight: FontWeight.bold
      //                         ),),
      //                       Padding(
      //                         padding: const EdgeInsets.only(left: 20),
      //                         child: Row(
      //                           children: [
      //
      //                             x.currentcollection.launch?Text("Launch / ".tr,
      //                               style: TextStyle(
      //                                   color: Colors.grey,
      //                                   fontSize: 16.0,
      //                                   fontWeight: FontWeight.bold
      //                               ),
      //                             ):Container(),
      //                             x.currentcollection.dinner?Text("Dinner / ".tr,
      //                               style: TextStyle(
      //                                   color: Colors.grey,
      //                                   fontSize: 16.0,
      //                                   fontWeight: FontWeight.bold
      //                               ),
      //                             ):Container(),
      //                             x.currentcollection.breakfast?Text("Break Fast / ".tr,
      //                               style: TextStyle(
      //                                   color: Colors.grey,
      //                                   fontSize: 16.0,
      //                                   fontWeight: FontWeight.bold
      //                               ),
      //                             ):Container(),
      //                             x.currentcollection.snacks?Text("Snacks".tr,
      //                               style: TextStyle(
      //                                   color: Colors.grey,
      //                                   fontSize: 16.0,
      //                                   fontWeight: FontWeight.bold
      //                               ),
      //                             ):Container(),
      //                           ],
      //                         ),
      //                       ),
      //                     ],
      //                   ),
      //                 ),
      //
      //               ],
      //             ),
      //           ),
      //         ),
      //       ),
      //       Column(
      //         children: [
      //
      //           InkWell(
      //             onTap: () {
      //
      //               x.startdate=DateTime.now().add(new Duration(days:2));
      //               x.enddate=DateTime.now().add(new Duration(days:x.currentcollection.dayss.numodfays+1));
      //               Choosedmeals choosedmeals=Choosedmeals(breakfast_meal: x.allchoosenbreakfastmeals,dinner_meal: x.allchoosendinnermeals,launch_meal: x.allchossenlaunchmeals,Snacksmeals: x.allchossensnacks);
      //               Subscription s =Subscription.withoutid(x.user,x.currentcollection,choosedmeals,true,x.startdate,x.enddate,DateTime.now());
      //               x.updateSubscription(s);
      //             },
      //             child: Container(
      //
      //               height: 40,
      //               width: MediaQuery.of(context).size.width*0.5,
      //               decoration: BoxDecoration(
      //                   color: Color(0xff36a9e0),
      //                   borderRadius: BorderRadius.all(Radius.circular(20))
      //               ),
      //               child: Center(
      //                 child: AutoSizeText(
      //                   "Proceed To Payment".tr,
      //                   style: TextStyle(color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.bold),
      //                 ),
      //               ),
      //             ),
      //           ),
      //         ],
      //       ),
      //     ],
      //   ),
      // ),
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
                              getRow(constraints, "Full Name: ", "${x.user.name}",x),
                              getRow(constraints, "Email: ", "${x.user.email}",x),
                              getRow(constraints, "BirthDate: ", "${x.user.birthdate.toString().substring(0, 10)}",x),
                              getRow(constraints, "Mobile Number: ", "${x.user.mobilenumber}",x),
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
                              getRow(constraints, "Target Name: ", "${x.choosedprogram}",x),
                              getRow(constraints, "Collection Name : ", "${x.currentcollection.title}",x),
                              getRow(constraints, "Days: ", "${x.currentcollection.dayss.numodfays}",x),
                              getRow(constraints, "Fee: ", "${x.currentcollection.price} KWD",x),
                              getRow(constraints, "Collection Meals:- ", "",x),
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
                                    x.currentcollection.snacks?Text("Snacks / ".tr,
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
                  x.startdate=DateTime.now().add(new Duration(days:2));
                  x.enddate=DateTime.now().add(new Duration(days:x.currentcollection.dayss.numodfays+1));
                  x.resetmeals();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => selectmeals(x.currentcollection),
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
                  x.startdate=DateTime.now().add(new Duration(days:2));
                  x.enddate=DateTime.now().add(new Duration(days:x.daysoptions[x.currentcollection.days_id].numodfays+1));
                  x.resetmeals();
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