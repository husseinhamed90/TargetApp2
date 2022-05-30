
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:target/providers/AppProvider.dart';
import 'package:target/shared/components.dart';

class CollectionItem extends StatefulWidget {
  CollectionItem({
    Key key,
    @required this.appProviderInstance, this.index
  }) : super(key: key);

  appProvider appProviderInstance;
  int index;
  @override
  State<CollectionItem> createState() => CollectionItemState();
}

class CollectionItemState extends State<CollectionItem> {
  @override
  Widget build(BuildContext context) {
    widget.appProviderInstance =Provider.of<appProvider>(context);
    return buildCollectionItem(widget.index, context,  widget.appProviderInstance);
  }
}