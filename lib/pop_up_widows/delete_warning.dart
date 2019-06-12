import 'package:flutter/material.dart';
import '../models/user.dart';

class DeleteWarningMessage extends StatelessWidget {
  final Function delete;
  final User information;
  final Function deleteAid;
  final bool isUserDeletion;

  DeleteWarningMessage(this.delete,
      {this.information, this.deleteAid, this.isUserDeletion = false});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0))),
      title: Text('Warning'),
      content: isUserDeletion ? Text('The user will be deleted') : Text('All data will be deleted!'),
      actions: <Widget>[
        FlatButton(
          onPressed: () {
            isUserDeletion? delete(information, deleteAid) : delete();
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
