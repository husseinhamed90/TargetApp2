
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:target/shared/components.dart';
import '../../providers/AppProvider.dart';
import '../../Models/Collection.dart';
import '../../Models/Meal.dart';




class Result extends StatefulWidget {

  String title;
  Collection currentcollection;
  CalendarController calendarController;
  Map<DateTime, List<List<meal>>> currentEvents = {};
  Map<DateTime, Map<String,List<meal>>> mealsmap = {};
  List<dynamic> selectedEvents = [];
  List<meal>listOfMeals,lastChosenMeals;
  final TextEditingController noteController = TextEditingController();
  Result(this.title,this.currentcollection,this.calendarController,this.currentEvents,this.selectedEvents,this.mealsmap,this.listOfMeals,this.lastChosenMeals);

  @override
  _ResultState createState() => _ResultState();
}

class _ResultState extends State<Result> {


  bool selected = false;


  @override
  Widget build(BuildContext context) {
    final xx = Provider.of<appProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Color(0xff36a9e0), size: 20.0),
      ),
      body: SafeArea(
        child: Container(
            height: MediaQuery.of(context).size.height,
            child: buildListOfMeals(widget,xx, MediaQuery.of(context).size.height, widget.listOfMeals, widget.title, MediaQuery.of(context).size.width, widget.currentcollection.snacks,widget.title,widget.lastChosenMeals,(){},true)
        ),
      )
    );
  }
}