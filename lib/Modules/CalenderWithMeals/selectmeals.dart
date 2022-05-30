import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:get/get.dart';
import 'package:target/Models/Categories.dart';
import 'package:target/Models/Collection.dart';
import 'package:target/Models/Meal.dart';
import 'package:target/Modules/AllMeals/ViewAllMeals.dart';
import '../../Widgets/TableCalendarWidget.dart';
import '../../Widgets/bottomPartInSelectMealsPage.dart';
import 'package:target/providers/AppProvider.dart';
import 'package:target/shared/components.dart';

import '../CreateAccount/CreatenewAccount.dart';

class selectmeals extends StatefulWidget {
  Collection currentcollection;
  selectmeals(this.currentcollection);
  Map<DateTime, List<List<meal>>> currentEvents = {};
  Map<DateTime, Map<String,List<meal>>> mealsmap = {};
  bool selected = false;
  CalendarController calendarController = CalendarController();
  List<dynamic> selectedEvents = [];
  @override
  _selectmealsState createState() => _selectmealsState();
}

class _selectmealsState extends State<selectmeals> {

  appProvider appProviderInstance;

  @override
  void initState() {
    appProviderInstance = Provider.of<appProvider>(context,listen: false);
    widget.currentEvents=appProviderInstance.currentEvents.value;
    widget.selectedEvents=appProviderInstance.selectedEvents.value;
    widget.mealsmap=appProviderInstance.mealsmap.value;
    appProviderInstance.changeStateOfDateTimeValue(null);

  }
  @override
  Widget build(BuildContext context) {

    appProviderInstance = Provider.of<appProvider>(context,listen: false);
    BoxConstraints boxConstraints;
    return Scaffold(
        appBar: AppBar(
          elevation:0,
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.blue,size: 30,),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: LayoutBuilder(
            builder: (context, constraints) {
              boxConstraints=constraints;
              return Container(
                height:constraints.maxHeight*0.9,
                child: Column(
                  children: [
                   Expanded(child: LayoutBuilder(builder:(context, constraintsss) =>  TableCalendarWidget(widget.currentcollection,(constraintsss.maxHeight)/7,widget.calendarController,widget.currentEvents,widget.mealsmap,widget.selectedEvents))),
                   Expanded(child: BottomPart(widget.currentcollection, constraints,widget.calendarController,widget.selectedEvents,widget.mealsmap,widget.currentEvents))
                  ],
                ),
              );
            }
        ),
        bottomSheet: GestureDetector(
                  child: LayoutBuilder(
                    builder: (context, constraints) => Container(
                      height:boxConstraints.maxHeight*0.1,
                      width: constraints.maxWidth,
                      alignment: Alignment.bottomCenter,
                      decoration: BoxDecoration(
                          color: Color(0xff36a9e0),
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10))
                      ),
                      padding: EdgeInsets.only(bottom: 10.0),
                      child: FlatButton(

                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                          child: Text(
                            'Continue'.tr,
                            style: TextStyle(color: Colors.white, fontSize: 30.0, fontWeight: FontWeight.bold),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          }
                      ),
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  }
              )
    );
  }
}