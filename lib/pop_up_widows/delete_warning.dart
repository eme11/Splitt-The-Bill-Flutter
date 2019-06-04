import 'package:flutter/material.dart';

class DeleteWarningMessage extends StatelessWidget {
  final Function delete;

  DeleteWarningMessage(this.delete);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0))),
      title: Text('Warning'),
      content: Text('All data will be deleted!'),
      actions: <Widget>[
        FlatButton(
          onPressed: () {
            delete();
            Navigator.of(context).pop();
          },
          child: Text('OKAY'),
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
