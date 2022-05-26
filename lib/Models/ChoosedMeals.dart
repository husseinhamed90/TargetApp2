// @dart=2.9

import 'Meal.dart';

class Choosedmeals{
int id=0;
int subscribtion_id=0;
List<meal>breakfast_meal;
String breakfast_mealNotes;
List<meal>launch_meal;
List<meal>Snacksmeals;
String launch_mealNotes;
List<meal>dinner_meal;
String dinner_mealNotes;
String Snakcs_mealNotes;

Choosedmeals({this.id, this.subscribtion_id, this.breakfast_meal,
 this.breakfast_mealNotes,
      this.launch_meal,this.launch_mealNotes, this.dinner_meal,this.dinner_mealNotes,this.Snacksmeals,this.Snakcs_mealNotes});
}