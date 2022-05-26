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
  Collection c;
  program p;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final x =Provider.of<appProvider>(context,listen: false);
    c=x.currentcollection;
    p=x.cuurentprogram;
  }

  @override
  Widget build(BuildContext context) {
    final x =Provider.of<appProvider>(context);
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
                              color: (p!=null)?(p.name==x.programss[index].name)?Colors.black12:Colors.white:Colors.white,
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: Column(
                              children: [
                                Container(
                                  height:(orientation==Orientation.portrait)? ((MediaQuery.of(context).size.height)*0.31)*0.6-10:((MediaQuery.of(context).size.height)*0.36)*0.6-10,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20.0),
                                    image: DecorationImage(
                                        image: NetworkImage(x.programss[index].url),
                                        fit : BoxFit.fitWidth
                                    ),
                                  ),
                                ),
                                Container(

                                  child: ListTile(

                                    title: Text(
                                      x.programss[index].name,
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
                                        p=x.programss[index];
                                        x.cuurentprogram=x.programss[index];
                                        x.choosedprogram=x.programss[index].name;
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
                              p=x.programss[index];
                              x.cuurentprogram=x.programss[index];
                              x.choosedprogram=x.programss[index].name;

                            });

                          },
                        ),
                      );
                    },
                    scrollDirection: Axis.horizontal,
                    itemCount: x.programss.length,
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
                (x.cuurentprogram!=null)?Container(
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder:(context, index) {
                      return InkWell(
                        onTap: () {
                          setState(() {
                            c=x.cuurentprogram.collections[index];
                          });
                          Navigator.push(context, MaterialPageRoute(builder: (context) => programdetails(x.cuurentprogram.collections[index],x.choosedprogram,),));
                        },

                        child: Card(
                          margin: EdgeInsets.all(10.0),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                          child: Container(
                            width: MediaQuery.of(context).size.width/1.5,
                            decoration: BoxDecoration(
                              //  color: Colors.white,
                              color: (x.cuurentprogram.collections[index]==c)?Colors.black12:Colors.white,
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: Column(
                              children: [
                                Container(
                                  height: 170.0,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20.0),
                                    image: DecorationImage(
                                        image: NetworkImage(x.cuurentprogram.collections[index].image),
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
                                        x.cuurentprogram.collections[index].title,
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
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 15.0,
                                                  fontWeight: FontWeight.bold
                                              ),
                                            ),
                                            Text("${x.cuurentprogram.description}",
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 15.0,
                                                  fontWeight: FontWeight.bold
                                              ),
                                            ),
                                          ],
                                        ),
                                        alignment: Alignment.centerLeft,
                                      ),
                                      Row(
                                        children: [
                                          x.cuurentprogram.collections[index].launch?Text("Launch / ".tr,
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 15.0,
                                                fontWeight: FontWeight.bold
                                            ),
                                          ):Container(),
                                          x.cuurentprogram.collections[index].dinner?Text("Dinner / ".tr,
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 15.0,
                                                fontWeight: FontWeight.bold
                                            ),
                                          ):Container(),
                                          x.cuurentprogram.collections[index].breakfast?Text("Break Fast / ".tr,
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 15.0,
                                                fontWeight: FontWeight.bold
                                            ),
                                          ):Container(),
                                          x.cuurentprogram.collections[index].snacks?Text("Snacks".tr,
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 15.0,
                                                fontWeight: FontWeight.bold
                                            ),
                                          ):Container(),
                                        ],
                                      ),
                                      Container(
                                        alignment: Alignment.centerLeft,
                                        child: Row(
                                          children: [
                                            Text("Number Of Days : ".tr,
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 15.0,
                                                  fontWeight: FontWeight.bold
                                              ),
                                            ),

                                            Text("${x.cuurentprogram.collections[index].dayss.numodfays}",
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 15.0,
                                                  fontWeight: FontWeight.bold
                                              ),
                                            ),
                                            Text(" Days".tr,
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 15.0,
                                                  fontWeight: FontWeight.bold
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                  trailing: Text(
                                    '${x.cuurentprogram.collections[index].price.toString()} KWD',
                                    style: TextStyle(
                                        color: Color(0xff36a9e0),
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),
                                  onTap: (){
                                    setState(() {
                                      c=x.cuurentprogram.collections[index];
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
                    itemCount: x.cuurentprogram.collections.length,
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