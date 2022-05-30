
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:target/providers/AppProvider.dart';
import 'package:target/shared/components.dart';

class ProgramItem extends StatefulWidget {
  ProgramItem({
    Key key,
    @required this.appProviderInstance,this.index,this.orientation
  }) : super(key: key);

  appProvider appProviderInstance;
  int index;
  Orientation orientation;

  @override
  State<ProgramItem> createState() => _ProgramItemState();
}

class _ProgramItemState extends State<ProgramItem> {
  @override
  Widget build(BuildContext context) {
    widget.appProviderInstance =Provider.of<appProvider>(context);
    return buildProgramItem(context, widget.index, widget.orientation,widget.appProviderInstance);
  }
}