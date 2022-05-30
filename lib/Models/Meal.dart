// @dart=2.9

import 'package:target/Models/Categories.dart';

class meal{
  int id=0;
  String name="";
  String url="";
  String description="";
  Categories mealcategory=Categories.none;
  int quantity=0;
  DateTime _mealdate;
  bool isNoteExist =false;
  String note;
  meal(this.id, this.name, this.description, this.mealcategory,this.url);
  meal.withdate(this.id, this.name, this.description, this.mealcategory,this.url,this._mealdate);


  DateTime get mealdate => _mealdate;

}