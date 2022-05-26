// @dart=2.9
import 'package:get/get.dart';
class User{
  //int id=0;
  String name="";
  String mobilenumber="";
  String email="";
  DateTime birthdate;
  // int bithdateday;
  // String bithdatemonth='January'.tr;
  // int birthdateyear;
  String gender="male";
  String password="";
  String confirmpassword="";
  String city="";
  String area="";
 // String address="";
  //String map_address_pin="";
  String block="";
  String Floor="";
  String Appointment="";
  String Street="";
  String Building="";

  User(
   //   this.id,
      this.name,
      this.mobilenumber,
      this.email,
      this.birthdate,
      // this.bithdateday,
      // this.bithdatemonth,
      // this.birthdateyear,
      this.gender,
      this.password,
      this.confirmpassword,
      this.city,
      this.area,
      this.block,
      this.Floor,
      this.Appointment,
      this.Building,
      this.Street,);
  //    this.address,
      //this.map_address_pin);

}