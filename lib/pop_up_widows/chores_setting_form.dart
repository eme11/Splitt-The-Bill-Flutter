import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import '../helpers/regular_expressions.dart';

import '../scoped_models/main_model.dart';

class ChoresSettingsForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ChoresSettingsFormState();
  }
}

class _ChoresSettingsFormState extends State<ChoresSettingsForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Map<String, int> _formData = {'interval': 7};

  Widget _buildChangingInterval() {
    return TextFormField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(labelText: 'Changing Interval'),
      initialValue:
          _formData['interval'] == null ? '' : _formData['interval'].toString(),
      validator: (String value) {
        if (value.isEmpty || RegularExpressions.isInteger(value)) {
          return 'Input should be a number.';
        }
      },
      onSaved: (String value) {
        _formData['interval'] = int.parse(value);
      },
    );
  }

  Widget _buildBody(BuildContext build) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[_buildChangingInterval()],
        ),
      ),
    );
  }

  void _submitForm(Function change, String aid) async {
    if (!_formKey.currentState.validate()) {
      return;
    }

    _formKey.currentState.save();
    await change(aid, _formData['interval']).then(Navigator.of(context).pop());
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
        builder: (BuildContext context, Widget child, MainModel model) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(25.0))),
        title: Text('Settings'),
        content: _buildBody(context),
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              _submitForm(model.changeChoreInterval, model.currentApartmnet.id);
            },
            child: Text('CHANGE'),
          ),
          FlatButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('CANCEL'),
          )
        ],
      );
    });
  }
}
