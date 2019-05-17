import 'package:flutter/material.dart';

class CleaningSuppliesForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CleaningSuppliesFormState();
  }
}

class _CleaningSuppliesFormState extends State<CleaningSuppliesForm> {
  Widget _buildBody(BuildContext context) {
    return Container();
  }

  void _submitForm() {}

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
