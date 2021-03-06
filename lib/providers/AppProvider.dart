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
  DateTime startdate;
  DateTime enddate ;
  Collection currentcollection;
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
  Map<int,String> dayData = {1 : "Mon",2 : "Tue", 3 : "Wed", 4 : "Thur", 5 : "Fri", 6 : "Sat", 7 : "Sun" };
  List<Collection>collections=[];
  List<Collection>collections2=[];
  List<Collection>collections3=[];
  List<meal>meals=[];
  appProvider(this.language,this.daysaftersubscription,this.startdate);
  bool breakfastcheckedValue=false;
  bool dinnercheckedValue=false;
  bool snackscheckedValue=false;
  bool launchcheckedValue=false;
  TextEditingController name = TextEditingController();
  TextEditingController mobile = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController birthdate = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmpassword = TextEditingController();
  TextEditingController day = TextEditingController();
  TextEditingController month = TextEditingController();
  TextEditingController year = TextEditingController();
  TextEditingController block = TextEditingController();
  TextEditingController street = TextEditingController();
  TextEditingController building = TextEditingController();
  TextEditingController Floor = TextEditingController();
  TextEditingController Appointmnet = TextEditingController();
  DateTime birthDate = DateTime(1960);
  var gender;
  String selectedCity = 'Select City'.tr;
  String selectedArea = 'Select Area'.tr;
  ValueNotifier<Map<DateTime, Map<String,List<meal>>>> mealsmap = ValueNotifier({});
  List<city>cities=[];
  User user;
  ValueNotifier<String> userAddressName=ValueNotifier("");
  ValueNotifier<bool> pressed=ValueNotifier(true);
  ValueNotifier<Map<DateTime, List<List<meal>>>>currentEvents =ValueNotifier({});
  ValueNotifier<List<dynamic> >selectedEvents =ValueNotifier([]);
  ValueNotifier<bool> OnConfirmpressed=ValueNotifier(true);
  ValueNotifier<bool> isPassVisibleLoginPage=ValueNotifier(true);
  ValueNotifier<bool> isConfirmButtonClicked=ValueNotifier(false);
  bool isHoliday=false;
  DateTime dateTime=null;
  int daysaftersubscription;


  Collection getcurrentcollection(){
    return currentcollection;
  }

  void updateSubscription(Subscription s){

    setstartdate(s.start_programe_date.toString());
    subscription=s;
    notifyListeners();

  }

  void updateCollection(Collection collection){
    currentcollection=collection;
    startdate=DateTime.now().add(new Duration(days:2));
    enddate=DateTime.now().add(new Duration(days:daysoptions[currentcollection.days_id].numodfays+1));
    notifyListeners();
  }

  void changeStateOfEyeIcon(ValueNotifier<bool> value){

    value.value=!value.value;
    notifyListeners();
  }

  void changeStateOfDateTimeValue(DateTime newValue){
    dateTime=newValue;
    notifyListeners();
  }

  void changeStateOfIsHolidayValue(bool newValue){
    isHoliday=newValue;
    notifyListeners();
  }

  void updateMealsMap(Map<DateTime, Map<String,List<meal>>> newCurrentEvents){
    mealsmap.value=newCurrentEvents;
    notifyListeners();
  }

  void updateCurrentEvents(Map<DateTime, List<List<meal>>>newCurrentEvents){
    currentEvents.value=newCurrentEvents;
    notifyListeners();
  }

  void updateSelectedEvents(List<dynamic> newSelectedEvents){
    selectedEvents.value=newSelectedEvents;
    notifyListeners();
  }

  void resetIsisConfirmButtonClickedValue(){
    isConfirmButtonClicked.value=false;
    notifyListeners();
  }

  void updateCurrentProgram(program newValue){
    cuurentprogram=newValue;
    notifyListeners();
  }

  void updateCurrentCollection(Collection newValue){
    currentcollection=newValue;
    notifyListeners();
  }

  void updateUser(){
    user = User(
        name.text,
        mobile.text,
        email.text,
        birthDate,
        gender,
        password.text,
        confirmpassword.text,
        selectedCity,
        selectedArea,
        (block.text == "") ? "" :block.text,
        (Floor.text == "") ? "" : Floor.text,
        (Appointmnet.text == "") ? "" : Appointmnet.text,
        (building.text == "") ? "" : building.text,
         street.text);
    notifyListeners();
  }

  String validateForm(String label,String value){
    if (label == "Full Name".tr || label == "Mobile Number".tr ) {
      if (value.isEmpty) {
        return 'This Field required?'.tr;
      } else {
        return null;
      }
    }
    else if(label == "Password".tr){
      if (value.isEmpty) {
        return "This Field required?".tr;
      } else {
        if (value.length<6) {
          return "Password must be at least 6 characters".tr;
        } else {
          return null;
        }
      }
    }
    else if (label == "Confirm Password".tr) {
      if (value.isEmpty) {
        return "This Field required?".tr;
      } else {
        if (value != password.text) {
          print(value);
          print(password.text);
          return "Passwords not matched".tr;
        } else {
          return null;
        }
      }
    }
    else if(label == "Address Street".tr){

      if (value.isEmpty) {
        return "Please Enter Your Enter Or Click on The Location Icon".tr;
      } else {
        return null;
      }
    }
    else {
      return null;
    }
  }

  void setUserAddressName(String address){
    userAddressName.value=address;
    notifyListeners();
  }

  void updateUserStreet(){
    user.Street=userAddressName.value;
  }

  void resetUser(){
    user=null;
    notifyListeners();
  }

  void resetTextFields(){
      name.clear();
      mobile.clear();
      email.clear();
      birthdate.clear();
      dateTime=null;
      password.clear();
      confirmpassword.clear();
      day.clear();
      month.clear();
      year.clear();
      block.clear();
      street.clear();
      building.clear();
      Floor.clear();
      Appointmnet.clear();
      setUserAddressName("");
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

  void getMeals(){
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
      Collection.usingObjects("title", "description", "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRfUJTW2BQ9BkdnlmVrc82T-Mg2teG0S-y87Q&usqp=CAU", 200,2,false, true, false,true, 10,daysoptions[1], 1),
      Collection.usingObjects("title", "description", "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRfUJTW2BQ9BkdnlmVrc82T-Mg2teG0S-y87Q&usqp=CAU", 300,1,true, false, true, true,10,daysoptions[2], 1),

    ];
    collections2=[
      Collection.usingObjects("title", "description", "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRfUJTW2BQ9BkdnlmVrc82T-Mg2teG0S-y87Q&usqp=CAU", 200,2,false, true, false, true,10,daysoptions[2], 1),
    ];
    collections3=[
      Collection.usingObjects("title", "description", "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRfUJTW2BQ9BkdnlmVrc82T-Mg2teG0S-y87Q&usqp=CAU", 200,2,false, true, false,true, 10,daysoptions[0], 1),
      Collection.usingObjects("title", "description", "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRfUJTW2BQ9BkdnlmVrc82T-Mg2teG0S-y87Q&usqp=CAU", 300,1,true, false, true,true, 10,daysoptions[2], 1)
    ];
    programss=[
      program(1,"Ta5ses","description","https://cdn.al-ain.com/images/2020/11/18/173-152814-best-diet-slimming-gym_700x400.jpg",collections),
      program(2,"Zyadet El Wazen","description","https://media.gemini.media/img/large/2018/9/25/2018_9_25_14_7_35_918.jpg",collections2),
      program(3,"kito","description","https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRfUJTW2BQ9BkdnlmVrc82T-Mg2teG0S-y87Q&usqp=CAU",collections3),
    ];
    //notifyListeners();
  }

  bool validateusernameandpassword(String mobileNumber ,String password){
    //get user information from api
    user = User(
        "Hussein Hamed",
         mobileNumber,
        "hussei hamed@gmail.com",
        DateTime.now(),
        "male",
        password,
        password,
        "Giza",
        "Haram",
        "2",
        "2",
        "2",
        "2",
        "El HARAM Street");
     setUserAddressName(user.Street);
     updateCollection( Collection.usingObjects("title", "description", "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRfUJTW2BQ9BkdnlmVrc82T-Mg2teG0S-y87Q&usqp=CAU", 200,2,false, true, false,true, 10,daysoptions[2], 1),);
     notifyListeners();
    //get user info from the server
     return true;
  }

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

  bool isCouponValid(String coupon){
    if(coupon=="50A"){
      return true;
    }
    return false;
  }

  bool ismealexist(meal newmeal,List<meal>list){
    for(int i=0;i<list.length;i++){
      if(list[i].id==newmeal.id){
        return true;
      }
    }
    return false;
  }

  void updateAppProvider(widget) {
    List<List<meal>> meals=[];
    widget.mealsmap[widget.calendarController.selectedDay].forEach((key, value) {
      meals.add(value);
    });
    widget.currentEvents[widget.calendarController.selectedDay]=meals;
    updateCurrentEvents(widget.currentEvents);
    updateSelectedEvents(widget.selectedEvents);
    updateMealsMap(widget.mealsmap);
  }

  void addMealToOrder(appProvider appProviderInstance, meal currentMeal, String addedlist, widget, List<meal> mealss, Function setStateFunction, List<meal> choosedmeals) {
    appProviderInstance.addtolist(currentMeal,addedlist,widget.calendarController.selectedDay);
    mealss = appProviderInstance.meals;
    appProviderInstance.removeOldMeals(addedlist, appProviderInstance,widget,setStateFunction);
    if(widget.mealsmap[widget.calendarController.selectedDay]!=null){
      widget.mealsmap[widget.calendarController.selectedDay][addedlist]=choosedmeals;
    }
    else{
      widget.mealsmap[widget.calendarController.selectedDay]={addedlist:choosedmeals};
    }
  }

  void removeOldMeals(String whichMeal, appProvider appProviderInstance,dynamic widget,Function function) {
    List<meal> meals;
    if (whichMeal == "Launch".tr) {
      meals = appProviderInstance.chossenlaunchmeals;
    } else if (whichMeal == "BreakFast".tr) {
      meals = appProviderInstance.choosenbreakfastmeals;
    } else if (whichMeal == "Dinner".tr) {
      meals = appProviderInstance.choosendinnermeals;
    } else if(whichMeal=="Snacks".tr){
      meals = appProviderInstance.chossensnacks;
    }
    if (widget.currentEvents[widget.calendarController.selectedDay] != null ) {
      if (widget.selectedEvents.length < 3) {
        if(widget.mealsmap[widget.calendarController.selectedDay].containsKey(whichMeal)){
          widget.currentEvents[widget.calendarController.selectedDay] = [meals];
        }
        else{
          widget.currentEvents[widget.calendarController.selectedDay].add(meals);
        }
      }
    } else {
      widget.currentEvents[widget.calendarController.selectedDay] = [meals];
    }
        (){
      function();
    };
    appProviderInstance.updateCurrentEvents(widget.currentEvents);
    appProviderInstance.updateSelectedEvents(widget.selectedEvents);
  }

  void removeMealFromOrder(appProvider appProviderInstance, meal currentMeal, List<meal> choosedmeals, widget, String addedlist, List<meal> mealss) {
    appProviderInstance.removefrommeals(currentMeal,choosedmeals,widget.calendarController.selectedDay,addedlist);
    mealss = appProviderInstance.meals;
    widget.mealsmap[widget.calendarController.selectedDay][addedlist]=choosedmeals;
    if( widget.mealsmap[widget.calendarController.selectedDay][addedlist].length==0){
      widget.mealsmap[widget.calendarController.selectedDay].remove(addedlist);
    }
  }

  void getMealsFromEvent(DateTime day, appProvider appProviderInstance) {
    if (appProviderInstance.currentEvents.value[day] == null) {
      appProviderInstance.resetmeals();
    }
    else {
      for (int i = 0; i < appProviderInstance.currentEvents.value[day].length; i++) {
        if (appProviderInstance.currentEvents.value[day][i].length > 0) {
          if (appProviderInstance.currentEvents.value[day][i][0].mealcategory == Categories.Launch) {
            appProviderInstance.chossenlaunchmeals = appProviderInstance.currentEvents.value[day][i];
          } else if (appProviderInstance.currentEvents.value[day][i][0].mealcategory == Categories.Breakfast) {
            appProviderInstance.choosenbreakfastmeals = appProviderInstance.currentEvents.value[day][i];
          } else if (appProviderInstance.currentEvents.value[day][i][0].mealcategory == Categories.Dinner) {
            appProviderInstance.choosendinnermeals =appProviderInstance.currentEvents.value[day][i];
          } else if (appProviderInstance.currentEvents.value[day][i][0].mealcategory == Categories.Snacks) {
            appProviderInstance.chossensnacks =appProviderInstance.currentEvents.value[day][i];
          }
        }
      }
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
    Chossenpackage="";
    chossensnacks=[];
    notifyListeners();
  }

  void addtolist(meal newmeal,String x,DateTime dateTime){
    meal newmea=meal.withdate(newmeal.id,newmeal.name,newmeal.description,newmeal.mealcategory,
        newmeal.url,dateTime);
    if(x=="BreakFast Meals".tr){
      allchoosenbreakfastmeals.add(newmea);
      choosenbreakfastmeals.add(newmeal);
      notifyListeners();
    }
    else if(x=="Dinner Meals".tr){
      choosendinnermeals.add(newmeal);
      allchoosendinnermeals.add(newmea);
      notifyListeners();
    }
    else if(x=="Launch Meals".tr){
      allchossenlaunchmeals.add(newmea);
      chossenlaunchmeals.add(newmeal);
      notifyListeners();
    }
    else if(x=="Snacks Meals".tr){
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
  }

  void setremaintopref()async{
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    await prefs.setInt("remain", daysaftersubscription);
    notifyListeners();
  }

  void setstartdate(String date)async{
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    await prefs.setString("startdate", date);
    notifyListeners();
  }

  void getstartdate()async{
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    startdate = DateTime.parse(prefs.getString('startdate') ?? "");
    notifyListeners();
  }
}