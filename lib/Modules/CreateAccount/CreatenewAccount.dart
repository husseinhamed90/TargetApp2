// @dart=2.9
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
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
      appProviderInstance.confirmpassword.text = appProviderInstance.user.confirmPassword;
      appProviderInstance.birthDate = appProviderInstance.user.birthdate;
      appProviderInstance.block.text = appProviderInstance.user.block.toString();
      appProviderInstance.Floor.text = appProviderInstance.user.Floor.toString();
      appProviderInstance.Appointmnet.text = appProviderInstance.user.Appointment.toString();
      appProviderInstance.building.text = appProviderInstance.user.Building.toString();
      appProviderInstance.street.text = appProviderInstance.user.Street;
      appProviderInstance.selectedCity = appProviderInstance.user.city;
      appProviderInstance.selectedArea = appProviderInstance.user.area;
    }
    else{
      Future.delayed(Duration.zero, () {
        appProviderInstance.resetTextFields();
      });
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
          builder: (context, constraints) => Container(
                margin: EdgeInsets.all(10.0),
                child: Form(
                  key: _formKey,
                  child: ListView(
                    scrollDirection: Axis.vertical,
                    children: [
                      buildField('Full Name'.tr, Icons.person, TextInputType.text, appProviderInstance.name, nameKey, (MediaQuery.of(context).size.width), appProviderInstance),
                      buildField('Email Address'.tr, Icons.email, TextInputType.emailAddress, appProviderInstance.email, emailKey, (MediaQuery.of(context).size.width), appProviderInstance),
                      Column(
                        children: [
                          buildField('Mobile Number'.tr, Icons.phone_android, TextInputType.number, appProviderInstance.mobile, mobileNumberKey, (MediaQuery.of(context).size.width), appProviderInstance),
                          Text(
                            'Kindly Note This number will be used for login'.tr,
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: 15.0,
                                fontWeight: FontWeight.normal),
                          ),
                        ],
                      ),
                      buildField('Password'.tr, Icons.lock, TextInputType.text, appProviderInstance.password, passwordKey, (MediaQuery.of(context).size.width), appProviderInstance),
                      buildField('Confirm Password'.tr, Icons.lock, TextInputType.text, appProviderInstance.confirmpassword, ConfirmPassword, (MediaQuery.of(context).size.width), appProviderInstance),
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
                              buildPopupMenuItem('Kuwait'),
                              buildPopupMenuItem('Hawally'),
                              buildPopupMenuItem('Salmiya'),
                              buildPopupMenuItem('Sharq'),
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
                              buildPopupMenuItem('Kuwait'),
                              buildPopupMenuItem('Hawally'),
                              buildPopupMenuItem('Salmiya'),
                              buildPopupMenuItem('Sharq'),
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
                            valueListenable: appProviderInstance.userAddressName,
                            builder: (context, value, _) {
                              Future.delayed(Duration.zero, () {
                                appProviderInstance.street.text = value;
                                return Container();
                              });
                              return buildField(
                                  'Address Street'.tr,
                                  Icons.location_city,
                                  TextInputType.text,
                                  appProviderInstance.street,
                                  streetKey,
                                  (MediaQuery.of(context).size.width - 50) * 0.9, appProviderInstance);
                              //return Flexible(child: AutoSizeText(value));
                            },
                          ),
                          IconButton(icon: Icon(
                            Icons.add_location_rounded, color: Color(
                              0xff36a9e0),), onPressed: () async {
                            Navigator.push(context, MaterialPageRoute(
                                builder: (context) => map()));
                          })
                        ],
                      ),
                      LayoutBuilder(
                        builder: (context, constraints) =>
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                buildField(
                                    'Block Number'.tr,
                                    Icons.home,
                                    TextInputType.number,
                                    appProviderInstance.block,
                                    blockNumberKey,
                                    constraints.maxWidth * 0.45,
                                    appProviderInstance),

                                buildField(
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
                                  buildField(
                                      'Floor Number'.tr,
                                      Icons.home,
                                      TextInputType.number,
                                      appProviderInstance.Floor,
                                      floorNumberKey,
                                      constraintss.maxWidth * 0.45,
                                      appProviderInstance),
                                  buildField(
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
                      // ignore: deprecated_member_use
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
                            // ignore: deprecated_member_use
                            Scaffold.of(context).showSnackBar(buildSnackBar('fields Required!'.tr));
                          } else {
                            appProviderInstance.updateUser();
                            if (appProviderInstance.currentcollection != null) {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => Summry(),));
                            } else {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => Packages(),));
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
}