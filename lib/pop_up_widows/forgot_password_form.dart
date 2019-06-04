import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../helpers/regular_expressions.dart';
import '../scoped_models/main_model.dart';

class ForgotPasswordForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ForgotPasswordFormState();
  }
}

class _ForgotPasswordFormState extends State<ForgotPasswordForm> {
  String _email = '';
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _buildEmail() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'User E-Mail',),
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
    MainModel model = ScopedModel.of(context);
    model.resetPassword(_email);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0))),
      title: Text('Reset Password'),
      content: _buildBody(context),
      actions: <Widget>[
        FlatButton(
          onPressed: () {
            _submitForm();
          },
          child: Text('RESET'),
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
