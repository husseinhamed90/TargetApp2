import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';
import 'package:target/Modules/CalenderWithMeals/selectmeals.dart';
import 'package:target/Modules/CreateAccount/CreatenewAccount.dart';
import 'package:target/Widgets/buildButtonInRemainingDaysPage.dart';
import 'package:target/providers/AppProvider.dart';

class remainingdays extends StatefulWidget {
  @override
  _remainingdaysState createState() => _remainingdaysState();
}

class _remainingdaysState extends State<remainingdays> {
  bool isSwitched = false;
  @override
  Widget build(BuildContext context) {
    final x =Provider.of<appProvider>(context);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: Padding(
              padding: const EdgeInsets.only(right: 20,top: 20),
              child: Icon(Icons.arrow_back, color:  Color(0xff36a9e0),size: 30,),
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: LayoutBuilder(
          builder: (context, constraints) => Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/bgg.jpg'),
                  fit: BoxFit.fill,
                )
            ),
            child: Center(
              child: Column(
                children: [
                  Container(
                    height: constraints.maxHeight* 0.125,
                    width: MediaQuery.of(context).size.width-70,
                    child: Image.asset(
                      "assets/logo.png",
                      height: constraints.maxHeight * 0.5,

                    ),
                  ),
                  Container(
                    height: constraints.maxHeight * 0.3,
                    child: Column(
                      children: [
                        Container(
                          height: (constraints.maxHeight * 0.2)*1.0,
                          child: AutoSizeText("${DateTime.now().add(new Duration(days:x.currentcollection.dayss.numodfays+1)).difference(DateTime.now()).inDays}",style: TextStyle(
                              fontSize: MediaQuery.of(context).size.height*0.5,
                              color: Color(0xff36a9e0),
                              fontWeight: FontWeight.bold
                          ),),
                        ),
                        Container(
                          height: (constraints.maxHeight * 0.2)*0.3,
                          child: AutoSizeText("Day is Remaining in your Subscription".tr,style: TextStyle(
                              fontSize: constraints.maxHeight*0.025,
                              color: Color(0xff36a9e0),
                              fontWeight: FontWeight.bold
                          ),),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    //height: constraints.maxHeight * 0.2,
                    child: Column(
                      children: [
                        ButtonInRemainingDaysPage( selectmeals(x.currentcollection),"Edit Meals"),
                        SizedBox(height: 10,),
                        ButtonInRemainingDaysPage(createnewaccount(),"Edit Account")

                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        )
    );
  }
}
