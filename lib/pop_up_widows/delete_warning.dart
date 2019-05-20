import 'package:flutter/material.dart';

class DeleteWarningMessage extends StatelessWidget{
  final Function delete;

  DeleteWarningMessage(this.delete);
  
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0))),
      title: Text('Delete'),
      content: Text('Are you sure you want to delete this?'),
      actions: <Widget>[
        FlatButton(
          onPressed: delete,
          child: Text('DELETE'),
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