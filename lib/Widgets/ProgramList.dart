import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:target/Modules/Packages/Packages.dart';
import 'package:target/Widgets/ProgramItem.dart';

import '../providers/AppProvider.dart';

class ProgramList extends StatefulWidget {
  @override
  _ProgramListState createState() => _ProgramListState();
}

class _ProgramListState extends State<ProgramList> {
  @override
  Widget build(BuildContext context) {
    appProvider appProviderInstance =Provider.of<appProvider>(context);
    return OrientationBuilder(
      builder: (context, orientation) => Container(
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
    );
  }
}
