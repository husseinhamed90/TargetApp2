import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';
import 'package:target/Models/Collection.dart';
import 'package:target/Modules/CalenderWithMeals/selectmeals.dart';
import 'package:target/providers/AppProvider.dart';


class programdetails extends StatefulWidget {
  Collection currentcollection;
  String currentprogram;
  programdetails(this.currentcollection,this.currentprogram);
  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<programdetails> {
  double newprice;
  final TextEditingController promoController = TextEditingController();
  bool iscouponapplied=false;

  @override
  Widget build(BuildContext context) {
    final x =Provider.of<appProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text('Collection Details'.tr,style: TextStyle(

        color: Colors.blue

        ),),
        leading: IconButton(
          icon: Padding(
            padding: const EdgeInsets.only(right: 40,top: 10),
            child: Icon(Icons.arrow_back, color:  Color(0xff36a9e0),size: 30,),
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      backgroundColor: Colors.white,
      body: LayoutBuilder(
        builder: (context, constraints) =>  Container(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Spacer(),
              SafeArea(
                top: true,
                child: Container(
                  height: constraints.maxHeight*0.35,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    image: DecorationImage(
                      image: NetworkImage(widget.currentcollection.image),
                    ),
                  ),
                ),
              ),
              Container(
                height: constraints.maxHeight*0.65,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(30.0), topRight: Radius.circular(30.0)),
                  color: Color(0xff36a9e0),
                ),
                child: ListView(
                  //  mainAxisSize: MainAxisSize.max,
                  scrollDirection: Axis.vertical,
                  children: [
                    // Align(
                    //   alignment: Alignment.topCenter,
                    //   child: Padding(
                    //     padding: const EdgeInsets.only(top: 15),
                    //     child: Text(
                    //       'Collection Details'.tr,
                    //       style: TextStyle(color: Colors.white, fontSize: 25.0, fontWeight: FontWeight.bold),
                    //     ),
                    //   ),
                    // ),
                    item('Collection Name'.tr, widget.currentcollection.title),
                    item('Target Name'.tr, widget.currentprogram),
                    item('Collection Days'.tr, "${widget.currentcollection.dayss.numodfays}"),
                    item('Off Days'.tr, "${getDays(x)}"),
                    //item('Collection Meals', 'Breakfast, Launch, Dinner & Snacks'),
                    ListTile(
                      title: Text(
                        "Collection Meals".tr,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      subtitle:  Row(
                        children: [

                          widget.currentcollection.launch?Text("Launch / ".tr,
                            style: TextStyle(
                                color: Colors.white70,
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold
                            ),
                          ):Container(),
                          widget.currentcollection.dinner?Text("Dinner / ".tr,
                            style: TextStyle(
                                color: Colors.white70,
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold
                            ),
                          ):Container(),
                          widget.currentcollection.breakfast?Text("Break Fast / ".tr,
                            style: TextStyle(
                                color: Colors.white70,
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold
                            ),
                          ):Container(),
                          widget.currentcollection.snacks?Text("Snacks".tr,
                            style: TextStyle(
                                color: Colors.white70,
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold
                            ),
                          ):Container(),
                        ],
                      ),
                    ),
                    item('Collection Fee : '.tr, '${widget.currentcollection.price} KWD'),
                    Padding(
                      padding: const EdgeInsets.only(bottom:15.0,left: 10,right: 10),
                      child: Container(
                        width: MediaQuery.of(context).size.width-40,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [

                            Container(
                              height: 40,
                              width: constraints.maxWidth-100,
                              child: TextField(
                                style: TextStyle(
                                    color: Colors.white.withOpacity(0.7)
                                ),
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15.0),
                                        borderSide: BorderSide(color: Colors.white, width: 1.5)
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15.0),
                                        borderSide: BorderSide(color: Colors.white, width: 1.5)
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15.0),
                                        borderSide: BorderSide(color: Colors.white, width: 1.5)
                                    ),
                                    labelText: 'Add Promo Code'.tr,
                                    suffixIcon: (iscouponapplied)?IconButton(icon: Icon(Icons.clear,color: Colors.white), onPressed:() {
                                      setState(() {
                                        iscouponapplied=false;
                                      });
                                    },):null,
                                    labelStyle: TextStyle(color: Colors.white)
                                ),
                                textInputAction: TextInputAction.done,
                                keyboardType: TextInputType.text,
                                controller: promoController,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                if(promoController.text!=""){

                                  if(x.iscouponvalid(promoController.text)){
                                    setState(() {
                                      iscouponapplied=true;
                                      newprice=widget.currentcollection.price*((100-50)/100);
                                    });
                                  }
                                  else{
                                    ScaffoldMessenger.of(context).showSnackBar( SnackBar(
                                      content: Text("Invalid coupon"),
                                      backgroundColor: Colors.red,
                                    ));
                                  }

                                }

                              },
                              child: Container(

                                height: 40,
                                width: (MediaQuery.of(context).size.width-40)*0.2,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.all(Radius.circular(15))
                                ),
                                child: Center(
                                  child: AutoSizeText(
                                    "Apply".tr,
                                    style: TextStyle(color: Color(0xff36a9e0), fontSize: 20.0, fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        InkWell(
                          onTap: () {
                            x.resetmeals();
                            if(widget.currentcollection.launch){
                              x.launchcheckedValue=true;
                            }
                            if(widget.currentcollection.dinner){
                              x.dinnercheckedValue=true;
                            }
                            if(widget.currentcollection.breakfast){
                              x.breakfastcheckedValue=true;
                            }
                            if(widget.currentcollection.snacks){
                              x.snackscheckedValue=true;
                            }
                            x.updatecCollection(widget.currentcollection);
                            x.startdate=DateTime.now().add(new Duration(days:2));
                            x.enddate=DateTime.now().add(new Duration(days:x.currentcollection.dayss.numodfays+1));
                            Navigator.push(context, MaterialPageRoute(builder: (context) => selectmeals(widget.currentcollection)));
                            // if(x.user!=null){
                            //   x.updatecCollection(widget.currentcollection);
                            //   Navigator.push(context, MaterialPageRoute(builder: (context) => Summry(),));
                            // }
                            // else{
                            x.updatecCollection(widget.currentcollection);
                            x.startdate=DateTime.now().add(new Duration(days:2));
                            x.enddate=DateTime.now().add(new Duration(days:x.currentcollection.dayss.numodfays+1));
                            Navigator.push(context, MaterialPageRoute(builder: (context) => selectmeals(widget.currentcollection)));

                          },
                          child: Container(

                            height: 40,
                            width: 100,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(Radius.circular(20))
                            ),
                            child: Center(
                              child: AutoSizeText(
                                "Subscribe".tr,
                                style: TextStyle(color: Color(0xff36a9e0), fontSize: 20.0, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                padding: const EdgeInsets.only(bottom: 15),

              ),
            ],
          ),
        ),
      ),
    );
  }
  String getDays(appProvider approvider){
    String days ="";
    print(widget.currentcollection.dayss.dayoff);
    widget.currentcollection.dayss.dayoff.forEach((element) {
      days+=approvider.dayData[element].tr+" / ";
    });
    return days;

  }
  item(String title, String subtitle) {
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
                (iscouponapplied)?Positioned(right: 0,top: 7,child: Container(width: 70,height: 2,color: Colors.white,)):Container()
              ],
            ),
            SizedBox(width: 10,),
            (iscouponapplied)?AutoSizeText(
              "${newprice.toString()} KWD",
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
}