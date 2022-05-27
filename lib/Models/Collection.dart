// @dart=2.9


import 'package:target/Models/Days.dart';

import 'User.dart';

class Collection{

  //int id =0;
  User user;
  String title="";
  String description ="";
  String image ="";
  int price=0;
  //DateTime created_date =DateTime.now();
  int program_id=0;
  bool breakfast=false;
  bool launch =false;
  bool dinner =false;
  bool snacks=false;
  int number_of_snacks=0 ;
  int days_id =0;
  int discount_id=0;
  days dayss;
  String breakFastMeal(){
    if(breakfast){
      return "BreakFast";
    }
    else{
      return "";
    }
  }
  String Dinnereal(){
    if(dinner){
      return "Dinner";
    }
    else{
      return "";
    }
  }
  String launchmeal(){
    if(launch){
      return "Launch";
    }
    else{
      return "";
    }
  }
  String snacksmeal(){
    if(snacks){
      return "Snacks";
    }
    else{
      return "";
    }
  }


  Collection(
     // this.id,
      this.title,
      this.description,
      this.image,
      this.price,
     // this.created_date,
      this.program_id,
      this.breakfast,
      this.launch,
      this.dinner,
      this.snacks,
      this.number_of_snacks,
      this.days_id,
      this.discount_id);

  Collection.usingObjects(
      this.title,
      this.description,
      this.image,
      this.price,
      this.program_id,
      this.breakfast,
      this.launch,
      this.dinner,
      this.snacks,
      this.number_of_snacks,
      this.dayss,
      this.discount_id);
}
