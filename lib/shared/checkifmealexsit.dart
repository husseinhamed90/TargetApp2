import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:table_calendar/table_calendar.dart';
import 'package:target/Models/Categories.dart';
import 'package:target/Models/Meal.dart';
import 'package:target/providers/AppProvider.dart';
class check extends StatefulWidget {

  appProvider xx;
  double hight;
  List<meal> mealss ;
  String menuname;
  double width;
  bool chekcedvalue;
  String addedlist;
  List<meal>choosedmeals;
  meal currentmeals;
  int index;
  Map<DateTime, List<List<meal>>> _events = {};
  Map<DateTime, Map<String,List<meal>>> mealsmap = {};
  List<dynamic> _selectedEvents = [];
  CalendarController calendarController;
  check(this.calendarController,this.xx,this.hight,this.mealss,this.menuname,this.chekcedvalue,this.addedlist,this.choosedmeals,this.currentmeals,this.index,this._events,this.mealsmap,this._selectedEvents);
  @override
  _checkState createState() => _checkState();
}

class _checkState extends State<check> {
  @override
  Widget build(BuildContext context) {
    final xx =Provider.of<appProvider>(context);
    return (!xx.ismealexist(widget.currentmeals,widget.choosedmeals))?
    Container(
        child: IconButton(
          icon: Icon(
            Icons.add,color: Colors.black,size: widget.hight*0.09,),
          onPressed: () {
            xx.addtolist(widget.mealss[widget.index],widget.addedlist,widget.calendarController.selectedDay);
            setState(() {
              widget.mealss = xx.meals;
              removeoldmeals(widget.addedlist, xx);
              if(widget.mealsmap[widget.calendarController.selectedDay]!=null){

                if(widget.mealsmap[widget.calendarController.selectedDay].containsKey(widget.addedlist)){
                  widget.mealsmap[widget.calendarController.selectedDay][widget.addedlist]=widget.choosedmeals;
                }
                else{
                  widget.mealsmap[widget.calendarController.selectedDay][widget.addedlist]=widget.choosedmeals;
                }
              }
              else{
                widget.mealsmap[widget.calendarController.selectedDay]={widget.addedlist:widget.choosedmeals};
              }
            });
            List<List<meal>> meals=[];
            widget.mealsmap[widget.calendarController.selectedDay].forEach((key, value) {meals.add(value);});
            setState(() {widget._events[widget.calendarController.selectedDay]=meals;});
          },
        ),
      ):
    Container(
        child: IconButton(
          icon: Icon(Icons
              .shopping_cart_outlined,color: Colors.black,size: widget.hight*0.09,),
          onPressed: () {
            xx.removefrommeals(
                widget.mealss[
                widget.index],widget.choosedmeals,widget.calendarController.selectedDay,widget.addedlist);
            setState(() {
              widget.mealss = xx
                  .meals;
              removeoldmeals(
                  widget.addedlist,
                  xx);

              List<List<meal>> meals=[];
              widget.mealsmap[widget.calendarController.selectedDay][widget.addedlist]=widget.choosedmeals;
              if( widget.mealsmap[widget.calendarController.selectedDay][widget.addedlist].length==0){
                setState(() {
                  widget.mealsmap[widget.calendarController.selectedDay].remove(widget.addedlist);
                });

              }
              widget.mealsmap[widget.calendarController.selectedDay].forEach((key, value) {
                meals.add(value);
              });
              setState(() {
                widget._events[widget.calendarController.selectedDay]=meals;
              });
            });
          },
        ),
      );
  }
  void removeoldmeals(String s, appProvider xx) {
    Categories categories;
    List<meal> meals;
    if (s == "Launch") {
      categories = Categories.Launch;
      meals = xx.chossenlaunchmeals;
    } else if (s == "BreakFast") {
      categories = Categories.Breakfast;
      meals = xx.choosenbreakfastmeals;
    } else if (s == "Dinner") {
      categories = Categories.Dinner;
      meals = xx.choosendinnermeals;
    } else {
      categories = Categories.Snacks;
      meals = xx.chossensnacks;
    }
    if (widget._events[widget.calendarController.selectedDay] != null ) {
      if (widget._selectedEvents.length < 3) {
        if(widget.mealsmap[widget.calendarController.selectedDay].containsKey(s)){
          widget._events[widget.calendarController.selectedDay] = [meals];
        }
        else{
          widget._events[widget.calendarController.selectedDay].add(meals);
        }
      }
    } else {
      widget._events[widget.calendarController.selectedDay] = [meals];
    }
    setState(() {
      widget._selectedEvents = widget._events[widget.calendarController.selectedDay];
    });
    xx.events = widget._events;
    xx.selectedEvents = widget._selectedEvents;
  }
}
