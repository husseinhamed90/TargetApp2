import 'package:flutter/material.dart';
import 'package:target/shared/components.dart';

class ButtonInRemainingDaysPage extends StatefulWidget {

  dynamic nextPage;
  String buttonText;
  ButtonInRemainingDaysPage(this.nextPage,this.buttonText);
  @override
  _ButtonInRemainingDaysPageState createState() => _ButtonInRemainingDaysPageState();
}

class _ButtonInRemainingDaysPageState extends State<ButtonInRemainingDaysPage> {
  @override
  Widget build(BuildContext context) {
    return buildButtonInRemainingDaysPage(context,widget.nextPage,widget.buttonText);
  }
}
