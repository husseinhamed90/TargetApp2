import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:target/providers/AppProvider.dart';
import 'package:target/shared/components.dart';

class CollectionList extends StatefulWidget {
  @override
  _CollectionListState createState() => _CollectionListState();
}

class _CollectionListState extends State<CollectionList> {
  @override
  Widget build(BuildContext context) {
    appProvider appProviderInstance =Provider.of<appProvider>(context);

    return (appProviderInstance.cuurentprogram!=null)?Container(
      child: ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder:(context, index) {
          return buildCollectionItem(index, context,appProviderInstance);
        },
        scrollDirection: Axis.vertical,
        itemCount: appProviderInstance.cuurentprogram.collections.length,
      ),
    ):Container();
  }
}
