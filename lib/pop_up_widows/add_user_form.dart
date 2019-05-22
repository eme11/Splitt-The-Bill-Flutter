import 'package:flutter/material.dart';

import '../helpers/regular_expressions.dart';
import '../models/user.dart';

class AddUserForm extends StatefulWidget {
  final Function addUser;

  AddUserForm(this.addUser);

  @override
  State<StatefulWidget> createState() {
    return _AddUserFormState();
  }
}

class _AddUserFormState extends State<AddUserForm> {
  String _email = '';
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _buildEmail() {
    return TextFormField(
      decoration: InputDecoration(
          labelText: 'User E-Mail', filled: true, fillColor: Colors.white),
      validator: (String value) {
        if (value.isEmpty || RegularExpressions.isEmail(value)) {
          return 'Invalid e-mail';
        }
      },
      onSaved: (String value) {
        _email = value;
      },
    );
  }

  Widget _buildBody(BuildContext context) {
    return SingleChildScrollView(
      child: Form(key: _formKey, child: _buildEmail()),
    );
  }

  void _submitForm() {
    if (!_formKey.currentState.validate()) {
      return;
    }

    _formKey.currentState.save();
    widget.addUser(User('gggg', 'Emese', 'Mathe', 'Eme', '0740797202', _email));
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0))),
      title: Text('Add User'),
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
