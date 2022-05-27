import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:get/get.dart';
import 'package:target/Models/Categories.dart';
import 'package:target/Models/Collection.dart';
import 'package:target/Models/Meal.dart';
import 'package:target/Modules/AllMeals/ViewAllMeals.dart';
import 'package:target/providers/AppProvider.dart';

import '../CreateAccount/CreatenewAccount.dart';

class selectmeals extends StatefulWidget {
  Collection currentcollection;
  selectmeals(this.currentcollection);
  @override
  _selectmealsState createState() => _selectmealsState();
}

class _selectmealsState extends State<selectmeals> {
  Map<DateTime, List<List<meal>>> _events = {};
  Map<DateTime, Map<String,List<meal>>> mealsmap = {};
  List<dynamic> _selectedEvents = [];
  var dateTime;
  bool isHoliday=false;

  @override
  void initState() {
    final xx = Provider.of<appProvider>(context,listen: false);
    _events=xx.events;
    _selectedEvents=xx.selectedEvents;
    mealsmap=xx.mealsmap;
  }
  CalendarController calendarController = CalendarController();
  final TextEditingController noteController = TextEditingController();
  Map<CalendarFormat, String> formats={CalendarFormat.month:"month"};

  bool selected = false;
  int count=0;
  double h=0;
  @override
  Widget build(BuildContext context) {
    double hight=310;

    double width=MediaQuery.of(context).size.width*0.2;
    final xx = Provider.of<appProvider>(context);
    return Scaffold(
        appBar: AppBar(
          elevation:0,
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.blue,size: hight*0.1,),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: LayoutBuilder(

          builder: (context, constraints) {
            h=(constraints.maxHeight*0.5)/9;
           return Container(
              height: constraints.maxHeight,
              child: ListView(
                children: [
                  TableCalendar(
                    initialCalendarFormat: CalendarFormat.month,
                    availableCalendarFormats: formats,
                    weekendDays: [1,2],
                    events: _events,
                    headerVisible: true,
                    locale: Get.locale.toString(),
                    rowHeight: h,
                    initialSelectedDay: DateTime.now().add(new Duration(days:2)),
                    calendarController: calendarController,
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
                    endDay: DateTime.now().add(new Duration(days: xx.daysoptions[widget.currentcollection.days_id].numodfays+1)),
                    onDaySelected: (dayy, events, holidays) {
                      isHoliday=xx.currentcollection.dayss.dayoff.contains(dayy.weekday);
                      if(xx.currentcollection.dayss.dayoff.contains(dayy.weekday)){

                        setState(() {
                          isHoliday=xx.currentcollection.dayss.dayoff.contains(dayy.weekday);
                        });
                      }
                      else{
                        setState(() {
                          dateTime = dayy;
                          _selectedEvents = events;
                        });
                        getmealsfromevent(dayy, xx);
                        if (_events[dayy] == null) {

                        }
                        else {
                          for (int i = 0; i < _events[dayy].length; i++) {
                            if (_events[dayy][i].length > 0) {
                              if (_events[dayy][i][0].mealcategory ==
                                  Categories.Launch) {
                                xx.chossenlaunchmeals = _events[dayy][i];
                              } else if (_events[dayy][i][0].mealcategory ==
                                  Categories.Breakfast) {
                                xx.choosenbreakfastmeals = _events[dayy][i];
                              } else if (_events[dayy][i][0].mealcategory ==
                                  Categories.Dinner) {
                                xx.choosendinnermeals = _events[dayy][i];
                              } else if (_events[dayy][i][0].mealcategory ==
                                  Categories.Snacks) {
                                xx.chossensnacks = _events[dayy][i];
                              }
                            }
                          }
                        }
                      }

                    },
                  ),
                  !isHoliday? buildmealslists(hight, width, xx,constraints):Container(),

                ],
              ),
            );
          }
        ),
        bottomSheet: GestureDetector(
          child: LayoutBuilder(
            builder: (context, constraints) => Container(

              color: Color(0xff36a9e0),
              height:MediaQuery.of(context).size.height*0.1,
              width: constraints.maxWidth,
              //width: MediaQuery.of(context).size.width,
              alignment: Alignment.bottomCenter,
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
              //Navigator.push(context, MaterialPageRoute(builder: (context) => createnewaccount()));
          }
        )
    );
  }
  Container buildmealslists(double hight,double width ,appProvider xx ,BoxConstraints constraints){
    return Container(
      height: constraints.maxHeight*0.7-MediaQuery.of(context).size.height*0.1-h*3,
      //height:MediaQuery.of(context).size.height*0.7,
        color: Color(0xfff5f5f5),
        child: ((dateTime != null)
            ? ListView(
          children: [
            getcolum(xx, hight, xx.launchmeals, "Launch Meals".tr, width, widget.currentcollection.launch,"Launch".tr,xx.chossenlaunchmeals),
            getcolum(xx, hight, xx.breakfastmeals, "BreakFast Meals".tr, width, widget.currentcollection.breakfast,"BreakFast".tr,xx.choosenbreakfastmeals),
            getcolum(xx, hight, xx.dinnermeals, "Dinner Meals".tr, width, widget.currentcollection.dinner,"Dinner".tr,xx.choosendinnermeals),
            getcolum(xx, hight, xx.snacks, "Snacks Meals".tr, width, widget.currentcollection.snacks,"Snacks".tr,xx.chossensnacks)
          ],
        ): Container()
        )
    );
  }
  void getmealsfromevent(DateTime dayy, appProvider xx) {
    if (_events[dayy] == null) {
      xx.resetmeals();
    }
    else {
      for (int i = 0; i < _events[dayy].length; i++) {
        if (_events[dayy][i].length > 0) {
          if (_events[dayy][i][0].mealcategory == Categories.Launch) {
            xx.chossenlaunchmeals = _events[dayy][i];
          } else if (_events[dayy][i][0].mealcategory == Categories.Breakfast) {
            xx.choosenbreakfastmeals = _events[dayy][i];
          } else if (_events[dayy][i][0].mealcategory == Categories.Dinner) {
            xx.choosendinnermeals = _events[dayy][i];
          } else if (_events[dayy][i][0].mealcategory == Categories.Snacks) {
            xx.chossensnacks = _events[dayy][i];
          }
        }
      }
    }
  }
  void removeoldmeals(String s, appProvider xx) {
    Categories categories;
    List<meal> meals;
    if (s == "Launch".tr) {
      categories = Categories.Launch;
      meals = xx.chossenlaunchmeals;
    } else if (s == "BreakFast".tr) {
      categories = Categories.Breakfast;
      meals = xx.choosenbreakfastmeals;
    } else if (s == "Dinner".tr) {
      categories = Categories.Dinner;
      meals = xx.choosendinnermeals;
    } else if(s=="Snacks".tr){
      categories = Categories.Snacks;
      meals = xx.chossensnacks;
    }
    if (_events[calendarController.selectedDay] != null ) {
      if (_selectedEvents.length < 3) {
        if(mealsmap[calendarController.selectedDay].containsKey(s)){
          _events[calendarController.selectedDay] = [meals];
        }
        else{
          _events[calendarController.selectedDay].add(meals);
        }
      }
    } else {
      _events[calendarController.selectedDay] = [meals];
    }

    setState(() {
      _selectedEvents = _events[calendarController.selectedDay];
    });
    xx.events = _events;
    xx.selectedEvents = _selectedEvents;
  }
  Column getcolum(appProvider xx,double hight, List<meal> meals ,String menuname,double width,bool chekcedvalue,String addedlist,List<meal>choosedmeals){
    List<meal> mealss =meals;
    return  (chekcedvalue)
        ? Column(
      children: [
        headLineItem(menuname),
        Container(
            color: Color(0xfff5f5f5),
            height: hight,
            child: ListView.builder(
              itemBuilder: (context, index) {
                return  Card(
                  margin: EdgeInsets.all(10.0),
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    width: MediaQuery.of(context).size.width/1.5,
                    child: Column(
                      children: [
                        Container(
                          height: 170,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            image: DecorationImage(
                                image: NetworkImage(mealss[index].url),
                                fit : BoxFit.fill
                            ),
                          ),
                        ),
                        Container(
                          height: 50,
                          child: ListTile(
                            title: AutoSizeText(
                              mealss[index].name,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: hight*0.08,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                            subtitle: AutoSizeText(
                              mealss[index].description,
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                            trailing:(selected==false)
                                ? TextButton(
                              child: Text("Add Note".tr),
                              onPressed: () {
                                setState(() {
                                  showModalBottomSheet(
                                      context: context,
                                      backgroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0))),
                                      builder: (BuildContext context){
                                        return Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Align(
                                                alignment: Alignment.topCenter,
                                                child: AutoSizeText(
                                                  'Add Note ?'.tr,
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 18.0,
                                                      fontWeight: FontWeight.bold
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: TextField(
                                                    decoration: InputDecoration(
                                                        border: OutlineInputBorder(
                                                            borderRadius: BorderRadius.circular(15.0),
                                                            borderSide: BorderSide(color: Colors.black, width: 0.5)
                                                        ),
                                                        focusedBorder: OutlineInputBorder(
                                                            borderRadius: BorderRadius.circular(15.0),
                                                            borderSide: BorderSide(color: Colors.black, width: 0.5)
                                                        ),
                                                        enabledBorder: OutlineInputBorder(
                                                            borderRadius: BorderRadius.circular(15.0),
                                                            borderSide: BorderSide(color: Colors.black, width: 0.5)
                                                        ),
                                                        labelText: 'Add your Notes'.tr
                                                    ),
                                                    textInputAction: TextInputAction.done,
                                                    keyboardType: TextInputType.multiline,
                                                    maxLength: 125,
                                                    controller: noteController
                                                ),
                                              ),
                                              FlatButton(
                                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                                                  child: AutoSizeText(
                                                    "Confirm".tr,
                                                    style: TextStyle(color: Color(0xff36a9e0), fontSize: 20.0, fontWeight: FontWeight.bold),
                                                  ),
                                                  color: Colors.white,
                                                  onPressed: () {
                                                    setState(() {
                                                      selected = !selected;
                                                    });
                                                    Navigator.pop(context);
                                                  }
                                              ),

                                            ],
                                          ),
                                        );
                                      }
                                  );
                                });
                              },
                            ): TextButton(
                              child: Text("Remove Note".tr),
                              onPressed: () {
                                setState(() {
                                  selected=false;
                                });
                              },
                            ),
                          ),
                        ),
                        Spacer(),
                        if (!xx.ismealexist(mealss[index],choosedmeals))
                          IconButton(
                            icon: Icon(
                              Icons.add,color: Colors.black,size: 30,),
                            onPressed: () {
                              xx.addtolist(mealss[index],addedlist,calendarController.selectedDay);
                              setState(() {
                                mealss = xx.meals;
                                removeoldmeals(addedlist, xx);
                                if(mealsmap[calendarController.selectedDay]!=null){

                                  if(mealsmap[calendarController.selectedDay].containsKey(addedlist)){
                                    mealsmap[calendarController.selectedDay][addedlist]=choosedmeals;
                                  }
                                  else{
                                    mealsmap[calendarController.selectedDay][addedlist]=choosedmeals;
                                  }
                                }
                                else{
                                  mealsmap[calendarController.selectedDay]={addedlist:choosedmeals};
                                }
                              });
                              List<List<meal>> meals=[];
                              mealsmap[calendarController.selectedDay].forEach((key, value) {
                                meals.add(value);
                              });
                              setState(() {
                                _events[calendarController.selectedDay]=meals;
                                xx.events=_events;
                                xx.selectedEvents=_selectedEvents;
                                xx.mealsmap=mealsmap;
                              });

                            },
                          )
                        else
                          IconButton(
                            icon: Icon(Icons
                                .shopping_cart_outlined,color: Colors.black,size: 30,),
                            onPressed: () {
                              xx.removefrommeals(mealss[index],choosedmeals,calendarController.selectedDay,addedlist);

                              setState(() {
                                mealss = xx
                                    .meals;
                                removeoldmeals(
                                    addedlist,
                                    xx);

                                List<List<meal>> meals=[];
                                mealsmap[calendarController.selectedDay][addedlist]=choosedmeals;
                                if( mealsmap[calendarController.selectedDay][addedlist].length==0){
                                  setState(() {
                                    mealsmap[calendarController.selectedDay].remove(addedlist);
                                  });

                                }
                                mealsmap[calendarController.selectedDay].forEach((key, value) {
                                  meals.add(value);
                                });

                                setState(() {
                                  _events[calendarController.selectedDay]=meals;
                                  if( _events[calendarController.selectedDay].isEmpty){
                                    _events.remove(calendarController.selectedDay);

                                  }
                                  xx.events=_events;
                                  xx.selectedEvents=_selectedEvents;
                                  xx.mealsmap=mealsmap;
                                });
                              });
                            },
                          )


                      ],
                    ),
                  ),
                );
              },
              itemCount: mealss.length,
              scrollDirection: Axis.horizontal,
            )),
      ],
    ): Column();

  }
  headLineItem(String title) {
    return ListTile(
      title: AutoSizeText(
        title,
        style: TextStyle(
            color: Color(0xff36a9e0),
            fontSize: 25,
            fontWeight: FontWeight.bold
        ),
      ),
      trailing: Icon(Icons.navigate_next, color: Color(0xff36a9e0), size: 25.0),
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) {return Result(title,widget.currentcollection,calendarController,_events,_selectedEvents,mealsmap);}));
      },
    );
  }
}