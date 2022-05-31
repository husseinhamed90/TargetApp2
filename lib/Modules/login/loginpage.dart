import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';
import 'package:target/Modules/RemainingDays/remainingdays.dart';
import 'package:target/providers/AppProvider.dart';
import 'package:target/shared/components.dart';

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
    appProvider appProviderInstance = Provider.of<appProvider>(context);
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
                                loginField('Mobile'.tr, Icons.phone, false, TextInputType.number, numberController, numberKey,appProviderInstance),
                                loginField('Password'.tr, Icons.lock, secure, TextInputType.text, passwordController, passwordKey,appProviderInstance),
                              ],
                            ),
                          ),
                        ],
                      ),
                      ElevatedButton(
                        onPressed: () {
                          appProviderInstance.getMeals();
                          if(_formKey.currentState.validate()){
                            if(appProviderInstance.validateusernameandpassword(numberController.text,passwordController.text)){
                              if(appProviderInstance.currentcollection!=null && appProviderInstance.startdate!=null && appProviderInstance.enddate!=null){
                                appProviderInstance.startdate=DateTime.now().add(new Duration(days:2));
                                appProviderInstance.enddate=DateTime.now().add(new Duration(days:appProviderInstance.currentcollection.dayss.numodfays+1));
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
}
