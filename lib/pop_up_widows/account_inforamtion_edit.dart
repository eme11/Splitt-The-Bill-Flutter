import 'package:flutter/material.dart';
import '../helpers/regular_expressions.dart';

class AccountInformationEditWindow extends StatefulWidget {
  final Function update;
  final String title;
  final bool isNumber;
  final String value;

  AccountInformationEditWindow(this.title, this.update,
      {this.isNumber = false, this.value});

  @override
  State<StatefulWidget> createState() {
    return _AccountInformationEditWindowState();
  }
}

class _AccountInformationEditWindowState
    extends State<AccountInformationEditWindow> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _buildInformationField() {
    return TextFormField(
      decoration: InputDecoration(labelText: widget.title),
      initialValue: widget.value,
      validator: (String value) {
        if (widget.isNumber) {
          if (value.isEmpty || RegularExpressions.isPhoneNumber(value)) {
            return 'Input should be a number.';
          }
        } else {
          if (value.isEmpty || value.length < 4) {
            return 'Input too Short';
          }
        }
      },
      onSaved: (String value) {
        int tmp;
        if (widget.isNumber) tmp = int.parse(widget.value);
        widget.update(value);
      },
    );
  }

  Widget _buildBody(context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: _buildInformationField(),
      ),
    );
  }

  void _submitForm() {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    Navigator.of(context).pop();
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
