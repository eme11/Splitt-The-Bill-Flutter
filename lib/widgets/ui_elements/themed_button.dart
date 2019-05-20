import 'package:flutter/material.dart';

class ThemedButton extends StatelessWidget{
  final Function pressed;
  final String text;

  ThemedButton(this.pressed, this.text);
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: pressed,
      color: Theme.of(context).primaryColor,
      textColor: Colors.white,
      child: Text(text),
    );
  }

}