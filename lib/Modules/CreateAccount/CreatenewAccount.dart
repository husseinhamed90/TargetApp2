// @dart=2.9
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
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
import 'package:target/shared/components.dart';


class createnewaccount extends StatefulWidget {
  @override
  _createnewaccountState createState() => _createnewaccountState();
}

class _createnewaccountState extends State<createnewaccount> {



  double lat = 0;
  double lang = 0;
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

  appProvider appProviderInstance;

  void initState() {
    appProviderInstance = Provider.of<appProvider>(context, listen: false);
    if (appProviderInstance.user != null) {
      appProviderInstance.gender = appProviderInstance.user.gender;
      appProviderInstance.name.text = appProviderInstance.user.name;
      appProviderInstance.mobile.text = appProviderInstance.user.mobilenumber;
      appProviderInstance.email.text = appProviderInstance.user.email;
      appProviderInstance.password.text = appProviderInstance.user.password;
      appProviderInstance.confirmpassword.text =
          appProviderInstance.user.confirmpassword;
      appProviderInstance.birthDate = appProviderInstance.user.birthdate;
      appProviderInstance.block.text =
          appProviderInstance.user.block.toString();
      appProviderInstance.Floor.text =
          appProviderInstance.user.Floor.toString();
      appProviderInstance.Appointmnet.text =
          appProviderInstance.user.Appointment.toString();
      appProviderInstance.building.text =
          appProviderInstance.user.Building.toString();
      appProviderInstance.street.text = appProviderInstance.user.Street;
      appProviderInstance.selectedCity = appProviderInstance.user.city;
      appProviderInstance.selectedArea = appProviderInstance.user.area;
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          title: Text(
            (appProviderInstance.user == null)
                ? 'Create New Account'.tr
                : 'Your Data'.tr,
            style: TextStyle(
                color: Color(0xff36a9e0),
                fontSize: 20.0,
                fontWeight: FontWeight.bold),
          ),
          iconTheme: IconThemeData(color: Color(0xff36a9e0), size: 20.0),
        ),
        body: LayoutBuilder(
          builder: (context, constraints) =>
              Container(

                margin: EdgeInsets.all(10.0),
                child: Form(
                  key: _formKey,
                  child: ListView(
                    scrollDirection: Axis.vertical,
                    children: [
                      field('Full Name'.tr, Icons.person, TextInputType.text, appProviderInstance.name, nameKey, (MediaQuery.of(context).size.width), appProviderInstance),
                      field('Email Address'.tr, Icons.email, TextInputType.emailAddress, appProviderInstance.email, emailKey, (MediaQuery.of(context).size.width), appProviderInstance),
                      Column(
                        children: [
                          field('Mobile Number'.tr, Icons.phone_android, TextInputType.number, appProviderInstance.mobile, mobileNumberKey, (MediaQuery.of(context).size.width), appProviderInstance),
                          Text(
                            'Kindly Note This number will be used for login'.tr,
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: 15.0,
                                fontWeight: FontWeight.normal),
                          ),
                        ],
                      ),
                      field('Password'.tr, Icons.lock, TextInputType.text, appProviderInstance.password, passwordKey, (MediaQuery.of(context).size.width), appProviderInstance),
                      field('Confirm Password'.tr, Icons.lock, TextInputType.text, appProviderInstance.confirmpassword, ConfirmPassword, (MediaQuery.of(context).size.width), appProviderInstance),
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
                          '${appProviderInstance.birthDate.toString().substring(0, 10)}',
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
                              appProviderInstance.birthDate = DateTime.now();
                            });
                          } else {
                            setState(() {
                              appProviderInstance.birthDate = _pickedDate;
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
                          '${appProviderInstance.selectedCity}',
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
                              appProviderInstance.selectedCity = value;
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
                          '${appProviderInstance.selectedArea}',
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
                              appProviderInstance.selectedArea = value;
                            });
                          },
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ValueListenableBuilder<String>(
                            valueListenable: appProviderInstance
                                .userAddressName,

                            builder: (context, value, _) {
                              Future.delayed(Duration.zero, () {
                                appProviderInstance.street.text = value;
                                return Container();
                              });
                              return field(
                                  'Address Street'.tr,
                                  Icons.location_city,
                                  TextInputType.text,
                                  appProviderInstance.street,
                                  streetKey,
                                  (MediaQuery
                                      .of(context)
                                      .size
                                      .width - 50) * 0.9,
                                  appProviderInstance);
                              //return Flexible(child: AutoSizeText(value));
                            },
                          ),
                          Container(
                            width: (MediaQuery
                                .of(context)
                                .size
                                .width - 50) * 0.1,
                            child: IconButton(icon: Icon(
                              Icons.add_location_rounded, color: Color(
                                0xff36a9e0),), onPressed: () async {
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (context) => map()));
                              // getcurrentlocation();
                            }),
                          )
                        ],
                      ),
                      LayoutBuilder(
                        builder: (context, constraints) =>
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                field(
                                    'Block Number'.tr,
                                    Icons.home,
                                    TextInputType.number,
                                    appProviderInstance.block,
                                    blockNumberKey,
                                    constraints.maxWidth * 0.45,
                                    appProviderInstance),

                                field(
                                    'Building Number'.tr,
                                    Icons.apartment,
                                    TextInputType.number,
                                    appProviderInstance.building,
                                    apartmentNumberKey,
                                    constraints.maxWidth * 0.45,
                                    appProviderInstance),
                              ],
                            ),
                      ),
                      LayoutBuilder(
                        builder: (context, constraintss) =>
                            Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceAround,
                                children: [
                                  field(
                                      'Floor Number'.tr,
                                      Icons.home,
                                      TextInputType.number,
                                      appProviderInstance.Floor,
                                      floorNumberKey,
                                      constraintss.maxWidth * 0.45,
                                      appProviderInstance),
                                  field(
                                      'Flat Number'.tr,
                                      Icons.home,
                                      TextInputType.number,
                                      appProviderInstance.Appointmnet,
                                      flatNumberKey,
                                      constraintss.maxWidth * 0.45,
                                      appProviderInstance),
                                ],
                              ),
                            ),
                      ),
                      FlatButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0)),
                        color: Color(0xff36a9e0),
                        child: Text(
                          (appProviderInstance.user == null)
                              ? 'Sign Up'.tr
                              : 'Update Profile'.tr,
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

                            appProviderInstance.updateuser();
                            if (appProviderInstance.currentcollection !=
                                null) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Summry(),
                                  ));
                            } else {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Packages(),
                                  ));
                            }
                          }
                        },
                      )
                    ],
                  ),
                ),
              ),
        ));
  }

  Future<Geolocator> getcurrentlocation() async {

    Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high).then((
        value) async {
      lat = value.latitude;
      lang = value.longitude;
      final coordinates = new Coordinates(lat, lang);
      final addresses = await Geocoder.local.findAddressesFromCoordinates(
          coordinates);
      setState(() {
        appProviderInstance.setUserAddressName(addresses.first.addressLine);
      //  detected = true;
      });
    });
  }
}
