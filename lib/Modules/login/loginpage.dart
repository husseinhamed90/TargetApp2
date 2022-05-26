import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';
import 'package:target/Modules/RemainingDays/remainingdays.dart';
import 'package:target/providers/AppProvider.dart';

import '../profile/profile.dart';
class loginpage extends StatefulWidget {
  @override
  _loginpageState createState() => _loginpageState();
}

class _loginpageState extends State<loginpage> {
  TextEditingController numberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  GlobalKey<FormState> numberKey = GlobalKey<FormState>();
  GlobalKey<FormState> passwordKey = GlobalKey<FormState>();

  var _formKey = GlobalKey<FormState>();
  bool secure = true;

  @override
  Widget build(BuildContext context) {
    appProvider x = Provider.of<appProvider>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        title: Text(
          'Login'.tr,
          style: TextStyle(
              color: Color(0xff36a9e0),
              fontSize: 20.0,
              fontWeight: FontWeight.bold),
        ),
        iconTheme: IconThemeData(color: Color(0xff36a9e0), size: 20.0),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                width: MediaQuery.of(context).size.width-70,
                child: Image.asset(
                  "assets/logo.jpg",
                  height: MediaQuery.of(context).size.height * 0.5,

                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width-70,
                color: Colors.white,
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          Container(
                            alignment: Alignment.center,

                            width: MediaQuery.of(context).size.width - 70,
                            child: Column(
                              children: [
                                field('Mobile'.tr, Icons.phone, false, TextInputType.number, numberController, numberKey),
                                field('Password'.tr, Icons.lock, secure, TextInputType.text, passwordController, passwordKey),
                              ],
                            ),
                          ),
                        ],
                      ),
                      ElevatedButton(
                        onPressed: () {
                          x.getmeals();
                          if(_formKey.currentState.validate()){
                            if(x.validateusernameandpassword(numberController.text,passwordController.text)){
                              if(x.currentcollection!=null && x.startdate!=null && x.enddate!=null){
                                x.startdate=DateTime.now().add(new Duration(days:2));
                                x.enddate=DateTime.now().add(new Duration(days:x.currentcollection.dayss.numodfays+1));
                                print(x.startdate);
                                print(x.enddate);
                                Navigator.push(context, MaterialPageRoute(builder: (context) => remainingdays(),));
                              }
                            }
                          }
                        },
                        child:Text('Login'.tr, style: TextStyle(color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.bold),)
                        ,style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Color(0xff36a9e0)),
                      ),
                      ),
                      Row(
                        children: [
                          Spacer(),
                          TextButton(
                              onPressed: () {},
                              child: Text("Forget Password".tr)),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  field(String label, IconData icon, bool secured, TextInputType type, TextEditingController controller, Key key) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
          key: key,
          validator: (value){
            if(value.isEmpty){
              return 'required'.tr;
            }else{
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
                icon:!secure ?Icon(Icons.remove_red_eye):Icon(Icons.visibility_off),
                color: Colors.grey,
                onPressed: () {
                  setState((){
                    secure = !secure;
                  });
                },
              ) : null,
              labelText: label
          ),
          textInputAction: TextInputAction.done,
          keyboardType: type,
          obscureText: secured,
          controller: controller
      ),
    );
  }
}
