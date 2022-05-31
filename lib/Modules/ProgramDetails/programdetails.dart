import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';
import 'package:target/Models/Collection.dart';
import 'package:target/Modules/CreateAccount/CreatenewAccount.dart';
import 'package:target/providers/AppProvider.dart';
import 'package:target/shared/components.dart';


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
    final appProviderInstance =Provider.of<appProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text('Collection Details'.tr,style: TextStyle(

        color: Colors.blue

        ),),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color:Color(0xff36a9e0),size: 30,),
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
                    item('Collection Name'.tr, widget.currentcollection.title,iscouponapplied,widget.currentcollection),
                    item('Target Name'.tr, appProviderInstance.cuurentprogram.name,iscouponapplied,widget.currentcollection),
                    item('Collection Days'.tr, "${widget.currentcollection.dayss.numodfays}",iscouponapplied,widget.currentcollection),
                    item('Off Days'.tr, "${appProviderInstance.getDays(appProviderInstance)}",iscouponapplied,widget.currentcollection),

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
                          getTextOfData(widget.currentcollection.launch,"Launch / ".tr),
                          getTextOfData(widget.currentcollection.dinner,"Dinner / ".tr),
                          getTextOfData(widget.currentcollection.breakfast,"Break Fast / ".tr),
                          getTextOfData(widget.currentcollection.snacks,"Snacks / ".tr),
                        ],
                      ),
                    ),
                    item('Collection Fee : '.tr, '${widget.currentcollection.price} KWD',iscouponapplied,widget.currentcollection),
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
                                validatePromoCode(appProviderInstance, context);
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
                            appProviderInstance.resetmeals();
                            if(widget.currentcollection.launch){
                              appProviderInstance.launchcheckedValue=true;
                            }
                            if(widget.currentcollection.dinner){
                              appProviderInstance.dinnercheckedValue=true;
                            }
                            if(widget.currentcollection.breakfast){
                              appProviderInstance.breakfastcheckedValue=true;
                            }
                            if(widget.currentcollection.snacks){
                              appProviderInstance.snackscheckedValue=true;
                            }
                            appProviderInstance.updateCollection(widget.currentcollection);
                            appProviderInstance.startdate=DateTime.now().add(new Duration(days:2));
                            appProviderInstance.enddate=DateTime.now().add(new Duration(days:appProviderInstance.currentcollection.dayss.numodfays+1));
                            Navigator.push(context, MaterialPageRoute(builder: (context) => createnewaccount()));
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

  void validatePromoCode(appProvider appProviderInstance, BuildContext context) {
    if(promoController.text!=""){

      if(appProviderInstance.isCouponValid(promoController.text)){
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
  }

}