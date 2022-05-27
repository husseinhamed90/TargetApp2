import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:target/Models/Collection.dart';
import 'package:target/providers/AppProvider.dart';

snack(String content) {
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
Widget item(String title, String subtitle,bool iscouponapplied,Collection currentcollection) {
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
            "${currentcollection.price*((100-50)/100)} KWD",
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
