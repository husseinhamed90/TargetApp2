// @dart=2.9


import 'package:target/Models/ChoosedMeals.dart';
import 'package:target/Models/User.dart';

import 'Collection.dart';

class Subscription{
  int id=0;
  int userid=0;
  User user;
  int collectionid=0;
  DateTime subcribe_date=DateTime.now();
  int choosedmeal=0;
  DateTime start_programe_date=DateTime.now().add(new Duration(days:2));
  DateTime end_programe_date;
  bool expired=true;
  Choosedmeals choosedmeals;
  Collection mycollection;

  Subscription(
      this.id,
      this.userid,
      this.collectionid,
      this.subcribe_date,
      this.choosedmeal,
      this.start_programe_date,
      this.end_programe_date,
      this.expired,
      this.mycollection,
      this.choosedmeals,
      this.user);




  Subscription.withoutid(this.user, this.mycollection,
      this.choosedmeals, this.expired,this.start_programe_date,
      this.end_programe_date, this.subcribe_date,);



}