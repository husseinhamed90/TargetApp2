import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:target/providers/AppProvider.dart';

class ChangeLang extends StatefulWidget {
  @override
  _ChangeLangState createState() => _ChangeLangState();
}

class _ChangeLangState extends State<ChangeLang> {

  String lang = 'EN';
  @override
  Widget build(BuildContext context) {
    final appProviderInstance =Provider.of<appProvider>(context);
    lang= (appProviderInstance.language=='ar')?"ar":"en";
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Color(0xff36a9e0),
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: PopupMenuButton(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '$lang',
                  style: TextStyle(color: Colors.white, fontSize: 15.0),
                ),
                Icon(Icons.arrow_drop_down, color: Colors.white, size: 20.0),
              ],
            ),
          ),
          itemBuilder: (BuildContext context){
            return <PopupMenuEntry<String>>[
              PopupMenuItem(
                child: Text(
                  'English',
                  style: TextStyle(color: Colors.black, fontSize: 15.0),
                ),
                value: 'en',
              ),
              PopupMenuItem(
                child: Text(
                  'Arabic',
                  style: TextStyle(color: Colors.black, fontSize: 15.0),
                ),
                value: 'ar',
              ),
            ];
          },
          onSelected: (value){
            setState((){
              if(value=="en"){
                Get.updateLocale(Locale('en'));
              }
              else{
                Get.updateLocale(Locale('ar'));
              }
              appProviderInstance.language=value;
              appProviderInstance.setlanguagetopref(appProviderInstance.language);
              lang = value;
            });
          }
      ),
    );
  }
}