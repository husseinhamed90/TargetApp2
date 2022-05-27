import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';
import 'package:target/Models/Collection.dart';
import 'package:target/Models/Program.dart';
import 'package:target/Modules/ProgramDetails/programdetails.dart';
import 'package:target/providers/AppProvider.dart';

class Packages extends StatefulWidget {
  @override
  _PackagesState createState() => _PackagesState();
}

class _PackagesState extends State<Packages> {
  Collection currentCollection;
  appProvider appProviderInstance;
  program currentProgram;
  @override
  void initState() {
    super.initState();
    appProviderInstance =Provider.of<appProvider>(context,listen: false);
    currentCollection=appProviderInstance.currentcollection;
    currentProgram=appProviderInstance.cuurentprogram;
  }
  TextStyle textStyle =TextStyle(
      color: Colors.grey,
      fontSize: 15.0,
      fontWeight: FontWeight.bold
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation:0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color:Color(0xff36a9e0),size: 30,),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) =>Container(
          height: constraints.maxHeight,
          child: OrientationBuilder(
            builder: (context, orientation) => ListView(
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(10,10,10,10),
                  height:(orientation==Orientation.portrait)? (MediaQuery.of(context).size.height)*0.31:(MediaQuery.of(context).size.height)*0.36,
                  child: ListView.builder(
                    itemBuilder:(context, index) {
                      return Card(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                        child: GestureDetector(
                          child: Container(
                            width: MediaQuery.of(context).size.width/1.5,
                            decoration: BoxDecoration(
                              // color: Colors.white,
                              color: (currentProgram!=null)?(currentProgram.name==appProviderInstance.programss[index].name)?Colors.black12:Colors.white:Colors.white,
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: Column(
                              children: [
                                Container(
                                  height:(orientation==Orientation.portrait)? ((MediaQuery.of(context).size.height)*0.31)*0.6-10:((MediaQuery.of(context).size.height)*0.36)*0.6-10,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20.0),
                                    image: DecorationImage(
                                        image: NetworkImage(appProviderInstance.programss[index].url),
                                        fit : BoxFit.fitWidth
                                    ),
                                  ),
                                ),
                                Container(
                                  child: ListTile(
                                    title: Text(
                                      appProviderInstance.programss[index].name,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: (MediaQuery.of(context).size.height)*0.025,
                                          fontWeight: FontWeight.bold
                                      ),
                                    ),
                                    subtitle: Text(
                                      'See Collections'.tr,
                                      style: TextStyle(
                                          color: Color(0xff36a9e0),
                                          fontSize: (MediaQuery.of(context).size.height)*0.02,
                                          fontWeight: FontWeight.bold
                                      ),
                                    ),
                                    trailing: Icon(Icons.arrow_downward, color: Color(0xff36a9e0), size: (MediaQuery.of(context).size.height)*0.03),
                                    onTap: () {
                                      setState(() {
                                        currentProgram=appProviderInstance.programss[index];
                                        appProviderInstance.cuurentprogram=appProviderInstance.programss[index];
                                        appProviderInstance.choosedprogram=appProviderInstance.programss[index].name;
                                      });
                                    },
                                  ),
                                  height: ( (MediaQuery.of(context).size.height)*0.31)*0.4,
                                ),
                                //checkListTile()
                              ],
                            ),
                          ),
                          onTap: () {
                            setState(() {
                              currentProgram=appProviderInstance.programss[index];
                              appProviderInstance.cuurentprogram=appProviderInstance.programss[index];
                              appProviderInstance.choosedprogram=appProviderInstance.programss[index].name;
                            });
                          },
                        ),
                      );
                    },
                    scrollDirection: Axis.horizontal,
                    itemCount: appProviderInstance.programss.length,
                  ),
                ),
                ListTile(
                  title: Text(
                    "Collections...".tr,
                    style: TextStyle(
                        color: Color(0xff36a9e0),
                        fontSize: (MediaQuery.of(context).size.height)*0.04,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),
                (appProviderInstance.cuurentprogram!=null)?Container(
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder:(context, index) {
                      return InkWell(
                        onTap: () {
                          setState(() {
                            currentCollection=appProviderInstance.cuurentprogram.collections[index];
                          });
                          Navigator.push(context, MaterialPageRoute(builder: (context) => programdetails(appProviderInstance.cuurentprogram.collections[index],appProviderInstance.choosedprogram,),));
                        },

                        child: Card(
                          margin: EdgeInsets.all(10.0),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                          child: Container(
                            width: MediaQuery.of(context).size.width/1.5,
                            decoration: BoxDecoration(
                              //  color: Colors.white,
                              color: (appProviderInstance.cuurentprogram.collections[index]==currentCollection)?Colors.black12:Colors.white,
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: Column(
                              children: [
                                Container(
                                  height: 170.0,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20.0),
                                    image: DecorationImage(
                                        image: NetworkImage(appProviderInstance.cuurentprogram.collections[index].image),
                                        fit : BoxFit.fill
                                    ),
                                  ),
                                ),
                                ListTile(
                                  title: Row(
                                    children: [
                                      Text(
                                        "Collection Name : ".tr,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.bold
                                        ),
                                      ),
                                      Text(
                                        appProviderInstance.cuurentprogram.collections[index].title,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.bold
                                        ),
                                      ),

                                    ],
                                  ),
                                  subtitle: Column(
                                    children: [
                                      Container(

                                        child: Row(
                                          children: [
                                            Text("Collection Description : ".tr,
                                              style: textStyle
                                            ),
                                            Text("${appProviderInstance.cuurentprogram.description}",
                                              style: textStyle
                                            ),
                                          ],
                                        ),
                                        alignment: Alignment.centerLeft,
                                      ),
                                      Row(
                                        children: [
                                          appProviderInstance.cuurentprogram.collections[index].launch?Text("Launch / ".tr,
                                            style: textStyle
                                          ):Container(),
                                          appProviderInstance.cuurentprogram.collections[index].dinner?Text("Dinner / ".tr,
                                            style: textStyle
                                          ):Container(),
                                          appProviderInstance.cuurentprogram.collections[index].breakfast?Text("Break Fast / ".tr,
                                            style: textStyle
                                          ):Container(),
                                          appProviderInstance.cuurentprogram.collections[index].snacks?Text("Snacks".tr,
                                            style: textStyle
                                          ):Container(),
                                        ],
                                      ),
                                      Container(
                                        alignment: Alignment.centerLeft,
                                        child: Row(
                                          children: [
                                            Text("Number Of Days : ".tr,
                                              style: textStyle
                                            ),
                                            Text("${appProviderInstance.cuurentprogram.collections[index].dayss.numodfays}",
                                              style: textStyle
                                            ),
                                            Text(" Days".tr,
                                              style: textStyle
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                  trailing: Text(
                                    '${appProviderInstance.cuurentprogram.collections[index].price.toString()} KWD',
                                    style: TextStyle(
                                        color: Color(0xff36a9e0),
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),
                                  onTap: (){
                                    setState(() {
                                      currentCollection=appProviderInstance.cuurentprogram.collections[index];
                                    });
                                  },
                                )
                                //checkListTile()
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    scrollDirection: Axis.vertical,
                    itemCount: appProviderInstance.cuurentprogram.collections.length,
                  ),
                ):Container(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}