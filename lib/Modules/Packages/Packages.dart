import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';
import 'package:target/Widgets/ProgramItem.dart';
import '../../Widgets/CollectionList.dart';
import 'package:target/Models/Collection.dart';
import 'package:target/Models/Program.dart';
import 'package:target/Modules/ProgramDetails/programdetails.dart';
import 'package:target/providers/AppProvider.dart';
import 'package:target/shared/components.dart';

class Packages extends StatefulWidget {
  @override
  _PackagesState createState() => _PackagesState();
}

class _PackagesState extends State<Packages> {
  appProvider appProviderInstance;
  @override
  void initState() {
    super.initState();
    appProviderInstance =Provider.of<appProvider>(context,listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation:0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color:Color(0xff36a9e0),size: 25,),
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
                      return ProgramItem(appProviderInstance: appProviderInstance,index: index,orientation: orientation,);
                    },
                    scrollDirection: Axis.horizontal,
                    itemCount: appProviderInstance.programss.length,
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(10,10,10,10),
                  child: Text(
                      "Collections...".tr,
                      style: TextStyle(
                          color: Color(0xff36a9e0),
                          fontSize: (MediaQuery.of(context).size.height)*0.04,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                ),
                CollectionList()
              ],
            ),
          ),
        ),
      ),
    );
  }
}


