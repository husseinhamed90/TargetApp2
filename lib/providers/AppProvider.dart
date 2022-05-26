// @dart=2.9

import 'package:flutter/cupertino.dart';


import 'package:get/get.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:target/Models/Categories.dart';
import 'package:target/Models/City.dart';
import 'package:target/Models/Collection.dart';
import 'package:target/Models/Days.dart';
import 'package:target/Models/Meal.dart';
import 'package:target/Models/Program.dart';
import 'package:target/Models/Subscription.dart';
import 'package:target/Models/User.dart';

class appProvider extends ChangeNotifier{


  String choosedprogram="";
  String Chossenpackage="";
  program cuurentprogram;
  String language="";
  Subscription subscription;
  List<days>daysoptions;
  //days d=days(1,14,[dayofoption.saturday,dayofoption.saturday]) ;
  DateTime startdate;
  DateTime enddate ;
  Collection currentcollection;
  Collection getcurrentcollection(){
    return currentcollection;
  }

  void updateSubscription(Subscription s){

    setstartdate(s.start_programe_date.toString());
    subscription=s;
    notifyListeners();

  }
  Map<int,String> dayData =
      {1 : "Mon",2 : "Tue", 3 : "Wed", 4 : "Thur", 5 : "Fri", 6 : "Sat", 7 : "Sun" };
  void updatecCollection(Collection collection){
    currentcollection=collection;
    startdate=DateTime.now().add(new Duration(days:2));
    enddate=DateTime.now().add(new Duration(days:daysoptions[currentcollection.days_id].numodfays+1));
    notifyListeners();
  }
  List<Collection>collections=[];
  List<Collection>collections2=[];
  List<Collection>collections3=[];
  List<meal>meals=[];
  appProvider(this.language,this.daysaftersubscription,this.startdate);
  bool breakfastcheckedValue=false;
  bool dinnercheckedValue=false;
  bool snackscheckedValue=false;
  bool launchcheckedValue=false;

  Map<DateTime, List<List<meal>>> events={};
  Map<DateTime, Map<String,List<meal>>> mealsmap = {};
  List<dynamic> selectedEvents=[];
  List<city>cities=[];
  var user;
  List<int>numbers=[];

  void updateuser(User updatedinfo){
    user=updatedinfo;
    notifyListeners();
  }
  List<meal>breakfastmeals=[];
  List<meal>snacks=[];
  List<meal>dinnermeals=[];
  List<meal>launchmeals=[];
  List<program>programss=[];
  List<meal>choosenbreakfastmeals=[];
  List<meal>choosendinnermeals=[];
  List<meal>chossenlaunchmeals=[];
  List<meal>chossensnacks=[];

  List<meal>allchoosenbreakfastmeals=[];
  List<meal>allchoosendinnermeals=[];
  List<meal>allchossenlaunchmeals=[];
  List<meal>allchossensnacks=[];

  List<String>Choosenprograms=[];

  void resetuser(){
    user=null;
    notifyListeners();
  }
  String getDays(appProvider approvider){
    String days ="";
    print(currentcollection.dayss.dayoff);
     currentcollection.dayss.dayoff.forEach((element) {
      days+=approvider.dayData[element].tr+" / ";
    });
    return days;

  }
  void getmeals(){
    //get meals and collections from the api
    daysoptions=[
      days(1,14,[5]),
      days(2,22,[6]),
      days(3,26,[5,6]),
    ];

    breakfastmeals=[
      meal(1,"meal 1", "meal 1 description ", Categories.Breakfast, "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRfUJTW2BQ9BkdnlmVrc82T-Mg2teG0S-y87Q&usqp=CAU"),
      meal(2,"meal 2", "meal 2 description ", Categories.Breakfast, "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRfUJTW2BQ9BkdnlmVrc82T-Mg2teG0S-y87Q&usqp=CAU"),
    ];
    snacks=[
      meal(6,"meal 6", "meal 1 description ", Categories.Snacks, "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRfUJTW2BQ9BkdnlmVrc82T-Mg2teG0S-y87Q&usqp=CAU"),
      meal(7,"meal 7", "meal 2 description ", Categories.Snacks, "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRfUJTW2BQ9BkdnlmVrc82T-Mg2teG0S-y87Q&usqp=CAU"),
    ];
    dinnermeals=[
      meal(3,"meal 3", "meal 3 description ", Categories.Dinner, "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRfUJTW2BQ9BkdnlmVrc82T-Mg2teG0S-y87Q&usqp=CAU"),
    ];
    launchmeals=[
      meal(5,"meal 5", "meal 5 description ", Categories.Launch, "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRfUJTW2BQ9BkdnlmVrc82T-Mg2teG0S-y87Q&usqp=CAU"),
    ];
    collections=[
      Collection.usginopjects("title", "description", "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRfUJTW2BQ9BkdnlmVrc82T-Mg2teG0S-y87Q&usqp=CAU", 200,2,false, true, false,true, 10,daysoptions[1], 1),
      Collection.usginopjects("title", "description", "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRfUJTW2BQ9BkdnlmVrc82T-Mg2teG0S-y87Q&usqp=CAU", 300,1,true, false, true, true,10,daysoptions[2], 1),

    ];
    collections2=[
      Collection.usginopjects("title", "description", "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRfUJTW2BQ9BkdnlmVrc82T-Mg2teG0S-y87Q&usqp=CAU", 200,2,false, true, false, true,10,daysoptions[2], 1),
    ];
    collections3=[
      Collection.usginopjects("title", "description", "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRfUJTW2BQ9BkdnlmVrc82T-Mg2teG0S-y87Q&usqp=CAU", 200,2,false, true, false,true, 10,daysoptions[0], 1),
      Collection.usginopjects("title", "description", "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRfUJTW2BQ9BkdnlmVrc82T-Mg2teG0S-y87Q&usqp=CAU", 300,1,true, false, true,true, 10,daysoptions[2], 1)
    ];
    programss=[
      program(1,"Ta5ses","description","https://cdn.al-ain.com/images/2020/11/18/173-152814-best-diet-slimming-gym_700x400.jpg",collections),
      program(2,"Zyadet El Wazen","description","https://media.gemini.media/img/large/2018/9/25/2018_9_25_14_7_35_918.jpg",collections2),
      program(3,"kito","description","https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRfUJTW2BQ9BkdnlmVrc82T-Mg2teG0S-y87Q&usqp=CAU",collections3),
    ];
    //notifyListeners();
  }
  bool validateusernameandpassword(String username ,String password){
    //get user information from api
    User user = User(
        "User 1",
        username,
        "${username}@gmail.com",
        DateTime.now(),

        "male",
        password,
        password,
        "Kuwait",
        "Hawally",
        "2",
        "2",
        "2",
        "2",
        "street");
    updatecCollection( Collection.usginopjects("title", "description", "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRfUJTW2BQ9BkdnlmVrc82T-Mg2teG0S-y87Q&usqp=CAU", 200,2,false, true, false,true, 10,daysoptions[2], 1),);
    updateuser(user);
    //get user info from the server
    return true;
  }
  int daysaftersubscription;
  void updateremain(int x){
    daysaftersubscription=x;
    notifyListeners();
  }

  void removefrommeals(meal meal,List<meal>list,DateTime dateTime,String x){
    for(int i=0;i<list.length;i++){
      if(list[i].id==meal.id){
        list.removeAt(i);
        break;
      }
    }


    if(x=="BreakFast".tr){
      //allchoosenbreakfastmeals.add(newmea);
      for(int i=0;i<allchoosenbreakfastmeals.length;i++){
        if(allchoosenbreakfastmeals[i].id==meal.id&&allchoosenbreakfastmeals[i].mealdate==dateTime){
          allchoosenbreakfastmeals.removeAt(i);
          break;
        }
      }
      notifyListeners();
    }
    else if(x=="Dinner".tr){
      for(int i=0;i<allchoosendinnermeals.length;i++){
        if(allchoosendinnermeals[i].id==meal.id&&allchoosendinnermeals[i].mealdate==dateTime){
          allchoosendinnermeals.removeAt(i);
          break;
        }
      }
      notifyListeners();
    }
    else if(x=="Launch".tr){
      for(int i=0;i<allchossenlaunchmeals.length;i++){
        if(allchossenlaunchmeals[i].id==meal.id&&allchossenlaunchmeals[i].mealdate==dateTime){
          allchossenlaunchmeals.removeAt(i);
          break;
        }
      }

      notifyListeners();
    }
    else if(x=="Snacks".tr){

      for(int i=0;i<allchossensnacks.length;i++){
        if(allchossensnacks[i].id==meal.id&&allchossensnacks[i].mealdate==dateTime){
          allchossensnacks.removeAt(i);
          break;
        }
      }
      notifyListeners();
    }
    notifyListeners();
  }
  bool iscouponvalid(String coupon){
    if(coupon=="50A"){
      return true;
    }
  }
  bool ismealexist(meal newmeal,List<meal>list){

    for(int i=0;i<list.length;i++){
      if(list[i].id==newmeal.id){
        return true;
      }
    }
    return false;
  }
  void chnagecurrentprogram(String x){
    if(x=="BreakFast".tr){
      meals=breakfastmeals;
    }
    if(x=="Dinner".tr){
      meals=dinnermeals;
    }
    if(x=="Launch".tr){
      meals=launchmeals;
    }
    if(x=="Snacks".tr){
      meals=snacks;
    }
  }
  void removeprogram (String programename){
    for(int i=0;i<Choosenprograms.length;i++){
      if(Choosenprograms[i]==programename){
        Choosenprograms.removeAt(i);
        break;
      }
    }
    notifyListeners();
  }
  void resetmeals(){
    chossenlaunchmeals=[];
    choosendinnermeals=[];
    choosenbreakfastmeals=[];
    mealsmap={};
    events={};
    selectedEvents=[];
    Chossenpackage="";
    chossensnacks=[];
    //notifyListeners();
  }
  void addtolist(meal newmeal,String x,DateTime dateTime){
    meal newmea=meal.withdate(newmeal.id,newmeal.name,newmeal.description,newmeal.mealcategory,
        newmeal.url,dateTime);


    if(x=="BreakFast".tr){
      allchoosenbreakfastmeals.add(newmea);
      choosenbreakfastmeals.add(newmeal);
      notifyListeners();
    }
    else if(x=="Dinner".tr){
      choosendinnermeals.add(newmeal);
      allchoosendinnermeals.add(newmea);
      notifyListeners();
    }
    else if(x=="Launch".tr){
      allchossenlaunchmeals.add(newmea);
      chossenlaunchmeals.add(newmeal);
      notifyListeners();
    }
    else if(x=="Snacks".tr){
      chossensnacks.add(newmeal);
      allchossensnacks.add(newmea);
      notifyListeners();
    }
  }
  void getlanguagefrompref()async{
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    language = (prefs.getString('Lang') ?? "Eng");
    notifyListeners();
  }
  void setlanguagetopref(String lang)async{
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    await prefs.setString("Lang", language);
    notifyListeners();
  }

  Future<int> getremainfrompref()async{
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
     return (prefs.getInt('remain') ?? 0);
    notifyListeners();
  }
  void setremaintopref(String lang)async{
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    await prefs.setInt("remain", daysaftersubscription);
    notifyListeners();
  }

  void setstartdate(String date)async{
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    await prefs.setString("startdate", startdate.toString());
    notifyListeners();
  }
  void getstartdate()async{
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    startdate = DateTime.parse(prefs.getString('startdate') ?? "");
    notifyListeners();
  }
}