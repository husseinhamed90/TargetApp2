import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:target/Models/Categories.dart';

import '../../providers/AppProvider.dart';
import '../../Models/Collection.dart';
import '../../Models/Meal.dart';




class Result extends StatefulWidget {

  String title;
  Collection currentcollection;
  CalendarController calendarController;
  Map<DateTime, List<List<meal>>> events = {};
  Map<DateTime, Map<String,List<meal>>> mealsmap = {};
  List<dynamic> selectedEvents = [];
  Result(this.title,this.currentcollection,this.calendarController,this.events,this.selectedEvents,this.mealsmap);

  @override
  _ResultState createState() => _ResultState();
}

class _ResultState extends State<Result> {

  final TextEditingController noteController = TextEditingController();
  bool selected = false;


  @override
  Widget build(BuildContext context) {
    final xx = Provider.of<appProvider>(context,listen: false);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Color(0xff36a9e0), size: 20.0),
      ),
      body: Container(height: MediaQuery.of(context).size.height,
          child:
          (widget.title=="Launch Meals".tr)?
          getcolum(xx, 310, xx.launchmeals, "Launch Meals".tr, MediaQuery.of(context).size.width, widget.currentcollection.launch,"Launch".tr,xx.chossenlaunchmeals):
          (widget.title=="BreakFast Meals".tr)?
          getcolum(xx, 310, xx.breakfastmeals, "BreakFast Meals".tr, MediaQuery.of(context).size.width, widget.currentcollection.breakfast,"BreakFast".tr,xx.choosenbreakfastmeals):
          (widget.title=="Dinner Meals".tr)?
          getcolum(xx, 310, xx.dinnermeals, "Dinner Meals".tr, MediaQuery.of(context).size.width, widget.currentcollection.dinner,"Dinner".tr,xx.choosendinnermeals):
          (widget.title=="Snacks Meals".tr)?
          getcolum(xx, 310, xx.snacks, "Snacks Meals".tr, MediaQuery.of(context).size.width, widget.currentcollection.snacks,"Snacks".tr,xx.chossensnacks):
          Container()
      )
    );
  }
  Column getcolum(appProvider xx,double hight, List<meal> meals ,String menuname,double width,bool chekcedvalue,String addedlist,List<meal>choosedmeals){
    List<meal> mealss =meals;
    return  (chekcedvalue)
        ? Column(
      children: [
        headLineItem(menuname),
        Container(
          child: Expanded(
            flex: 1,
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
                                          padding: const EdgeInsets.all(10),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                           //   scrollDirection: Axis.vertical,
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
                       // Spacer(),
                        if (!xx.ismealexist(mealss[index],choosedmeals))
                          IconButton(
                            icon: Icon(
                              Icons.add,color: Colors.black,size: 30,),
                            onPressed: () {
                              xx.addtolist(mealss[index],addedlist,widget.calendarController.selectedDay);
                              print("============launch=============");
                              for(int i=0;i<xx.allchossenlaunchmeals.length;i++){
                                print(xx.allchossenlaunchmeals[i].name);
                                print(xx.allchossenlaunchmeals[i].mealdate);
                              }
                              print("===================dinner======================");
                              for(int i=0;i<xx.allchoosendinnermeals.length;i++){
                                print(xx.allchoosendinnermeals[i].name);
                                print(xx.allchoosendinnermeals[i].mealdate);
                              }
                              print("=====================breakfast=====================");
                              for(int i=0;i<xx.allchoosenbreakfastmeals.length;i++){
                                print(xx.allchoosenbreakfastmeals[i].name);
                                print(xx.allchoosenbreakfastmeals[i].mealdate);
                              }
                              print("=====================snakcs=====================");
                              for(int i=0;i<xx.allchossensnacks.length;i++){
                                print(xx.allchossensnacks[i].name);
                                print(xx.allchossensnacks[i].mealdate);
                              }
                              setState(() {
                                mealss = xx.meals;
                                removeoldmeals(addedlist, xx);
                                if(widget.mealsmap[widget.calendarController.selectedDay]!=null){

                                  if(widget.mealsmap[widget.calendarController.selectedDay].containsKey(addedlist)){
                                    widget.mealsmap[widget.calendarController.selectedDay][addedlist]=choosedmeals;
                                  }
                                  else{
                                    widget.mealsmap[widget.calendarController.selectedDay][addedlist]=choosedmeals;
                                  }
                                }
                                else{
                                  widget.mealsmap[widget.calendarController.selectedDay]={addedlist:choosedmeals};
                                }
                              });
                              List<List<meal>> meals=[];
                              widget.mealsmap[widget.calendarController.selectedDay].forEach((key, value) {
                                meals.add(value);
                              });
                              setState(() {
                                widget.events[widget.calendarController.selectedDay]=meals;
                                xx.events= widget.events;
                                xx.selectedEvents=widget.selectedEvents;
                                xx.mealsmap=widget.mealsmap;
                              });

                            },
                          )
                        else
                          IconButton(
                            icon: Icon(Icons
                                .shopping_cart_outlined,color: Colors.black,size: 30,),
                            onPressed: () {
                              xx.removefrommeals(
                                  mealss[
                                  index],choosedmeals,widget.calendarController.selectedDay,addedlist);
                              print("============launch=============");
                              for(int i=0;i<xx.allchossenlaunchmeals.length;i++){
                                print(xx.allchossenlaunchmeals[i].name);
                                print(xx.allchossenlaunchmeals[i].mealdate);
                              }
                              print("===================dinner======================");
                              for(int i=0;i<xx.allchoosendinnermeals.length;i++){
                                print(xx.allchoosendinnermeals[i].name);
                                print(xx.allchoosendinnermeals[i].mealdate);
                              }
                              print("=====================breakfast=====================");
                              for(int i=0;i<xx.allchoosenbreakfastmeals.length;i++){
                                print(xx.allchoosenbreakfastmeals[i].name);
                                print(xx.allchoosenbreakfastmeals[i].mealdate);
                              }
                              print("=====================snakcs=====================");
                              for(int i=0;i<xx.allchossensnacks.length;i++){
                                print(xx.allchossensnacks[i].name);
                                print(xx.allchossensnacks[i].mealdate);
                              }
                              setState(() {
                                mealss = xx
                                    .meals;
                                removeoldmeals(
                                    addedlist,
                                    xx);

                                List<List<meal>> meals=[];
                                widget.mealsmap[widget.calendarController.selectedDay][addedlist]=choosedmeals;
                                if( widget.mealsmap[widget.calendarController.selectedDay][addedlist].length==0){
                                  setState(() {
                                    widget.mealsmap[widget.calendarController.selectedDay].remove(addedlist);
                                  });

                                }
                                widget.mealsmap[widget.calendarController.selectedDay].forEach((key, value) {
                                  meals.add(value);
                                });
                                setState(() {
                                  xx.events[widget.calendarController.selectedDay]=meals;
                                  xx.events=widget.events;
                                  xx.selectedEvents=widget.selectedEvents;
                                  xx.mealsmap=widget.mealsmap;
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
              scrollDirection: Axis.vertical,
            ),
          ),
        ),
      ],
    ): Column();

  }
  void removeoldmeals(String s, appProvider xx) {
    List<meal> meals;
    if (s == "Launch".tr) {
      meals = xx.chossenlaunchmeals;
    } else if (s == "BreakFast".tr) {
      meals = xx.choosenbreakfastmeals;
    } else if (s == "Dinner".tr) {
      meals = xx.choosendinnermeals;
    } else if(s=="Snacks".tr){
      meals = xx.chossensnacks;
    }
    if (widget.events[widget.calendarController.selectedDay] != null ) {
      if (widget.selectedEvents.length < 3) {
        if(widget.mealsmap[widget.calendarController.selectedDay].containsKey(s)){
          widget.events[widget.calendarController.selectedDay] = [meals];
        }
        else{
          widget.events[widget.calendarController.selectedDay].add(meals);
        }
      }
    } else {
      widget.events[widget.calendarController.selectedDay] = [meals];
    }
    setState(() {
      widget.selectedEvents = widget.events[widget.calendarController.selectedDay];
    });
    xx.events = widget.events;
    xx.selectedEvents = widget.selectedEvents;
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
    );
  }
}