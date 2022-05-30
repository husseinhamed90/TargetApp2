import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:target/Models/Categories.dart';
import 'package:target/Models/Collection.dart';
import 'package:target/Models/Meal.dart';
import 'package:target/Modules/CalenderWithMeals/selectmeals.dart';
import 'package:target/Modules/ProgramDetails/programdetails.dart';
import 'package:target/providers/AppProvider.dart';

Widget snack(String content) {
  return SnackBar(
      backgroundColor: Colors.red,
      duration: Duration(seconds: 3),
      content: Text(content),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15.0),
            topRight: Radius.circular(15.0),
          )));
}

Widget item(String title, String subtitle,bool isCouponApplied,Collection currentCollection) {
  if(title=="Collection Fee : "){
    return ListTile(
      title: AutoSizeText(
        title,
        style: TextStyle(
            color: Colors.white,
            fontSize: 20.0,
            fontWeight: FontWeight.bold
        ),
      ),
      subtitle: Row(
        children: [
          Stack(
            children: [
              AutoSizeText(
                subtitle,
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,

                ),
              ),
              (isCouponApplied)?Positioned(right: 0,top: 7,child: Container(width: 70,height: 2,color: Colors.white,)):Container()
            ],
          ),
          SizedBox(width: 10,),
          (isCouponApplied)?AutoSizeText(
            "${currentCollection.price*((100-50)/100)} KWD",
            style: TextStyle(
              color: Colors.white70,
              fontSize: 18.0,
              fontWeight: FontWeight.bold,

            ),
          ):Container(),
        ],
      ),
    );
  }
  else{
    return ListTile(
      title: AutoSizeText(
        title,
        style: TextStyle(
            color: Colors.white,
            fontSize: 20.0,
            fontWeight: FontWeight.bold
        ),
      ),
      subtitle: AutoSizeText(
        subtitle,
        style: TextStyle(
          color: Colors.white70,
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

Widget buildField(String label, IconData icon, TextInputType type, TextEditingController controller, Key key,double width,appProvider appProviderInstance) {

  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      width: width,
      child: ValueListenableBuilder(
        valueListenable: label == 'Password'.tr? appProviderInstance.pressed:appProviderInstance.OnConfirmpressed,
        builder: (context, valuee, child) => TextFormField(
          key: key,
          validator: (value) {
            return appProviderInstance.validateForm(label, value);
          },
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.0),
              borderSide: BorderSide(color: Colors.grey, width: 0.5),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.0),
              borderSide: BorderSide(color: Colors.red, width: 0.5),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.0),
              borderSide: BorderSide(color: Colors.grey, width: 0.5),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.0),
              borderSide: BorderSide(color: Colors.grey, width: 0.5),
            ),
            labelText: label,
            labelStyle: TextStyle(color: Colors.grey),
            prefixIcon: Icon(icon, color: Colors.grey),
            suffixIcon: label == 'Password'.tr||label=='Confirm Password'.tr
                ? IconButton(
                  icon:!valuee ?Icon(Icons.remove_red_eye):Icon(Icons.visibility_off),
                  color: Colors.grey,
                  iconSize: 20.0,
                  onPressed: () {
                    if(label == 'Password'.tr)
                       appProviderInstance.changeStateOfEyeIcon(appProviderInstance.pressed);
                    else if(label=='Confirm Password'.tr)
                      appProviderInstance.changeStateOfEyeIcon(appProviderInstance.OnConfirmpressed);
                  },
                )
                : null,
          ),
          textInputAction: TextInputAction.done,
          keyboardType: type,
          obscureText: (label=="Password".tr||label=='Confirm Password'.tr)?valuee:false,
          controller: controller,
        ),
      ),
    ),
  );
}

Widget buildListOfMeals(dynamic widget,appProvider appProviderInstance,double hight, List<meal> meals ,String menuname,double width,bool chekcedvalue,String addedlist,List<meal>choosedmeals,Function setStateFunction,bool isVertical){
  List<meal> mealss =meals;
  if ((chekcedvalue)) {
    return Column(
    children: [
      headLineItem(title: menuname,onTap: setStateFunction),
      (isVertical)? Expanded(
        child: buildList(hight, mealss, appProviderInstance, widget, choosedmeals, addedlist, setStateFunction, isVertical,widget.noteController),
      ):buildList(hight, mealss, appProviderInstance, widget, choosedmeals, addedlist, setStateFunction, isVertical,widget.noteController),
    ],
  );
  } else {
    return Column();
  }
}

Container buildList(double height, List<meal> newList, appProvider appProviderInstance, widget, List<meal> choosedmeals, String addedlist, Function setStateFunction, bool isVertical,TextEditingController noteController) {
  return Container(
        color: Color(0xfff5f5f5),
        height: height,
        child: ListView.builder(
          itemBuilder: (context, index) {
            return  buildMealItem(context, appProviderInstance, newList[index], widget, choosedmeals, addedlist, setStateFunction, newList,noteController);
          },
          itemCount: newList.length,
          scrollDirection: isVertical?Axis.vertical:Axis.horizontal,
        ),
      );
}

Widget buildMealItem(BuildContext context,appProvider appProviderInstance,meal currentMeal,dynamic widget,List<meal> choosedmeals, String addedlist, Function setStateFunction,List<meal> mealss,TextEditingController noteController){
  return Card(
    margin: EdgeInsets.all(10.0),
    elevation: 5.0,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
    child: Container(
      height: 300,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0),
      ),
      width: MediaQuery.of(context).size.width/1.5,
      child: Column(
        children: [
          buildImageFromUrl(currentMeal.url),
          buildMealInfo(currentMeal, appProviderInstance, choosedmeals, context, noteController),
          Spacer(),
          editOrderButtons(appProviderInstance, currentMeal, widget, addedlist, choosedmeals, mealss, setStateFunction)
        ],
      ),
    ),
  );
}

Widget editOrderButtons(appProvider appProviderInstance,meal currentMeal,dynamic widget,String addedlist,List<meal>choosedmeals,List<meal>mealss,Function setStateFunction){

  return IconButton(
    icon: Icon(!appProviderInstance.ismealexist(currentMeal,choosedmeals)?Icons.add:Icons.shopping_cart_outlined,
      color: Colors.black,size: 30,),
      onPressed: () {
        if (!appProviderInstance.ismealexist(currentMeal,choosedmeals)){
          addMealToOrder(appProviderInstance, currentMeal, addedlist, widget, mealss, setStateFunction, choosedmeals);
        }
        else{
          removeMealFromOrder(appProviderInstance, currentMeal, choosedmeals, widget, addedlist, mealss);
        }
        updateAppProvider(widget, appProviderInstance);
      },
  );
}

void removeMealFromOrder(appProvider appProviderInstance, meal currentMeal, List<meal> choosedmeals, widget, String addedlist, List<meal> mealss) {
  appProviderInstance.removefrommeals(currentMeal,choosedmeals,widget.calendarController.selectedDay,addedlist);
  mealss = appProviderInstance.meals;
  widget.mealsmap[widget.calendarController.selectedDay][addedlist]=choosedmeals;
  if( widget.mealsmap[widget.calendarController.selectedDay][addedlist].length==0){
    widget.mealsmap[widget.calendarController.selectedDay].remove(addedlist);
  }
}

void addMealToOrder(appProvider appProviderInstance, meal currentMeal, String addedlist, widget, List<meal> mealss, Function setStateFunction, List<meal> choosedmeals) {
  appProviderInstance.addtolist(currentMeal,addedlist,widget.calendarController.selectedDay);
  mealss = appProviderInstance.meals;
  removeOldMeals(addedlist, appProviderInstance,widget,setStateFunction);
  if(widget.mealsmap[widget.calendarController.selectedDay]!=null){
    widget.mealsmap[widget.calendarController.selectedDay][addedlist]=choosedmeals;
  }
  else{
    widget.mealsmap[widget.calendarController.selectedDay]={addedlist:choosedmeals};
  }
}

void updateAppProvider(widget, appProvider appProviderInstance) {
  List<List<meal>> meals=[];
  widget.mealsmap[widget.calendarController.selectedDay].forEach((key, value) {
    meals.add(value);
  });
  widget.currentEvents[widget.calendarController.selectedDay]=meals;
  appProviderInstance.updateCurrentEvents(widget.currentEvents);
  appProviderInstance.updateSelectedEvents(widget.selectedEvents);
  appProviderInstance.updateMealsMap(widget.mealsmap);
}

Widget buildImageFromUrl(String url){
  return Container(
    height: 170,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20.0),
      image: DecorationImage(
          image: NetworkImage(url),
          fit : BoxFit.fill
      ),
    ),
  );
}
Widget buildMealInfo(meal currentMeal,appProvider appProviderInstance,List<meal> choosedmeals,BuildContext context,TextEditingController noteController){
  return  Container(
    height: 50,
    child: ListTile(
      title: AutoSizeText(
        currentMeal.name,
        style: TextStyle(
            color: Colors.black,
            fontSize: 25,
            fontWeight: FontWeight.bold
        ),
      ),
      subtitle: AutoSizeText(
        currentMeal.description,
        style: TextStyle(
            color: Colors.grey,
            fontSize: 15,
            fontWeight: FontWeight.bold
        ),
      ),
      trailing:(appProviderInstance.ismealexist(currentMeal,choosedmeals))?(currentMeal.isNoteExist==false) ?
      TextButton(
        child: Text("Add Note".tr),
        onPressed: () {
          customShowBottomSheet(context, appProviderInstance, currentMeal, noteController);
        },
      ):
      TextButton(
        child: Text("Remove Note".tr),
        onPressed: () {
          currentMeal.isNoteExist=false;
          appProviderInstance.resetIsisConfirmButtonClickedValue();
        },
      )
          :SizedBox(),
    ),
  );
}
Future<dynamic> customShowBottomSheet(BuildContext context,appProvider appProviderInstance,meal currentMeal,TextEditingController noteController){
  return showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0))),
      builder: (BuildContext context){
        return Padding(
          padding: const EdgeInsets.all(10),
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
                    currentMeal.isNoteExist=true;
                    appProviderInstance.changeStateOfEyeIcon(appProviderInstance.isConfirmButtonClicked);
                    Navigator.pop(context);
                  }
              ),
            ],
          ),
        );
      }
  );
}
Widget loginField(String label, IconData icon, bool secured, TextInputType type, TextEditingController controller, Key key,appProvider appProviderInstance) {
  return Padding(
    padding: const EdgeInsets.all(8.0),

    child: ValueListenableBuilder(
      valueListenable: appProviderInstance.isPassVisibleLoginPage,
      builder: (context, value, child) =>   TextFormField(
         key: key,
         validator: (value){
           if(value.isEmpty){
             return 'required'.tr;
           }
           else{
             return null;
           }
         },
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
             prefixIcon: Icon(icon, color: Colors.black),
             suffixIcon: label == 'Password'.tr ? IconButton(
               icon:!secured ?Icon(Icons.remove_red_eye):Icon(Icons.visibility_off),
               color: Colors.grey,
               onPressed: () {
                 appProviderInstance.changeStateOfEyeIcon(appProviderInstance.isPassVisibleLoginPage);
               },
             ) : null,
             labelText: label
         ),
         textInputAction: TextInputAction.done,
         keyboardType: type,
         obscureText: (label =="Password".tr)?value:false,
         controller: controller
     ),
    )
  );
}

Widget DrawButtonOnHomePage({Function onTapFun, String text}){
  return Column(
    children: [
      InkWell(
        onTap: onTapFun,
        child: Container(

          height: 40,
          width: 140,
          decoration: BoxDecoration(
              color: Color(0xff36a9e0),
              borderRadius: BorderRadius.all(Radius.circular(20))
          ),
          child: Center(
            child: AutoSizeText(
              text.tr,
              style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    ],
  );
}

void removeOldMeals(String s, appProvider appProviderInstance,dynamic widget,Function function) {
  List<meal> meals;
  if (s == "Launch".tr) {
    meals = appProviderInstance.chossenlaunchmeals;
  } else if (s == "BreakFast".tr) {
    meals = appProviderInstance.choosenbreakfastmeals;
  } else if (s == "Dinner".tr) {
    meals = appProviderInstance.choosendinnermeals;
  } else if(s=="Snacks".tr){
    meals = appProviderInstance.chossensnacks;
  }
  if (widget.currentEvents[widget.calendarController.selectedDay] != null ) {
    if (widget.selectedEvents.length < 3) {
      if(widget.mealsmap[widget.calendarController.selectedDay].containsKey(s)){
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

Widget headLineItem({String title, Function onTap}) {

  return  GestureDetector(
    onTap: onTap,
    child: Row(
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.all(10.0),
            child: AutoSizeText(
              title,
              style: TextStyle(
                  color: Color(0xff36a9e0),
                  fontSize: 25,
                  fontWeight: FontWeight.bold
              ),
            ),
          ),
        ),
        IconButton(onPressed: onTap, icon: Icon(Icons.navigate_next, color: Color(0xff36a9e0), size: 25.0))

      ],
    ),
  );
}

void getmealsfromevent(DateTime dayy, appProvider appProviderInstance) {
  if (appProviderInstance.currentEvents.value[dayy] == null) {
    appProviderInstance.resetmeals();
  }
  else {
    for (int i = 0; i < appProviderInstance.currentEvents.value[dayy].length; i++) {
      if (appProviderInstance.currentEvents.value[dayy][i].length > 0) {
        if (appProviderInstance.currentEvents.value[dayy][i][0].mealcategory == Categories.Launch) {
          appProviderInstance.chossenlaunchmeals = appProviderInstance.currentEvents.value[dayy][i];
        } else if (appProviderInstance.currentEvents.value[dayy][i][0].mealcategory == Categories.Breakfast) {
          appProviderInstance.choosenbreakfastmeals = appProviderInstance.currentEvents.value[dayy][i];
        } else if (appProviderInstance.currentEvents.value[dayy][i][0].mealcategory == Categories.Dinner) {
          appProviderInstance.choosendinnermeals =appProviderInstance.currentEvents.value[dayy][i];
        } else if (appProviderInstance.currentEvents.value[dayy][i][0].mealcategory == Categories.Snacks) {
          appProviderInstance.chossensnacks =appProviderInstance.currentEvents.value[dayy][i];
        }
      }
    }
  }
}

String getDays(appProvider approvider,Collection currentcollection){
  String days ="";
   currentcollection.dayss.dayoff.forEach((element) {
    days+=approvider.dayData[element].tr+" / ";
  });
  return days;

}

TextStyle textStyle =TextStyle(
    color: Colors.grey,
    fontSize: 15.0,
    fontWeight: FontWeight.bold
);

Widget buildTypeOfMealIfExistInCollection(appProvider appProvider_Instance,String mealType,bool isMealExist) {
  return isMealExist?Text(mealType.tr,
    style: TextStyle(
        color: Colors.grey,
        fontSize: 18.0,
        fontWeight: FontWeight.bold
    ),
  ):Container();
}

InkWell buildCollectionItem(int index, BuildContext context,appProvider appProviderInstance) {
  return InkWell(
    onTap: () {
      appProviderInstance.updateCurrentCollection(appProviderInstance.cuurentprogram.collections[index]);
      Navigator.push(context, MaterialPageRoute(builder: (context) => programdetails(appProviderInstance.cuurentprogram.collections[index],appProviderInstance.choosedprogram,),));
    },

    child: Card(
      margin: EdgeInsets.fromLTRB(10,10,10,10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      child: Container(
        width: MediaQuery.of(context).size.width/1.5,
        decoration: BoxDecoration(
          //  color: Colors.white,
          color: (appProviderInstance.cuurentprogram.collections[index]==appProviderInstance.currentcollection)?Colors.black12:Colors.white,
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Column(
          children: [
            Container(
              height: 170.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                image: DecorationImage(
                    image: NetworkImage(appProviderInstance.cuurentprogram.collections[index].image),
                    fit : BoxFit.fill
                ),
              ),
            ),
            ListTile(
              title: Row(
                children: [
                  Text(
                    "Collection Name : ".tr,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  Text(
                    appProviderInstance.cuurentprogram.collections[index].title,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold
                    ),
                  ),

                ],
              ),
              subtitle: Column(
                children: [
                  Container(

                    child: Row(
                      children: [
                        Text("Collection Description : ".tr,
                            style: textStyle
                        ),
                        Text("${appProviderInstance.cuurentprogram.description}",
                            style: textStyle
                        ),
                      ],
                    ),
                    alignment: Alignment.centerLeft,
                  ),
                  Row(
                    children: [
                      appProviderInstance.cuurentprogram.collections[index].launch?Text("Launch / ".tr,
                          style: textStyle
                      ):Container(),
                      appProviderInstance.cuurentprogram.collections[index].dinner?Text("Dinner / ".tr,
                          style: textStyle
                      ):Container(),
                      appProviderInstance.cuurentprogram.collections[index].breakfast?Text("Break Fast / ".tr,
                          style: textStyle
                      ):Container(),
                      appProviderInstance.cuurentprogram.collections[index].snacks?Text("Snacks".tr,
                          style: textStyle
                      ):Container(),
                    ],
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: [
                        Text("Number Of Days : ".tr,
                            style: textStyle
                        ),
                        Text("${appProviderInstance.cuurentprogram.collections[index].dayss.numodfays}",
                            style: textStyle
                        ),
                        Text(" Days".tr,
                            style: textStyle
                        ),
                      ],
                    ),
                  )
                ],
              ),
              trailing: Text(
                '${appProviderInstance.cuurentprogram.collections[index].price.toString()} KWD',
                style: TextStyle(
                    color: Color(0xff36a9e0),
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold
                ),
              ),
              onTap: (){
                   appProviderInstance.updateCurrentCollection(appProviderInstance.cuurentprogram.collections[index]);
              },
            )
            //checkListTile()
          ],
        ),
      ),
    ),
  );
}

Widget getTextOfData(bool isMealExistInProgram,String text){
  return isMealExistInProgram?Text(text,
    style: TextStyle(
        color: Colors.white70,
        fontSize: 18.0,
        fontWeight: FontWeight.bold
    ),
  ):Container();
}

Card buildProgramItem(BuildContext context, int index, Orientation orientation,appProvider appProviderInstance) {
  return Card(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
    child: GestureDetector(
      child: Container(
        width: MediaQuery.of(context).size.width/1.6,
        decoration: BoxDecoration(
          // color: Colors.white,
          color: (appProviderInstance.cuurentprogram!=null)?(appProviderInstance.cuurentprogram.name==appProviderInstance.programss[index].name)?Colors.black12:Colors.white:Colors.white,
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Column(
          children: [
            Container(
              height:(orientation==Orientation.portrait)? ((MediaQuery.of(context).size.height)*0.31)*0.6-10:((MediaQuery.of(context).size.height)*0.36)*0.6-10,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                image: DecorationImage(
                    image: NetworkImage(appProviderInstance.programss[index].url),
                    fit : BoxFit.fitWidth
                ),
              ),
            ),
            Container(
              child: ListTile(
                title: Text(
                  appProviderInstance.programss[index].name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: (MediaQuery.of(context).size.height)*0.025,
                      fontWeight: FontWeight.bold
                  ),
                ),
                subtitle: Text(
                  'See Collections'.tr,
                  style: TextStyle(
                      color: Color(0xff36a9e0),
                      fontSize: (MediaQuery.of(context).size.height)*0.02,
                      fontWeight: FontWeight.bold
                  ),
                ),
                trailing: Icon(Icons.arrow_downward, color: Color(0xff36a9e0), size: (MediaQuery.of(context).size.height)*0.03),
                onTap: () {
                    appProviderInstance.updateCurrentProgram(appProviderInstance.programss[index]);
                },
              ),
              height: ( (MediaQuery.of(context).size.height)*0.31)*0.4,
            ),

          ],
        ),
      ),
      onTap: () {
        appProviderInstance.updateCurrentProgram(appProviderInstance.programss[index]);
      },
    ),
  );
}

Widget buildButtonInRemainingDaysPage(BuildContext context,dynamic nextPage,String buttonText){
  return InkWell(
    onTap: () {
      Navigator.push(context, MaterialPageRoute(builder: (context) => nextPage,));
    },
    child: Container(

      height: 40,
      width: MediaQuery.of(context).size.width*0.5,
      decoration: BoxDecoration(
          color: Color(0xff36a9e0),
          borderRadius: BorderRadius.all(Radius.circular(20))
      ),
      child: Center(
        child: FittedBox(
          fit: BoxFit.fitWidth,
          child: AutoSizeText(
            buttonText.tr,
            style: TextStyle(color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    ),
  );
}

Widget getRow(BoxConstraints constraints,String leftPart,String rightPart,appProvider x){
  return Expanded(
    child: Row(
      children: [

        Text(leftPart.tr,
          style: TextStyle(
              color: Colors.grey,
              fontSize: 18.0,
              fontWeight: FontWeight.bold
          ),),
        SizedBox(width: 2,),
        Expanded(
          child: AutoSizeText(rightPart,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                color: Colors.grey,
                //fontSize: 18.0,
                fontWeight: FontWeight.bold
            ),),
        ),
      ],
    ),
  );
}

PopupMenuItem<String> buildPopupMenuItem(String text) {
  return PopupMenuItem(
      child: Text(
        text,
        style: TextStyle(
            color: Colors.black,
            fontSize: 15.0,
            fontWeight: FontWeight.bold),
      ),
      value: text);
}

InkWell buildButtonInSummaryPage(appProvider appProvider_Instance, BuildContext context,dynamic nextPage,String buttonText) {
  return InkWell(
    onTap: () {
      appProvider_Instance.startdate=DateTime.now().add(new Duration(days:2));
      appProvider_Instance.enddate=DateTime.now().add(new Duration(days:appProvider_Instance.currentcollection.dayss.numodfays+1));
      if(nextPage.runtimeType==selectmeals){
        appProvider_Instance.resetmeals();
      }
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => nextPage
          ));
    },
    child: Container(
      height: 40,
      width: MediaQuery.of(context).size.width*0.5,
      decoration: BoxDecoration(
          color: Color(0xff36a9e0),
          borderRadius: BorderRadius.all(Radius.circular(20))
      ),
      child: Center(
        child: AutoSizeText(
          buttonText.tr,
          style: TextStyle(color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
      ),
    ),
  );
}