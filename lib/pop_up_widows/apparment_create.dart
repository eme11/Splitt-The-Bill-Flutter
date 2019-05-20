import 'package:flutter/material.dart';

class ApartmentCreate extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _ApartmentCreateState();
  }

}

class _ApartmentCreateState extends State<ApartmentCreate>{

  Widget _buildBody(BuildContext context){

  }

  void _submitForm(){

  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0))),
      title: Text('Create'),
      content: _buildBody(context),
      actions: <Widget>[
        FlatButton(
          onPressed: () {
            _submitForm();
          },
          child: Text('ADD'),
        ),
        FlatButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('CANCEL'),
        )
      ],
    );
  }

}