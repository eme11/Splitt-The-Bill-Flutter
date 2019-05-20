import 'package:flutter/material.dart';

class AccountInformationEditWindow extends StatefulWidget {
  final Function update;
  final String informationKey;

  AccountInformationEditWindow(this.update, this.informationKey);

  @override
  State<StatefulWidget> createState() {
    return _AccountInformationEditWindowState();
  }
}

class _AccountInformationEditWindowState extends State<AccountInformationEditWindow>{

  Widget _buildBody(context){
    return Container();
  }

  void _submitForm(){

  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0))),
      title: Text('Edit'),
      content: _buildBody(context),
      actions: <Widget>[
        FlatButton(
          onPressed: () {
            _submitForm();
          },
          child: Text('UPDATE'),
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