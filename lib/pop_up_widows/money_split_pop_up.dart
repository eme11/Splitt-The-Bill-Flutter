import 'package:flutter/material.dart';

class MoneySplitPopUp extends StatelessWidget {
  Widget _buildBody() {
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0))),
      title: Text('Money Split'),
      content: _buildBody(),
      actions: <Widget>[
        FlatButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('OKAY'),
        ),
        FlatButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('SPLIT'),
        )
      ],
    );
  }
}
