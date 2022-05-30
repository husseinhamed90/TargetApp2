import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:target/Models/Meal.dart';
import 'package:target/providers/AppProvider.dart';
import 'package:target/shared/components.dart';

import '../Models/Collection.dart';
import '../Modules/AllMeals/ViewAllMeals.dart';

class BottomPart extends StatefulWidget {
  Collection currentcollection;
  BoxConstraints constraints;
  CalendarController calendarController = CalendarController();
  final TextEditingController noteController = TextEditingController();
  Map<DateTime, List<List<meal>>> currentEvents = {};
  Map<DateTime, Map<String,List<meal>>> mealsmap = {};
  List<dynamic> selectedEvents = [];
  BottomPart(this.currentcollection,this.constraints,this.calendarController,this.selectedEvents,this.mealsmap,this.currentEvents){
  }
  @override
  bottomPart_State createState() => bottomPart_State();
}

class bottomPart_State extends State<BottomPart> {

  appProvider appProviderInstance;
  @override
  void initState() {
    appProviderInstance = Provider.of<appProvider>(context,listen: false);
  }
  @override
  Widget build(BuildContext context) {
    double hight=310;
    print("bottomPart");
    appProviderInstance = Provider.of<appProvider>(context);
    double width=MediaQuery.of(context).size.width*0.2;

    return !appProviderInstance.isHoliday? buildmealslists(hight, width, appProviderInstance,widget.constraints):Container();
  }
  Container buildmealslists(double hight,double width ,appProvider xx ,BoxConstraints constraints){

    return Container(
        height: constraints.maxHeight*0.7-MediaQuery.of(context).size.height*0.1-(constraints.maxHeight*0.5)/9*3,
        //height:MediaQuery.of(context).size.height*0.7,
        color: Color(0xfff5f5f5),
        child: ((appProviderInstance.dateTime != null)
            ? ListView(
          children: [
            buildListOfMeals(widget,xx, hight, xx.launchmeals, "Launch Meals".tr, width, widget.currentcollection.launch,"Launch Meals".tr,xx.chossenlaunchmeals,() {
              Navigator.push(context, MaterialPageRoute(builder: (_) {return Result("Launch Meals".tr,
                  widget.currentcollection,widget.calendarController,widget.currentEvents,widget.selectedEvents,widget.mealsmap, xx.launchmeals,xx.chossenlaunchmeals);}));

            },false),
            buildListOfMeals(widget,xx, hight, xx.breakfastmeals, "BreakFast Meals".tr, width, widget.currentcollection.breakfast,"BreakFast Meals".tr,xx.choosenbreakfastmeals,() {
              Navigator.push(context, MaterialPageRoute(builder: (_) {return Result("BreakFast Meals".tr
                  ,widget.currentcollection,widget.calendarController,widget.currentEvents,widget.selectedEvents,widget.mealsmap, xx.breakfastmeals,xx.choosenbreakfastmeals);}));

            },false),
            buildListOfMeals(widget,xx, hight, xx.dinnermeals, "Dinner Meals".tr, width, widget.currentcollection.dinner,"Dinner Meals".tr,xx.choosendinnermeals,() {
              Navigator.push(context, MaterialPageRoute(builder: (_) {return Result("Dinner Meals".tr
                  ,widget.currentcollection,widget.calendarController,widget.currentEvents,widget.selectedEvents,widget.mealsmap,xx.dinnermeals,xx.choosendinnermeals);}));

            },false),
            buildListOfMeals(widget,xx, hight, xx.snacks, "Snacks Meals".tr, width, widget.currentcollection.snacks,"Snacks Meals".tr,xx.chossensnacks,() {
              Navigator.push(context, MaterialPageRoute(builder: (_) {return Result("Snacks Meals".tr,widget.currentcollection,widget.calendarController,widget.currentEvents,widget.selectedEvents,widget.mealsmap,xx.snacks,xx.chossensnacks);}));
            },false)
          ],
        ): Container())
    );
  }
}
