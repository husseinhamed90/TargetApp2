import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:target/Models/Collection.dart';
import 'package:target/Models/Meal.dart';
import 'package:target/providers/AppProvider.dart';
import '../Models/Categories.dart';

class TableCalendarWidget extends StatefulWidget {
  Collection currentcollection;
  double rowHeight=0;
  CalendarController calendarController;
  Map<DateTime, List<List<meal>>> currentEvents = {};
  Map<DateTime, Map<String,List<meal>>> mealsmap = {};
  bool selected = false;

  List<dynamic> selectedEvents = [];
  TableCalendarWidget(this.currentcollection,this.rowHeight,this.calendarController,this.currentEvents,this.mealsmap,this.selectedEvents);

  final TextEditingController noteController = TextEditingController();
  @override
  _TableCalendarWidgetState createState() => _TableCalendarWidgetState();
}

class _TableCalendarWidgetState extends State<TableCalendarWidget> {

  Map<CalendarFormat, String> formats;
  appProvider appProviderInstance;
  @override
  void initState() {
    appProviderInstance = Provider.of<appProvider>(context,listen: false);
    formats={CalendarFormat.month:"month"};
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    appProviderInstance = Provider.of<appProvider>(context);
    return ValueListenableBuilder<Map<DateTime, List<List<meal>>>>(
          valueListenable: appProviderInstance.currentEvents,
          builder: (context, value, child) {
            return TableCalendar(
              initialCalendarFormat: CalendarFormat.month,
              availableCalendarFormats: formats,
              weekendDays: [1,2],
              events: value,
              headerVisible: true,
              locale: Get.locale.toString(),
              rowHeight: widget.rowHeight,
              initialSelectedDay: DateTime.now().add(new Duration(days:2)),
              calendarController: widget.calendarController,
              builders: CalendarBuilders(
                selectedDayBuilder: (context, date, events) => Container(
                    margin: const EdgeInsets.all(4.0),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(10.0)),
                    child: Text(
                      date.day.toString(),
                      style: TextStyle(color: Colors.white),
                    )),
                todayDayBuilder: (context, date, events) => Container(
                    margin: const EdgeInsets.all(4.0),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(10.0)),
                    child: Text(
                      date.day.toString(),
                      style: TextStyle(color: Colors.white),
                    )),
              ),
              startDay: DateTime.now().add(new Duration(days:2)),
              endDay: DateTime.now().add(new Duration(days: appProviderInstance.daysoptions[widget.currentcollection.days_id].numodfays+1)),
              onDaySelected: (dayy, events, holidays) {
                appProviderInstance.changeStateOfIsHolidayValue(appProviderInstance.currentcollection.dayss.dayoff.contains(dayy.weekday));
                if(appProviderInstance.currentcollection.dayss.dayoff.contains(dayy.weekday)){
                    appProviderInstance.changeStateOfIsHolidayValue(appProviderInstance.currentcollection.dayss.dayoff.contains(dayy.weekday));
                }
                else{
                    widget.selectedEvents = events;
                    appProviderInstance.changeStateOfDateTimeValue(dayy);
                    appProviderInstance.updateSelectedEvents(events);
                    appProviderInstance.getMealsFromEvent(dayy, appProviderInstance);
                  if (value[dayy] == null) {

                  }
                  else {
                    for (int i = 0; i < value[dayy].length; i++) {
                      if (value[dayy][i].length > 0) {
                        if (value[dayy][i][0].mealcategory == Categories.Launch) {
                          appProviderInstance.chossenlaunchmeals = value[dayy][i];
                        } else if (value[dayy][i][0].mealcategory == Categories.Breakfast) {
                          appProviderInstance.choosenbreakfastmeals = value[dayy][i];
                        } else if (value[dayy][i][0].mealcategory == Categories.Dinner) {
                          appProviderInstance.choosendinnermeals = value[dayy][i];
                        } else if (value[dayy][i][0].mealcategory == Categories.Snacks) {
                          appProviderInstance.chossensnacks = value[dayy][i];
                        }
                      }
                    }
                  }
                }
              },
            );
          },
        );
  }
}