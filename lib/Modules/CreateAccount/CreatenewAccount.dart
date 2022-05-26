// @dart=2.9
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location_permissions/location_permissions.dart';
import 'package:provider/provider.dart';
import 'package:target/Models/User.dart';
import 'package:target/Modules/Map/map.dart';
import 'package:target/Modules/Packages/Packages.dart';
import 'package:target/Modules/Summary/Summry.dart';
import 'package:target/providers/AppProvider.dart';


class createnewaccount extends StatefulWidget {
  @override
  _createnewaccountState createState() => _createnewaccountState();
}

class _createnewaccountState extends State<createnewaccount> {
  TextEditingController name = TextEditingController();
  TextEditingController mobile = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController birthdate = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmpassword = TextEditingController();
  TextEditingController day = TextEditingController();
  TextEditingController month = TextEditingController();
  TextEditingController year = TextEditingController();
  TextEditingController block = TextEditingController();
  TextEditingController street = TextEditingController();
  TextEditingController building = TextEditingController();
  TextEditingController Floor = TextEditingController();
  TextEditingController Appointmnet = TextEditingController();
  var gender;

  bool pressed = true;

  double lat=0;
  double lang=0;
  GlobalKey<FormState> emailKey = GlobalKey<FormState>();
  GlobalKey<FormState> passwordKey = GlobalKey<FormState>();
  GlobalKey<FormState> ConfirmPassword = GlobalKey<FormState>();
  GlobalKey<FormState> nameKey = GlobalKey<FormState>();
  GlobalKey<FormState> mobileNumberKey = GlobalKey<FormState>();
  GlobalKey<FormState> streetKey = GlobalKey<FormState>();
  GlobalKey<FormState> apartmentNumberKey = GlobalKey<FormState>();
  GlobalKey<FormState> flatNumberKey = GlobalKey<FormState>();
  GlobalKey<FormState> floorNumberKey = GlobalKey<FormState>();
  GlobalKey<FormState> blockNumberKey = GlobalKey<FormState>();

  final _formKey = GlobalKey<FormState>();

  bool detected = false;

  DateTime birthDate = DateTime(1960);

  String selectedCity = 'Select City'.tr;

  String selectedArea = 'Select Area'.tr;

  //List<Marker> markers = [];

  bool isMapLoading = false;
  @override
  Widget build(BuildContext context) {
    final x = Provider.of<appProvider>(context);
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          title: Text(
            'Create New Account'.tr,
            style: TextStyle(
                color: Color(0xff36a9e0),
                fontSize: 20.0,
                fontWeight: FontWeight.bold),
          ),
          iconTheme: IconThemeData(color: Color(0xff36a9e0), size: 20.0),
        ),
        body: LayoutBuilder(
          builder: (context, constraints) =>Container(

            margin: EdgeInsets.all(10.0),
            child: Form(
              key: _formKey,
              child: ListView(
                scrollDirection: Axis.vertical,
                children: [
                  field('Full Name'.tr, Icons.person, TextInputType.text, false,
                      name, nameKey,(MediaQuery.of(context).size.width)),
                  field('Email Address'.tr, Icons.email, TextInputType.emailAddress,
                      false, email, emailKey,(MediaQuery.of(context).size.width)),
                  Column(
                    children: [
                      field(
                          'Mobile Number'.tr,
                          Icons.phone_android,
                          TextInputType.number,
                          false,
                          mobile,
                          mobileNumberKey,(MediaQuery.of(context).size.width)),
                      Text(
                        'Kindly Note This number will be used for login'.tr,
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 15.0,
                            fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                  field('Password'.tr, Icons.lock, TextInputType.text, pressed,
                      password, passwordKey,(MediaQuery.of(context).size.width)),
                  field('Confirm Password'.tr, Icons.lock, TextInputType.text,
                      pressed, confirmpassword, ConfirmPassword,(MediaQuery.of(context).size.width)),
                  ListTile(
                    title: Text(
                      'Date of Birth'.tr,
                      style: TextStyle(
                          color: Color(0xff36a9e0),
                        // color: Colors.grey,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      '${birthDate.toString().substring(0, 10)}',
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 17.0,
                          fontWeight: FontWeight.bold),
                    ),
                    onTap: () async {
                      var _pickedDate = await showDatePicker(
                        context: context,
                        firstDate: DateTime(1960),
                        lastDate: DateTime(2002),
                        initialDate: DateTime(1960),
                      );
                      if (_pickedDate == null) {
                        setState(() {
                          birthDate = DateTime.now();
                        });
                      } else {
                        setState(() {
                          birthDate = _pickedDate;
                        });
                      }
                    },
                  ),
                  ListTile(
                    title: Text(
                      'City'.tr,
                      style: TextStyle(
                          color: Color(0xff36a9e0),
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      '$selectedCity',
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 17.0,
                          fontWeight: FontWeight.bold),
                    ),
                    trailing: PopupMenuButton(
                      child: Icon(Icons.arrow_downward,
                          color: Color(0xff36a9e0), size: 20.0),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0)),
                      itemBuilder: (BuildContext context) {
                        return <PopupMenuEntry<String>>[
                          PopupMenuItem(
                              child: Text(
                                'Kuwait',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              value: 'Kuwait'),
                          PopupMenuItem(
                              child: Text(
                                'Hawally',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              value: 'Hawally'),
                          PopupMenuItem(
                              child: Text(
                                'Salmiya',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              value: 'Salmiya'),
                          PopupMenuItem(
                              child: Text(
                                'Sharq',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              value: 'Sharq'),
                        ];
                      },
                      onSelected: (String value) {
                        setState(() {
                          selectedCity = value;
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: Text(
                      'Area'.tr,
                      style: TextStyle(
                          color: Color(0xff36a9e0),
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      '$selectedArea',
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 17.0,
                          fontWeight: FontWeight.bold),
                    ),
                    trailing: PopupMenuButton(
                      child: Icon(Icons.arrow_downward,
                          color: Color(0xff36a9e0), size: 20.0),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0)),
                      itemBuilder: (BuildContext context) {
                        return <PopupMenuEntry<String>>[
                          PopupMenuItem(
                              child: Text(
                                'Kuwait',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              value: 'Kuwait'),
                          PopupMenuItem(
                              child: Text(
                                'Hawally',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              value: 'Hawally'),
                          PopupMenuItem(
                              child: Text(
                                'Salmiya',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              value: 'Salmiya'),
                          PopupMenuItem(
                              child: Text(
                                'Sharq',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              value: 'Sharq'),
                        ];
                      },
                      onSelected: (String value) {
                        setState(() {
                          selectedArea = value;
                        });
                      },
                    ),
                  ),
                   Row(
                     mainAxisAlignment: MainAxisAlignment.spaceAround,
                       children: [
                         field('Address Street'.tr, Icons.location_city, TextInputType.text,
                             false, street, streetKey,(MediaQuery.of(context).size.width-50)*0.9),

                         Container(
                           width: (MediaQuery.of(context).size.width-50)*0.1,
                           child: IconButton(icon: Icon(Icons.add_location_rounded,color: Color(0xff36a9e0),), onPressed:()async{
                             Navigator.push(context, MaterialPageRoute(builder: (context) => map()));
                           }),
                         ),


                       ],
                  ),
                  LayoutBuilder(
                    builder: (context, constraints) => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        field('Block Number'.tr, Icons.home, TextInputType.number, false,
                            block, blockNumberKey,constraints.maxWidth*0.45),
                        field('Building Number'.tr, Icons.apartment, TextInputType.number,
                            false, building, apartmentNumberKey,constraints.maxWidth*0.45),
                      ],
                    ),
                  ),
                  LayoutBuilder(
                   builder: (context, constraintss) =>  Container(
                     child: Row(
                       mainAxisAlignment: MainAxisAlignment.spaceAround,
                       children: [
                         field('Floor Number'.tr, Icons.home, TextInputType.number, false,
                             Floor, floorNumberKey,constraintss.maxWidth*0.45),
                         field('Flat Number'.tr, Icons.home, TextInputType.number, false,
                             Appointmnet, flatNumberKey,constraintss.maxWidth*0.45),

                       ],
                     ),
                   ),
                 ),
                  // Builder(builder: (BuildContext context) {
                  //   return FlatButton(
                  //     shape: RoundedRectangleBorder(
                  //         borderRadius: BorderRadius.circular(15.0)),
                  //     color: Color(0xff36a9e0),
                  //     child: Text(
                  //       'Get My Location'.tr,
                  //       style: TextStyle(
                  //           color: Colors.white,
                  //           fontSize: 20.0,
                  //           fontWeight: FontWeight.bold),
                  //     ),
                  //     onPressed: () {
                  //       Navigator.push(context, MaterialPageRoute(builder: (context) => map()));
                  //       //getcurrentlocation();
                  //     },
                  //   );
                  // }),
                  Builder(builder: (BuildContext context) {
                    return FlatButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0)),
                      color: Color(0xff36a9e0),
                      child: Text(
                        'Sign Up'.tr,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold),
                      ),
                      onPressed: () {
                        if (!_formKey.currentState.validate()) {
                          Scaffold.of(context)
                              .showSnackBar(snack('fields Required!'.tr));
                        } else {
                          User user = User(
                              name.text,
                              mobile.text,
                              email.text,
                              birthDate,
                              gender,
                              password.text,
                              confirmpassword.text,
                              selectedCity,
                              selectedArea,
                              (block.text == "") ? "" : block.text,
                              (Floor.text == "") ? "" : Floor.text,
                              (Appointmnet.text == "") ? "" : Appointmnet.text,
                              (building.text == "") ? "" : building.text,
                              street.text);
                          x.updateuser(user);
                          print(x.currentcollection.description);
                          if (x.currentcollection != null) {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Summry(),
                                ));
                          } else {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Packages(),
                                ));
                          }
                          return Navigator.push(context,
                              MaterialPageRoute(builder: (_) {
                            return Summry();
                          }));
                        }
                      },
                    );
                  }),


                ],
              ),
            ),
          ),
        ));
  }
  Future<Geolocator> getcurrentlocation() async{
    Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high).then((value) {
      setState(() {
        detected=true;
        lat=value.latitude;
        lang=value.longitude;
        print(lat);
        print(lang);
      });

    });

  }
  field(String label, IconData icon, TextInputType type, bool obsecure,
      TextEditingController controller, Key key,double width) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: width,
        child: TextFormField(
          key: key,
          validator: (value) {
            if (label == "Full Name".tr || label == "Mobile Number".tr ) {
              if (value.isEmpty) {
                return 'This Field required?'.tr;
              } else {
                return null;
              }
            }
            else if(label == "Password".tr){
              if (value.isEmpty) {
                return "This Field required?".tr;
              } else {
                if (value.length<6) {
                  print(value);
                  print(password.text);
                  return "Password must be at least 6 characters".tr;
                } else {
                  return null;
                }
              }
            }


            else if (label == "Confirm Password".tr) {
              if (value.isEmpty) {
                return "This Field required?".tr;
              } else {
                if (value != password.text) {
                  print(value);
                  print(password.text);
                  return "Passwords not matched".tr;
                } else {
                  return null;
                }
              }
            } else {
              return null;
            }
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
            suffixIcon: label == 'Password'.tr
                ? IconButton(
                    icon:!pressed ?Icon(Icons.remove_red_eye):Icon(Icons.visibility_off),
                    color: Colors.grey,
                    iconSize: 20.0,
                    onPressed: () {
                      setState(() {
                        pressed = !pressed;
                      });
                    })
                : null,
          ),
          textInputAction: TextInputAction.done,
          keyboardType: type,
          obscureText: obsecure,
          controller: controller,
        ),
      ),
    );
  }

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
}
