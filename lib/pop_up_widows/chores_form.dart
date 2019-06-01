import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import '../helpers/regular_expressions.dart';

import '../models/chores.dart';
import '../scoped_models/main_model.dart';

class ChoresForm extends StatefulWidget {
  final Function addChore;

  ChoresForm(this.addChore);

  @override
  State<StatefulWidget> createState() {
    return _ChoresFormState();
  }
}

class _ChoresFormState extends State<ChoresForm> {
  List<DropdownMenuItem<String>> _type = [];
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Chore _formData = Chore('', '', 3);

  Widget _buildName() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Name',
      ),
      validator: (String value) {
        if (value.isEmpty || value.length < 6) {
          return 'Name too short';
        }
      },
      onSaved: (String value) {
        _formData.name = value;
      },
    );
  }

  Widget _buildDescription() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Descrition',
      ),
      validator: (String value) {
        if (value.isEmpty || value.length < 10) {
          return 'Descrition too short';
        }
      },
      onSaved: (String value) {
        _formData.description = value;
      },
    );
  }

  Widget _buildSizedBox() {
    return SizedBox(
      height: 10.0,
    );
  }

  Widget _buildBody(BuildContext build) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            _buildName(),
            _buildSizedBox(),
            _buildDescription()
          ],
        ),
      ),
    );
  }

  void _submitForm(String uid) {
    if (!_formKey.currentState.validate()) {
      return;
    }

    _formData.setCurrentAssigneeId(uid);
    _formData.setApartmentId('sfsdrfer');
    _formKey.currentState.save();
    widget.addChore(_formData);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
        builder: (BuildContext context, Widget child, MainModel model) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(25.0))),
        title: Text('Create'),
        content: _buildBody(context),
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              _submitForm(model.uid);
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
    });
  }
}
